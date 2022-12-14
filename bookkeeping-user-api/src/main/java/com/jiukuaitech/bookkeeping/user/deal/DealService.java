package com.jiukuaitech.bookkeeping.user.deal;

import com.jiukuaitech.bookkeeping.user.account.Account;
import com.jiukuaitech.bookkeeping.user.balance_flow.AccountInvalidateException;
import com.jiukuaitech.bookkeeping.user.balance_flow.StatusNotValidateException;
import com.jiukuaitech.bookkeeping.user.book.Book;
import com.jiukuaitech.bookkeeping.user.category.CategoryRepository;
import com.jiukuaitech.bookkeeping.user.category_relation.CategoryRelationAddRequest;
import com.jiukuaitech.bookkeeping.user.expense.Expense;
import com.jiukuaitech.bookkeeping.user.flow_images.FlowImageRepository;
import com.jiukuaitech.bookkeeping.user.income.Income;
import com.jiukuaitech.bookkeeping.user.payee.Payee;
import com.jiukuaitech.bookkeeping.user.payee.PayeeRepository;
import com.jiukuaitech.bookkeeping.user.refund.Refund;
import com.jiukuaitech.bookkeeping.user.refund.RefundRepository;
import com.jiukuaitech.bookkeeping.user.tag.TagRepository;
import com.jiukuaitech.bookkeeping.user.user.User;
import com.jiukuaitech.bookkeeping.user.user.UserService;
import com.jiukuaitech.bookkeeping.user.account.AccountRepository;
import com.jiukuaitech.bookkeeping.user.balance_flow.AmountInvalidateException;
import com.jiukuaitech.bookkeeping.user.exception.InputNotValidException;
import com.jiukuaitech.bookkeeping.user.exception.ItemNotFoundException;
import com.jiukuaitech.bookkeeping.user.user_log.UserActionLog;
import com.jiukuaitech.bookkeeping.user.user_log.UserActionLogRepository;
import com.jiukuaitech.bookkeeping.user.user_log.UserActionLogService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import javax.annotation.Resource;
import java.math.BigDecimal;
import java.time.Instant;

@Service
public class DealService {

    @Resource
    private UserService userService;

    @Resource
    private AccountRepository accountRepository;

    @Resource
    private DealRepository dealRepository;

    @Resource
    private FlowImageRepository dealImageRepository;

    @Resource
    private RefundRepository refundRepository;

    @Resource
    private PayeeRepository payeeRepository;

    @Resource
    private TagRepository tagRepository;

    @Resource
    private CategoryRepository categoryRepository;

    @Resource
    private UserActionLogRepository userActionLogRepository;

    @Resource
    private UserActionLogService userActionLogService;

