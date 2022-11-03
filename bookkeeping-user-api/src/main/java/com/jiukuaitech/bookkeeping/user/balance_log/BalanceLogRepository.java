package com.jiukuaitech.bookkeeping.user.balance_log;

import com.jiukuaitech.bookkeeping.user.base.BaseRepository;
import com.jiukuaitech.bookkeeping.user.group.Group;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;


@Repository
public interface BalanceLogRepository extends BaseRepository<BalanceLog, Integer> {

    Optional<BalanceLog> findOneByGroupAndId(Group group, Integer integer);

    List<BalanceLog> findByGroupAndCreateTimeBetweenOrderByCreateTime(Group group, Long min, Long max);

}
