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
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import javax.annotation.Resource;
import java.math.BigDecimal;

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

    @Transactional
    // 正常添加amount只能为正，退款的添加amount只能为负。
    public Deal add(Integer type, DealAddRequest request, Integer userSignInId, boolean refundFlag) {
        //检查Category有没有重复
        CategoryRelationAddRequest.checkCategory(request.getCategories());
        User user = userService.getUser(userSignInId);
        Book book = user.getDefaultBook();
        Deal po = null;
        BigDecimal amount = request.getCategories().stream().map(CategoryRelationAddRequest::getAmount).reduce(BigDecimal.ZERO, BigDecimal::add);
        BigDecimal convertedAmount = request.getCategories().stream().map(CategoryRelationAddRequest::getConvertedAmount).reduce(BigDecimal.ZERO, BigDecimal::add);
        if (refundFlag && amount.compareTo(BigDecimal.ZERO) > 0) {
            throw new AmountInvalidateException();
        }
        if (!refundFlag && amount.compareTo(BigDecimal.ZERO) < 0) {
            throw new AmountInvalidateException();
        }
        if (refundFlag && convertedAmount.compareTo(BigDecimal.ZERO) > 0) {
            throw new AmountInvalidateException();
        }
        if (!refundFlag && convertedAmount.compareTo(BigDecimal.ZERO) < 0) {
            throw new AmountInvalidateException();
        }
        if (type == 1) {
            po = new Expense();
        } else if (type == 2) {
            po = new Income();
        }
        po.setAmount(amount);
        po.setConvertedAmount(convertedAmount);
        Account account = accountRepository.findOneByGroupAndId(user.getDefaultGroup(), request.getAccountId()).orElseThrow(AccountInvalidateException::new);
        po.setAccount(account);
        po.setCreator(user);
        po.setBook(user.getDefaultBook());
        po.setGroup(user.getDefaultGroup());
        if (request.getPayeeId() != null) {
            Payee payee = payeeRepository.findOneByBookAndId(book, request.getPayeeId()).orElseThrow(InputNotValidException::new);
            po.setPayee(payee);
        }
        request.copyTags(po, tagRepository.findByBookAndEnable(book, true));
        request.copyCategories(po, categoryRepository.findAllByBook(book));
        request.copyPrimitive(po);
        dealRepository.save(po);
        confirmBalance(po, type);
        return po;
    }

    @Transactional
    // 已经退款的不能修改
    public boolean update(Integer type, Integer id, DealUpdateRequest request, Integer userSignInId) {
        //检查Category有没有重复
        CategoryRelationAddRequest.checkCategory(request.getCategories());
        User user = userService.getUser(userSignInId);
        Book book = user.getDefaultBook();
        Deal po = dealRepository.findOneByBookAndId(book, id).orElseThrow(ItemNotFoundException::new);
        BigDecimal newAmount = request.getCategories().stream().map(CategoryRelationAddRequest::getAmount).reduce(BigDecimal.ZERO, BigDecimal::add);
        BigDecimal newConvertedAmount = request.getCategories().stream().map(CategoryRelationAddRequest::getConvertedAmount).reduce(BigDecimal.ZERO, BigDecimal::add);
        //正数不能改负数，负数不能改正数
        // 不能改变正负符号，也就是不能改变是否是退款的情况。
        if (po.getAmount().compareTo(BigDecimal.ZERO) > 0 && newAmount.compareTo(BigDecimal.ZERO) < 0) throw new AmountInvalidateException();
        if (po.getAmount().compareTo(BigDecimal.ZERO) < 0 && newAmount.compareTo(BigDecimal.ZERO) > 0) throw new AmountInvalidateException();
        if (po.getConvertedAmount().compareTo(BigDecimal.ZERO) > 0 && newConvertedAmount.compareTo(BigDecimal.ZERO) < 0) throw new AmountInvalidateException();
        if (po.getConvertedAmount().compareTo(BigDecimal.ZERO) < 0 && newConvertedAmount.compareTo(BigDecimal.ZERO) > 0) throw new AmountInvalidateException();
        boolean refundFlag = false;//是否更新账户金额
        if (po.getAmount().compareTo(newAmount) != 0) {
            refundFlag = true;
            // 不然更新金额，标签对应的金额不更新
            // 只有更新金额才自动更新标签的金额，更新分类不更新标签的金额
            po.getTags().forEach(i->i.setAmount(newAmount));
        } else if (request.getAccountId() != null && !request.getAccountId().equals(po.getAccount().getId())) {
            refundFlag = true;
        }
        if (refundFlag) {
            refundBalance(po, type);
        }
        po.setAccount(accountRepository.findOneByGroupAndId(user.getDefaultGroup(), request.getAccountId()).orElseThrow(AccountInvalidateException::new));
        po.setAmount(newAmount);
        po.setConvertedAmount(newConvertedAmount);
        if (request.getPayeeId() != null) {
            Payee payee = payeeRepository.findOneByBookAndId(book, request.getPayeeId()).orElseThrow(InputNotValidException::new);
            po.setPayee(payee);
        } else {
            po.setPayee(null);
        }
        request.updateTags(po, tagRepository.findByBookAndEnable(book, true));
        request.updateCategories(po, categoryRepository.findAllByBook(book));
        request.updatePrimitive(po);
        dealRepository.save(po);
        if (refundFlag) {
           confirmBalance(po, type);
        }
        return true;
    }

    @Transactional
    // 只有状态是正常的才能退款
    public boolean refund(Integer type, Integer id, DealAddRequest request, Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        Book book = user.getDefaultBook();
        Deal deal = dealRepository.findOneByBookAndId(book, id).orElseThrow(ItemNotFoundException::new);
        // 如果新增状态值可能有问题
        if (deal.getStatus() == 2 || deal.getAmount().compareTo(BigDecimal.ZERO) < 0) throw new StatusNotValidateException();
        Deal refundDeal = add(type, request, userSignInId, true);
        // 状态变成已退款
        deal.setStatus(3);
        Refund refund = new Refund(deal, refundDeal);
        refundRepository.save(refund);
        return true;
    }

    // 1. 退回账户余额变更，2. 删除图片关联以及文件，3. 删除关联category relation，4. 删除关联tag relation 5. 处理关联的refund，最后删除自己。
    // 已经退款的不能删除，必须先删除对应的退款记录
    @Transactional
    public boolean remove(Integer type, Integer id, Integer userSignInId) {
        Book book = userService.getUser(userSignInId).getDefaultBook();
        Deal po = dealRepository.findOneByBookAndId(book, id).orElseThrow(ItemNotFoundException::new);
        if (po.getStatus() == 3) throw new StatusNotValidateException();
        refundBalance(po, type);
        // 处理图片
        po.getImages().forEach(i -> {
            i.setFlow(null);
            dealImageRepository.save(i);
        });
        // category relation tag relation自动处理
        // 处理关联的refund
        if (po.getAmount().compareTo(BigDecimal.ZERO) < 0) {//小于0说明是退款记录
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

    // 余额确认，包括账户扣款，账户统计，账户日志记录。
    private void confirmBalance(Deal deal, Integer type) {
        if (deal.getStatus() == 2) return;//未确认，不更新账户余额
        Account account = deal.getAccount();
        if (type == 1) {
            account.setBalance(account.getBalance().subtract(deal.getAmount()));
        } else if (type == 2) {
            account.setBalance(account.getBalance().add(deal.getAmount()));
        }
        accountRepository.save(account);
    }

    // 退款
    private void refundBalance(Deal deal, Integer type) {
        if (deal.getStatus() == 2) return;//未确认，不更新账户余额
        Account account = deal.getAccount();
        if (type == 1) {
            account.setBalance(account.getBalance().add(deal.getAmount()));
        } else if (type == 2) {
            account.setBalance(account.getBalance().subtract(deal.getAmount()));
        }
        accountRepository.save(account);
    }

}