    @Transactional
    // ????????????amount??????????????????????????????amount???????????????
    public Deal add(Integer type, DealAddRequest request, Integer userSignInId, boolean refundFlag) {
        //??????Category???????????????
        CategoryRelationAddRequest.checkCategory(request.getCategories());
        User user = userService.getUser(userSignInId);
        // ?????????????????????????????????????????????
        userActionLogService.check(user);
        Book book = user.getDefaultBook();
        Deal po = null;
        if (type == 1) {
            po = new Expense();
        } else if (type == 2) {
            po = new Income();
        }
        BigDecimal amount = request.getCategories().stream().map(CategoryRelationAddRequest::getAmount).reduce(BigDecimal.ZERO, BigDecimal::add);
        if (refundFlag && amount.compareTo(BigDecimal.ZERO) > 0) {
            throw new AmountInvalidateException();
        }
        if (!refundFlag && amount.compareTo(BigDecimal.ZERO) < 0) {
            throw new AmountInvalidateException();
        }
        po.setAmount(amount);
        Account account = accountRepository.findOneByGroupAndId(user.getDefaultGroup(), request.getAccountId()).orElseThrow(AccountInvalidateException::new);
        po.setAccount(account);
        if (account.getCurrencyCode().equals(book.getDefaultCurrencyCode())) {
            po.setConvertedAmount(amount);
        } else {
            BigDecimal convertedAmount = request.getCategories().stream().map(CategoryRelationAddRequest::getConvertedAmount).reduce(BigDecimal.ZERO, BigDecimal::add);
            if (refundFlag && convertedAmount.compareTo(BigDecimal.ZERO) > 0) {
                throw new AmountInvalidateException();
            }
            if (!refundFlag && convertedAmount.compareTo(BigDecimal.ZERO) < 0) {
                throw new AmountInvalidateException();
            }
            po.setConvertedAmount(convertedAmount);
        }
        po.setCreator(user);
        po.setBook(user.getDefaultBook());
        po.setGroup(user.getDefaultGroup());
        if (request.getPayeeId() != null) {
            Payee payee = payeeRepository.findOneByBookAndId(book, request.getPayeeId()).orElseThrow(InputNotValidException::new);
            po.setPayee(payee);
        }
        request.copyTags(po, tagRepository.findByBookAndEnable(book, true));
        request.copyCategories(po, categoryRepository.findAllByBook(book), book);
        request.copyPrimitive(po);
        dealRepository.save(po);
        confirmBalance(po, type);
        userActionLogRepository.save(new UserActionLog(user, 1, Instant.now().toEpochMilli()));
        return po;
    }

    @Transactional
    // ???????????????????????????
    public boolean update(Integer type, Integer id, DealUpdateRequest request, Integer userSignInId) {
        //??????Category???????????????
        CategoryRelationAddRequest.checkCategory(request.getCategories());
        User user = userService.getUser(userSignInId);
        Book book = user.getDefaultBook();
        Deal po = dealRepository.findOneByBookAndId(book, id).orElseThrow(ItemNotFoundException::new);
        BigDecimal newAmount = request.getCategories().stream().map(CategoryRelationAddRequest::getAmount).reduce(BigDecimal.ZERO, BigDecimal::add);
        //?????????????????????????????????????????????
        // ???????????????????????????????????????????????????????????????????????????
        if (po.getAmount().compareTo(BigDecimal.ZERO) > 0 && newAmount.compareTo(BigDecimal.ZERO) < 0) {
            throw new AmountInvalidateException();
        }
        if (po.getAmount().compareTo(BigDecimal.ZERO) < 0 && newAmount.compareTo(BigDecimal.ZERO) > 0) {
            throw new AmountInvalidateException();
        }
        boolean refundFlag = false;//????????????????????????
        if (po.getAmount().compareTo(newAmount) != 0) {
            refundFlag = true;
            // ???????????????????????????????????????????????????
            // ???????????????????????????????????????????????????????????????????????????????????????
            po.getTags().forEach(i->i.setAmount(newAmount));
        } else if (request.getAccountId() != null && !request.getAccountId().equals(po.getAccount().getId())) {
            refundFlag = true;
        }
        if (refundFlag) {
            refundBalance(po, type);
        }
        Account account = accountRepository.findOneByGroupAndId(user.getDefaultGroup(), request.getAccountId()).orElseThrow(AccountInvalidateException::new);
        po.setAccount(account);
        po.setAmount(newAmount);
        if (account.getCurrencyCode().equals(book.getDefaultCurrencyCode())) {
            po.setConvertedAmount(newAmount);
        } else {
            BigDecimal newConvertedAmount = request.getCategories().stream().map(CategoryRelationAddRequest::getConvertedAmount).reduce(BigDecimal.ZERO, BigDecimal::add);
            if (po.getConvertedAmount().compareTo(BigDecimal.ZERO) > 0 && newConvertedAmount.compareTo(BigDecimal.ZERO) < 0) {
                throw new AmountInvalidateException();
            }
            if (po.getConvertedAmount().compareTo(BigDecimal.ZERO) < 0 && newConvertedAmount.compareTo(BigDecimal.ZERO) > 0) {
                throw new AmountInvalidateException();
            }
            po.setConvertedAmount(newConvertedAmount);
        }
        if (request.getPayeeId() != null) {
            Payee payee = payeeRepository.findOneByBookAndId(book, request.getPayeeId()).orElseThrow(InputNotValidException::new);
            po.setPayee(payee);
        } else {
            po.setPayee(null);
        }
        request.updateTags(po, tagRepository.findByBookAndEnable(book, true));
        request.updateCategories(po, categoryRepository.findAllByBook(book), book);
        request.updatePrimitive(po);
        dealRepository.save(po);
        if (refundFlag) {
           confirmBalance(po, type);
        }
        return true;
    }

