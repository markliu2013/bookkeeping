package com.jiukuaitech.bookkeeping.user.asset_account;

import com.jiukuaitech.bookkeeping.user.account.Account;
import com.jiukuaitech.bookkeeping.user.account.AccountQueryRequest;
import com.jiukuaitech.bookkeeping.user.account.AccountSpec;
import com.jiukuaitech.bookkeeping.user.currency.CurrencyService;
import com.jiukuaitech.bookkeeping.user.group.Group;
import com.jiukuaitech.bookkeeping.user.user.UserService;
import com.jiukuaitech.bookkeeping.user.account.AccountSumVO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.List;

@Service
public class AssetAccountService {

    @Resource
    private UserService userService;

    @Resource
    private AssetAccountRepository assetAccountRepository;

    @Resource
    private CurrencyService currencyService;

    public Page<AssetAccountVOForList> query(AccountQueryRequest request, Pageable page, Integer userSignInId) {
        Group group = userService.getUser(userSignInId).getDefaultGroup();
        Specification<AssetAccount> specification = AccountSpec.buildSpecification(request, group);
        Page<AssetAccount> poPage = assetAccountRepository.findAll(specification, page);
        Page<AssetAccountVOForList> voPage = poPage.map(AssetAccountVOForList::fromEntity);
        voPage.map(vo->{
            vo.setConvertedBalance(currencyService.convert(vo.getBalance(), vo.getCurrencyCode(), group.getDefaultCurrencyCode()));
            return vo;
        });
        return voPage;
    }

    public AccountSumVO sum(Integer userSignInId) {
        AccountSumVO vo = new AccountSumVO();
        Group group = userService.getUser(userSignInId).getDefaultGroup();
        List<AssetAccount> accounts = assetAccountRepository.findAll(AccountSpec.inGroupAndEnable(group));
        BigDecimal balance = BigDecimal.ZERO;
        for (int i = 0; i < accounts.size(); i++) {
            Account account = accounts.get(i);
            balance = balance.add(currencyService.convert(account.getBalance(), account.getCurrencyCode(), group.getDefaultCurrencyCode()));
        }
        vo.setBalance(balance);
        return vo;
    }

}
