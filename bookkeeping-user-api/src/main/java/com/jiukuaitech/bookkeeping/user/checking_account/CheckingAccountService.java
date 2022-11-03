package com.jiukuaitech.bookkeeping.user.checking_account;

import com.jiukuaitech.bookkeeping.user.account.*;
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
public class CheckingAccountService {

    @Resource
    private UserService userService;

    @Resource
    private CheckingAccountRepository checkingAccountRepository;

    @Resource
    private CurrencyService currencyService;

    public Page<AccountVOForExtend> query(AccountQueryRequest request, Pageable page, Integer userSignInId) {
        Group group = userService.getUser(userSignInId).getDefaultGroup();
        Specification<CheckingAccount> specification = AccountSpec.buildSpecification(request, group);
        Page<CheckingAccount> poPage = checkingAccountRepository.findAll(specification, page);
        Page<AccountVOForExtend> voPage = poPage.map(AccountVOForExtend::fromEntity);
        voPage.map(vo->{
            vo.setConvertedBalance(currencyService.convert(vo.getBalance(), vo.getCurrencyCode(), group.getDefaultCurrencyCode()));
            return vo;
        });
        return voPage;
    }

    public AccountSumVO sum(Integer userSignInId) {
        AccountSumVO vo = new AccountSumVO();
        Group group = userService.getUser(userSignInId).getDefaultGroup();
        List<CheckingAccount> accounts = checkingAccountRepository.findAll(AccountSpec.inGroupAndEnable(group));
        BigDecimal balance = BigDecimal.ZERO;
        for (int i = 0; i < accounts.size(); i++) {
            Account account = accounts.get(i);
            balance = balance.add(currencyService.convert(account.getBalance(), account.getCurrencyCode(), group.getDefaultCurrencyCode()));
        }
        vo.setBalance(balance);
        return vo;
    }

}