    @Transactional
    // ????????????????????????????????????
    public boolean refund(Integer type, Integer id, DealAddRequest request, Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        Book book = user.getDefaultBook();
        Deal deal = dealRepository.findOneByBookAndId(book, id).orElseThrow(ItemNotFoundException::new);
        // ????????????????????????????????????
        if (deal.getStatus() == 2 || deal.getAmount().compareTo(BigDecimal.ZERO) < 0) throw new StatusNotValidateException();
        Deal refundDeal = add(type, request, userSignInId, true);
        // ?????????????????????
        deal.setStatus(3);
        Refund refund = new Refund(deal, refundDeal);
        refundRepository.save(refund);
        return true;
    }

    // 1. ???????????????????????????2. ?????????????????????????????????3. ????????????category relation???4. ????????????tag relation 5. ???????????????refund????????????????????????
    // ??????????????????????????????????????????????????????????????????
    @Transactional
    public boolean remove(Integer type, Integer id, Integer userSignInId) {
        Book book = userService.getUser(userSignInId).getDefaultBook();
        Deal po = dealRepository.findOneByBookAndId(book, id).orElseThrow(ItemNotFoundException::new);
        if (po.getStatus() == 3) throw new StatusNotValidateException();
        refundBalance(po, type);
        // ????????????
        po.getImages().forEach(i -> {
            i.setFlow(null);
            dealImageRepository.save(i);
        });
        // category relation tag relation????????????
        // ???????????????refund
        if (po.getAmount().compareTo(BigDecimal.ZERO) < 0) {//??????0?????????????????????
            Refund refund = refundRepository.findByRefund(po).orElseThrow(ItemNotFoundException::new);
            Deal deal = refund.getDeal();
            deal.setStatus(1);
            dealRepository.save(deal);
            refundRepository.delete(refund);
        }
        dealRepository.delete(po);
        return true;
    }

    @Transactional
    public boolean confirm(Integer type, Integer id, Integer userSignInId) {
        Book book = userService.getUser(userSignInId).getDefaultBook();
        Deal po = dealRepository.findOneByBookAndId(book, id).orElseThrow(ItemNotFoundException::new);
        if (po.getStatus() != 2) {
            throw new StatusNotValidateException();
        }
        po.setStatus(1);
        confirmBalance(po, type);
        dealRepository.save(po);
        return true;
    }

    // ????????????????????????????????????????????????????????????????????????
    private void confirmBalance(Deal deal, Integer type) {
        if (deal.getStatus() == 2) return;//?????????????????????????????????
        Account account = deal.getAccount();
        if (type == 1) {
            account.setBalance(account.getBalance().subtract(deal.getAmount()));
        } else if (type == 2) {
            account.setBalance(account.getBalance().add(deal.getAmount()));
        }
        accountRepository.save(account);
    }

    // ??????
    private void refundBalance(Deal deal, Integer type) {
        if (deal.getStatus() == 2) return;//?????????????????????????????????
        Account account = deal.getAccount();
        if (type == 1) {
            account.setBalance(account.getBalance().add(deal.getAmount()));
        } else if (type == 2) {
            account.setBalance(account.getBalance().subtract(deal.getAmount()));
        }
        accountRepository.save(account);
    }

}
