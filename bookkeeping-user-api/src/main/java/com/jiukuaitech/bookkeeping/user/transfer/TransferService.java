package com.jiukuaitech.bookkeeping.user.transfer;

import com.jiukuaitech.bookkeeping.user.account.Account;
import com.jiukuaitech.bookkeeping.user.account.AccountRepository;
import com.jiukuaitech.bookkeeping.user.balance_flow.AccountInvalidateException;
import com.jiukuaitech.bookkeeping.user.balance_flow.BalanceFlowQueryRequest;
import com.jiukuaitech.bookkeeping.user.balance_flow.StatusNotValidateException;
import com.jiukuaitech.bookkeeping.user.book.Book;
import com.jiukuaitech.bookkeeping.user.exception.ItemNotFoundException;
import com.jiukuaitech.bookkeeping.user.group.Group;
import com.jiukuaitech.bookkeeping.user.tag.TagRepository;
import com.jiukuaitech.bookkeeping.user.user.User;
import com.jiukuaitech.bookkeeping.user.user.UserService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.math.BigDecimal;

@Service
public class TransferService {

    @Resource
    private UserService userService;

    @Resource
    private AccountRepository accountRepository;

    @Resource
    private TransferRepository transferRepository;

    @Resource
    private TagRepository tagRepository;

    @Transactional
    public boolean add(TransferAddRequest request, Integer userSignInId) {
        // 转出和转入不能相同
        if (request.getFromId().equals(request.getToId())) {
            throw new TransferFromEqualsToException();
        }
        User user = userService.getUser(userSignInId);
        Group group = user.getDefaultGroup();
        Book book = user.getDefaultBook();

        Account fromAccount = accountRepository.findOneByGroupAndId(group, request.getFromId()).orElseThrow(AccountInvalidateException::new);
        Account toAccount = accountRepository.findOneByGroupAndId(group, request.getToId()).orElseThrow(AccountInvalidateException::new);

        Transfer po = new Transfer();
        request.copyPrimitive(po);
        if (request.getConvertedAmount() != null) {
            po.setConvertedAmount(request.getConvertedAmount());
        } else {
            po.setConvertedAmount(request.getAmount());
        }
        po.setCreator(user);
        po.setGroup(user.getDefaultGroup());
        po.setBook(user.getDefaultBook());
        request.copyTags(po, tagRepository.findByBookAndEnable(book, true));
        po.setAccount(fromAccount);
        po.setTo(toAccount);
        transferRepository.save(po);
        // 正常状态才改变账户余额
        if (request.getConfirmed()) {
            confirmBalance(po);
        }
        return true;
    }

    // 退款
    private void refundBalance(Transfer transfer) {
        Account fromAccount = transfer.getAccount();
        Account toAccount = transfer.getTo();
        BigDecimal amount = transfer.getAmount();
        fromAccount.setBalance(fromAccount.getBalance().add(amount));
        toAccount.setBalance(toAccount.getBalance().subtract(amount));
        accountRepository.save(fromAccount);
        accountRepository.save(toAccount);
    }

    // 扣款
    private void confirmBalance(Transfer po) {
        Account fromAccount = po.getAccount();
        Account toAccount = po.getTo();
        BigDecimal amount = po.getAmount();
        BigDecimal convertedAmount = po.getConvertedAmount();
        fromAccount.setBalance(fromAccount.getBalance().subtract(amount));
        toAccount.setBalance(toAccount.getBalance().add(convertedAmount));
        accountRepository.save(fromAccount);
        accountRepository.save(toAccount);
    }

    public TransferQueryResultVO queryWithDefaultBook(BalanceFlowQueryRequest request, Pageable page, Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        request.setBookId(user.getDefaultBook().getId());
        return query(request, page, userSignInId);
    }

