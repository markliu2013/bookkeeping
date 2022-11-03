package com.jiukuaitech.bookkeeping.user.refund;

import com.jiukuaitech.bookkeeping.user.base.BaseRepository;
import com.jiukuaitech.bookkeeping.user.deal.Deal;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface RefundRepository extends BaseRepository<Refund, Integer> {

    Optional<Refund> findByRefund(Deal refund);

    List<Refund> findByDeal(Deal deal);

}
