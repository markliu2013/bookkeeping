package com.jiukuaitech.bookkeeping.user.credit_account;

import com.jiukuaitech.bookkeeping.user.account.AccountQueryRequest;
import com.jiukuaitech.bookkeeping.user.account.AccountSpec;
import com.jiukuaitech.bookkeeping.user.currency.CurrencyService;
import com.jiukuaitech.bookkeeping.user.group.Group;
import com.jiukuaitech.bookkeeping.user.user.UserService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.List;

@Service
public class CreditAccountService {

    @Resource
    private UserService userService;

    @Resource
    private CreditAccountRepository creditAccountRepository;

    @Resource
    private CurrencyService currencyService;

    public Page<CreditAccountVOForList> query(AccountQueryRequest request, Pageable page, Integer userSignInId) {
        Group group = userService.getUser(userSignInId).getDefaultGroup();
        Specification<CreditAccount> specification = AccountSpec.buildSpecification(request, group);
        Page<CreditAccount> poPage = creditAccountRepository.findAll(specification, page);
        Page<CreditAccountVOForList> voPage = poPage.map(CreditAccountVOForList::fromEntity);
        voPage.map(vo->{
            vo.setConvertedBalance(currencyService.convert(vo.getBalance(), vo.getCurrencyCode(), group.getDefaultCurrencyCode()));
            return vo;
        });
        return voPage;
    }

    public CreditAccountSumVO sum(Integer userSignInId) {
        CreditAccountSumVO vo = new CreditAccountSumVO();
        Group group = userService.getUser(userSignInId).getDefaultGroup();
        List<CreditAccount> accounts = creditAccountRepository.findAll(AccountSpec.inGroupAndEnable(group));
        BigDecimal balance = BigDecimal.ZERO;
        BigDecimal limit = BigDecimal.ZERO;
        for (int i = 0; i < accounts.size(); i++) {
            CreditAccount account = accounts.get(i);
            balance = balance.add(currencyService.convert(account.getBalance(), account.getCurrencyCode(), group.getDefaultCurrencyCode()));
            limit = limit.add(currencyService.convert(account.getLimit(), account.getCurrencyCode(), group.getDefaultCurrencyCode()));
        }
        vo.setBalance(balance);
        vo.setLimit(limit);
        return vo;
    }

}
