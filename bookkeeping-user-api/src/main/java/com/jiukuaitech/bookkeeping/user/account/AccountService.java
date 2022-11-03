package com.jiukuaitech.bookkeeping.user.account;

import com.jiukuaitech.bookkeeping.user.adjust_balance.AdjustBalance;
import com.jiukuaitech.bookkeeping.user.adjust_balance.AdjustBalanceAddRequest;
import com.jiukuaitech.bookkeeping.user.adjust_balance.AdjustBalanceRepository;
import com.jiukuaitech.bookkeeping.user.asset_account.AssetAccount;
import com.jiukuaitech.bookkeeping.user.book.Book;
import com.jiukuaitech.bookkeeping.user.checking_account.CheckingAccount;
import com.jiukuaitech.bookkeeping.user.credit_account.CreditAccount;
import com.jiukuaitech.bookkeeping.user.debt_account.DebtAccount;
import com.jiukuaitech.bookkeeping.user.group.Group;
import com.jiukuaitech.bookkeeping.user.user.User;
import com.jiukuaitech.bookkeeping.user.credit_account.CreditAccountAddRequest;
import com.jiukuaitech.bookkeeping.user.currency.CurrencyService;
import com.jiukuaitech.bookkeeping.user.debt_account.DebtAccountAddRequest;
import com.jiukuaitech.bookkeeping.user.exception.ItemNotFoundException;
import com.jiukuaitech.bookkeeping.user.transaction.TransactionRepository;
import com.jiukuaitech.bookkeeping.user.transfer.TransferRepository;
import com.jiukuaitech.bookkeeping.user.user.UserService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class AccountService {

    @Resource
    private UserService userService;

    @Resource
    private AccountRepository accountRepository;
    
    @Resource
    private AdjustBalanceRepository adjustBalanceRepository;

    @Resource
    private TransactionRepository transactionRepository;

    @Resource
    private TransferRepository transferRepository;

    @Resource
    private CurrencyService currencyService;

    public List<AccountVOForExtend> getEnable(Integer userSignInId) {
        Group group = userService.getUser(userSignInId).getDefaultGroup();
        List<Account> entityList = accountRepository.findAll(AccountSpec.inGroupAndEnable(group));
        return entityList.stream().map(AccountVOForExtend::fromEntity).collect(Collectors.toList());
    }

    public List<AccountVOForExtend> getAllExpenseable(Integer userSignInId) {
        Group group = userService.getUser(userSignInId).getDefaultGroup();
        List<Account> entityList = accountRepository.findAll(AccountSpec.inGroupAndExpenseable(group));
        return entityList.stream().map(AccountVOForExtend::fromEntity).collect(Collectors.toList());
    }
    
    public List<AccountVOForExtend> getAllIncomeable(Integer userSignInId) {
        Group group = userService.getUser(userSignInId).getDefaultGroup();
        List<Account> entityList = accountRepository.findAll(AccountSpec.inGroupAndIncomeable(group));
        return entityList.stream().map(AccountVOForExtend::fromEntity).collect(Collectors.toList());
    }

    public List<AccountVOForExtend> getAllTransferFromAble(Integer userSignInId) {
        Group group = userService.getUser(userSignInId).getDefaultGroup();
        List<Account> entityList = accountRepository.findAll(AccountSpec.inGroupAndTransferFromAble(group));
        return entityList.stream().map(AccountVOForExtend::fromEntity).collect(Collectors.toList());
    }
    
    public List<AccountVOForExtend> getAllTransferToAble(Integer userSignInId) {
        Group group = userService.getUser(userSignInId).getDefaultGroup();
        List<Account> entityList = accountRepository.findAll(AccountSpec.inGroupAndTransferToAble(group));
        return entityList.stream().map(AccountVOForExtend::fromEntity).collect(Collectors.toList());
    }

    public AccountVOForList get(Integer id, Integer userSignInId) {
        Group group = userService.getUser(userSignInId).getDefaultGroup();
        Account po = accountRepository.findOneByGroupAndId(group, id).orElseThrow(ItemNotFoundException::new);
        AccountVOForList vo = new AccountVOForList();
        vo.setValue(po);
        vo.setConvertedBalance(currencyService.convert(vo.getBalance(), vo.getCurrencyCode(), group.getDefaultCurrencyCode()));
        if (po instanceof CreditAccount) {
            CreditAccount po2 = (CreditAccount) po;
            vo.setLimit(po2.getLimit());
            vo.setBillDay(po2.getBillDay());
        }
        if (po instanceof DebtAccount) {
            DebtAccount po2 = (DebtAccount) po;
            vo.setApr(po2.getApr());
            vo.setLimit(po2.getLimit());
        }
        if (po instanceof AssetAccount) {
            AssetAccount po2 = (AssetAccount) po;
            vo.setAsOfDate(po2.getAsOfDate());
        }
        return vo;
    }

    @Transactional
    public AccountVOForExtend adjustBalance(Integer id, AdjustBalanceAddRequest request, Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        Group group = user.getDefaultGroup();
        Account account = accountRepository.findOneByGroupAndId(group, id).orElseThrow(ItemNotFoundException::new);
        if (account.getBalance().compareTo(request.getBalance()) == 0) {
            throw new AccountAdjustBalanceNotValidException();
        }
        BigDecimal adjustAmount = request.getBalance().subtract(account.getBalance());
        account.setBalance(request.getBalance());
        // 如果是资产账户改一下截止日期
        if (account instanceof AssetAccount) {
            AssetAccount assetAccount = (AssetAccount) account;
            assetAccount.setAsOfDate(request.getCreateTime());
        }
        accountRepository.save(account);

        AdjustBalance po = new AdjustBalance();
        request.copyPrimitive(po);
        po.setCreator(user);
        po.setBook(user.getDefaultBook());
        po.setGroup(user.getDefaultGroup());
        po.setAmount(adjustAmount);
        po.setAccount(account);
        po.setStatus(1);

        adjustBalanceRepository.save(po);
        return AccountVOForExtend.fromEntity(po.getAccount());
    }

    // 1. 余额调整记录删除，2. 日志删除
    @Transactional
    public AccountVOForExtend remove(Integer id, Integer userSignInId) {
        Group group = userService.getUser(userSignInId).getDefaultGroup();
        Account po = accountRepository.findOneByGroupAndId(group, id).orElseThrow(ItemNotFoundException::new);
        // 检查关联性，有账单关联的不能删除
        if (transactionRepository.countByAccount_id(id) > 0 || transferRepository.countByTo_id(id) > 0) {
            throw new AccountHasTransactionException();
        }
        adjustBalanceRepository.deleteByAccount_Id(id);
        accountRepository.delete(po);
        return AccountVOForExtend.fromEntity(po);
    }

    public AccountVOForExtend toggle(Integer id, Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        Group group = user.getDefaultGroup();
        Account po = accountRepository.findOneByGroupAndId(group, id).orElseThrow(ItemNotFoundException::new);
        Book book = user.getDefaultBook();
        if (po.equals(book.getDefaultExpenseAccount())) throw new DefaultExpenseAccountException();
        if (po.equals(book.getDefaultIncomeAccount())) throw new DefaultIncomeAccountException();
        po.setEnable(!po.getEnable());
        accountRepository.save(po);
        return AccountVOForExtend.fromEntity(accountRepository.save(po));
    }

    public boolean toggleInclude(Integer id, Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        Group group = user.getDefaultGroup();
        Account po = accountRepository.findOneByGroupAndId(group, id).orElseThrow(ItemNotFoundException::new);
        po.setInclude(!po.getInclude());
        accountRepository.save(po);
        return true;
    }

    public boolean toggleExpenseable(Integer id, Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        Group group = user.getDefaultGroup();
        Account po = accountRepository.findOneByGroupAndId(group, id).orElseThrow(ItemNotFoundException::new);
        Book book = user.getDefaultBook();
        if (po.equals(book.getDefaultExpenseAccount())) throw new DefaultExpenseAccountException();
        po.setExpenseable(!po.getExpenseable());
        accountRepository.save(po);
        return true;
    }

    public boolean toggleIncomeable(Integer id, Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        Group group = user.getDefaultGroup();
        Account po = accountRepository.findOneByGroupAndId(group, id).orElseThrow(ItemNotFoundException::new);
        Book book = user.getDefaultBook();
        if (po.equals(book.getDefaultIncomeAccount())) throw new DefaultIncomeAccountException();
        po.setIncomeable(!po.getIncomeable());
        accountRepository.save(po);
        return true;
    }

    public boolean toggleTransferFromAble(Integer id, Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        Group group = user.getDefaultGroup();
        Account po = accountRepository.findOneByGroupAndId(group, id).orElseThrow(ItemNotFoundException::new);
        Book book = user.getDefaultBook();
        if (po.equals(book.getDefaultTransferFromAccount())) throw new DefaultTransferFromAccountException();
        po.setTransferFromAble(!po.getTransferFromAble());
        accountRepository.save(po);
        return true;
    }

    public boolean toggleTransferToAble(Integer id, Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        Group group = user.getDefaultGroup();
        Account po = accountRepository.findOneByGroupAndId(group, id).orElseThrow(ItemNotFoundException::new);
        Book book = user.getDefaultBook();
        if (po.equals(book.getDefaultTransferToAccount())) throw new DefaultTransferToAccountException();
        po.setTransferToAble(!po.getTransferToAble());
        accountRepository.save(po);
        return true;
    }

    public boolean add(Integer type, AccountAddRequest request, Integer userSignInId) {
        Group group = userService.getUser(userSignInId).getDefaultGroup();
        if (accountRepository.findOneByGroupAndName(group, request.getName()).isPresent()) {
            throw new AccountNameExistsException();
        }
        currencyService.checkCode(request.getCurrencyCode());
        Account po = null;
        switch (type) {
            case 1:
                po = new CheckingAccount();
                request.copyPrimitive(po);
                break;
            case 2:
                po = new CreditAccount();
                ((CreditAccountAddRequest) request).copyPrimitive((CreditAccount) po);
                break;
            case 3:
                po = new DebtAccount();
                ((DebtAccountAddRequest) request).copyPrimitive((DebtAccount) po);
                break;
            case 4:
                po = new AssetAccount();
                request.copyPrimitive(po);
                ((AssetAccount)po).setAsOfDate(System.currentTimeMillis());
                break;
        }
        po.setGroup(group);
        accountRepository.save(po);
        return true;
    }

    public AccountVOForExtend update(Integer id, AccountUpdateRequest request, Integer userSignInId) {
        Group group = userService.getUser(userSignInId).getDefaultGroup();
        Account po = accountRepository.findOneByGroupAndId(group, id).orElseThrow(ItemNotFoundException::new);
        if (StringUtils.hasText(request.getName())) {
            if (!po.getName().equals(request.getName())) {
                if (accountRepository.findOneByGroupAndName(group, request.getName()).isPresent()) {
                    throw new AccountNameExistsException();
                }
            }
        }
        request.updatePrimitive(po);
        accountRepository.save(po);
        return AccountVOForExtend.fromEntity(po);
    }

}