    public TransferQueryResultVO query(BalanceFlowQueryRequest request, Pageable page, Integer userSignInId) {
        TransferQueryResultVO result = new TransferQueryResultVO();
        Specification<Transfer> specification = TransferSpec.buildSpecification(request, userService.getUser(userSignInId).getDefaultGroup());
        Page<Transfer> poPage = transferRepository.findAll(specification, page);
        Page<TransferVOForList> voPage = poPage.map(transfer -> {
            TransferVOForList vo = TransferVOForList.fromEntity(transfer);
            vo.setCurrencyCode(transfer.getAccount().getCurrencyCode());
            vo.setNeedConvert(!transfer.getAccount().getCurrencyCode().equals(transfer.getTo().getCurrencyCode()));
            vo.setToCurrencyCode(transfer.getTo().getCurrencyCode());
            return vo;
        });
        result.setResult(voPage);
        // 解决join查询重复问题，应该考虑子查询
        if (CollectionUtils.isEmpty(request.getTags())) {
            result.setTotal(transferRepository.calcAggregate(specification, Transfer_.convertedAmount, Transfer.class));
        } else {
            result.setTotal(transferRepository.findAll(specification).stream().map(Transfer::getConvertedAmount).reduce(BigDecimal.ZERO, BigDecimal::add));
        }
        return result;
    }

    @Transactional
    public boolean remove(Integer id, Integer userSignInId) {
        Book book = userService.getUser(userSignInId).getDefaultBook();
        Transfer po = transferRepository.findOneByBookAndId(book, id).orElseThrow(ItemNotFoundException::new);
        // 只有正常状态的需要退款，未确认和已退款不需要
        if (po.getStatus() == 1) {
            refundBalance(po);
        }
        transferRepository.delete(po);
        return true;
    }

    @Transactional
    public boolean confirm(Integer id, Integer userSignInId) {
        Book book = userService.getUser(userSignInId).getDefaultBook();
        Transfer po = transferRepository.findOneByBookAndId(book, id).orElseThrow(ItemNotFoundException::new);
        if (po.getStatus() != 2) {
            throw new StatusNotValidateException();
        }
        confirmBalance(po);
        po.setStatus(1);
        transferRepository.save(po);
        return true;
    }

    @Transactional
    public boolean update(Integer id, TransferUpdateRequest request, Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        Book book = user.getDefaultBook();
        Group group = user.getDefaultGroup();
        Transfer po = transferRepository.findOneByBookAndId(book, id).orElseThrow(ItemNotFoundException::new);
        if (!po.getAccount().getId().equals(request.getFromId()) || !po.getTo().getId().equals(request.getToId()) ||
                (request.getAmount() != null && po.getAmount().compareTo(request.getAmount()) != 0) ||
                (request.getConvertedAmount() != null && po.getConvertedAmount().compareTo(request.getConvertedAmount()) != 0)) {
            if (po.getStatus() == 1) {
                refundBalance(po);
            }
            Account fromAccount = accountRepository.findOneByGroupAndId(group, request.getFromId()).orElseThrow(AccountInvalidateException::new);
            Account toAccount = accountRepository.findOneByGroupAndId(group, request.getToId()).orElseThrow(AccountInvalidateException::new);
            // 转出和转入不能相同
            if (fromAccount.getId().equals(toAccount.getId())) throw new TransferFromEqualsToException();
            po.setAccount(fromAccount);
            po.setTo(toAccount);
            po.setAmount(request.getAmount());
            if (request.getConvertedAmount() != null) {
                if (!fromAccount.getCurrencyCode().equals(toAccount.getCurrencyCode())) {
                    po.setConvertedAmount(request.getConvertedAmount());
                }
            } else {
                po.setConvertedAmount(request.getAmount());
            }
            if (po.getStatus() == 1) {
                confirmBalance(po);
            }
        }
        request.updatePrimitive(po);
        request.updateTags(po, tagRepository.findByBookAndEnable(book, true));
        transferRepository.save(po);
        return true;
    }

}
