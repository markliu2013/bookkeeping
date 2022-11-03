package com.jiukuaitech.bookkeeping.user.transaction;

import com.jiukuaitech.bookkeeping.user.base.BaseRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TransactionRepository extends BaseRepository<Transaction, Integer> {

    Long countByAccount_id(Integer accountId);

}
