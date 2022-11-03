package com.jiukuaitech.bookkeeping.user.refund;

import com.jiukuaitech.bookkeeping.user.book.Book;
import com.jiukuaitech.bookkeeping.user.deal.Deal;
import com.jiukuaitech.bookkeeping.user.deal.DealRepository;
import com.jiukuaitech.bookkeeping.user.user.UserService;
import com.jiukuaitech.bookkeeping.user.exception.ItemNotFoundException;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class RefundService {

    @Resource
    private UserService userService;

    @Resource
    private DealRepository dealRepository;

    @Resource
    private RefundRepository refundRepository;

    public List<Integer> getRefunds(Integer dealId, Integer userSignInId) {
        Book book = userService.getUser(userSignInId).getDefaultBook();
        Deal po = dealRepository.findOneByBookAndId(book, dealId).orElseThrow(ItemNotFoundException::new);
        // 不需要验证，返回自己，不验证也不会报错。
//        if (po.getStatus() != 3 && po.getAmount().compareTo(BigDecimal.ZERO) > 0) {
//            throw new StatusNotValidateException();
//        }
        Deal deal;
        if (po.getAmount().compareTo(BigDecimal.ZERO) > 0) {
            deal = po;
        } else {
            Refund refund = refundRepository.findByRefund(po).orElseThrow(ItemNotFoundException::new);
            deal = refund.getDeal();
        }
        List<Refund> refunds = refundRepository.findByDeal(deal);
        List<Integer> result = refunds.stream().map(i->i.getRefund().getId()).collect(Collectors.toList());
        result.add(deal.getId());
        return result;
    }

}
