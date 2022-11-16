package com.jiukuaitech.bookkeeping.user.user_log;

import com.jiukuaitech.bookkeeping.user.base.BaseRepository;
import com.jiukuaitech.bookkeeping.user.user.User;
import org.springframework.stereotype.Repository;

@Repository
public interface UserActionLogRepository extends BaseRepository<UserActionLog, Integer> {

    long countByUserAndTypeAndActionTimeBetween(User user, int type, long start, long end);

}
