package com.jiukuaitech.bookkeeping.user.adjust_balance;

import com.jiukuaitech.bookkeeping.user.base.HasBookRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AdjustBalanceRepository extends HasBookRepository<AdjustBalance> {

    void deleteByAccount_Id(Integer id);

}
