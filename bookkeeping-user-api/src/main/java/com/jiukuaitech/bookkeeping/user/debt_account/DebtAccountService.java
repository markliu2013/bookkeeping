package com.jiukuaitech.bookkeeping.user.debt_account;

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
public class DebtAccountService {

    @Resource
    private UserService userService;

    @Resource
    private DebtAccountRepository debtAccountRepository;

    @Resource
    private CurrencyService currencyService;

    public Page<DebtAccountVOForList> query(AccountQueryRequest request, Pageable page, Integer userSignInId) {
        Group group = userService.getUser(userSignInId).getDefaultGroup();
        Specification<DebtAccount> specification = AccountSpec.buildSpecification(request, group);
        Page<DebtAccount> poPage = debtAccountRepository.findAll(specification, page);
        Page<DebtAccountVOForList> voPage = poPage.map(DebtAccountVOForList::fromEntity);
        voPage.map(vo->{
            vo.setConvertedBalance(currencyService.convert(vo.getBalance(), vo.getCurrencyCode(), group.getDefaultCurrencyCode()));
            return vo;
        });
        return voPage;
    }

    public DebtAccountSumVO sum(Integer userSignInId) {
        DebtAccountSumVO vo = new DebtAccountSumVO();
        Group group = userService.getUser(userSignInId).getDefaultGroup();
        List<DebtAccount> accounts = debtAccountRepository.findAll(AccountSpec.inGroupAndEnable(group));
        BigDecimal balance = BigDecimal.ZERO;
        BigDecimal limit = BigDecimal.ZERO;
        BigDecimal remainLimit = BigDecimal.ZERO;
        for (int i = 0; i < accounts.size(); i++) {
            DebtAccount account = accounts.get(i);
            balance = balance.add(currencyService.convert(account.getBalance(), account.getCurrencyCode(), group.getDefaultCurrencyCode()));
            if (account.getLimit() != null) {
                limit = limit.add(currencyService.convert(account.getLimit(), account.getCurrencyCode(), group.getDefaultCurrencyCode()));
            }
            DebtAccountVOForList debtAccountVOForList = DebtAccountVOForList.fromEntity(account);
            if (debtAccountVOForList.getLimit() != null) {
                remainLimit = remainLimit.add(debtAccountVOForList.getRemainLimit());
            }
        }
        vo.setBalance(balance);
        vo.setLimit(limit);
        vo.setRemainLimit(remainLimit);
        return vo;
    }

}
