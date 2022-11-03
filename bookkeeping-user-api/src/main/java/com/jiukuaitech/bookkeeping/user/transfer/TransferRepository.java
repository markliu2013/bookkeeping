package com.jiukuaitech.bookkeeping.user.transfer;

import com.jiukuaitech.bookkeeping.user.base.HasBookRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TransferRepository extends HasBookRepository<Transfer> {

    Long countByTo_id(Integer accountId);

}
