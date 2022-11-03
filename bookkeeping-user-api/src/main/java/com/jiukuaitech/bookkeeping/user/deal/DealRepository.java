package com.jiukuaitech.bookkeeping.user.deal;

import com.jiukuaitech.bookkeeping.user.base.HasBookRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DealRepository extends HasBookRepository<Deal> {

    Integer countByPayee_id(Integer payeeId);

}
