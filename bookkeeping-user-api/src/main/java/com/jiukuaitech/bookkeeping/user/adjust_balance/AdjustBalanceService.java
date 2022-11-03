package com.jiukuaitech.bookkeeping.user.adjust_balance;

import com.jiukuaitech.bookkeeping.user.account.Account;
import com.jiukuaitech.bookkeeping.user.account.AccountRepository;
import com.jiukuaitech.bookkeeping.user.account.AccountVOForExtend;
import com.jiukuaitech.bookkeeping.user.book.Book;
import com.jiukuaitech.bookkeeping.user.user.User;
import com.jiukuaitech.bookkeeping.user.user.UserService;
import com.jiukuaitech.bookkeeping.user.balance_flow.BalanceFlowUpdateRequest;
import com.jiukuaitech.bookkeeping.user.exception.ItemNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

@Service
public class AdjustBalanceService {

    @Resource
    private UserService userService;

    @Resource
    private AccountRepository accountRepository;

    @Resource
    private AdjustBalanceRepository adjustBalanceRepository;

    @Transactional
    public AccountVOForExtend remove(Integer id, Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        AdjustBalance po = adjustBalanceRepository.findOneByBookAndId(user.getDefaultBook(), id).orElseThrow(ItemNotFoundException::new);
        // 处理退款
        Account account = po.getAccount();
        account.setBalance(account.getBalance().subtract(po.getAmount()));
        accountRepository.save(account);
        adjustBalanceRepository.delete(po);
        return AccountVOForExtend.fromEntity(po.getAccount());
    }

    public boolean update(Integer id, BalanceFlowUpdateRequest request, Integer userSignInId) {
        Book book = userService.getUser(userSignInId).getDefaultBook();
        AdjustBalance po = adjustBalanceRepository.findOneByBookAndId(book, id).orElseThrow(ItemNotFoundException::new);
        request.updatePrimitive(po);
        adjustBalanceRepository.save(po);
        return true;
    }

}
