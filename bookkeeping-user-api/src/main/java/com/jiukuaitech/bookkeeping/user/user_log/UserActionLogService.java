package com.jiukuaitech.bookkeeping.user.user_log;

import com.jiukuaitech.bookkeeping.user.user.User;
import com.jiukuaitech.bookkeeping.user.utils.CalendarUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class UserActionLogService {

    @Resource
    private UserActionLogRepository userActionLogRepository;

    @Value("${flow.max.count.daily}")
    private Integer maxCount;

    public boolean check(User user) {
        Long[] day = CalendarUtils.getIn1Day();
        if (userActionLogRepository.countByUserAndTypeAndActionTimeBetween(user, 1, day[0], day[1]) >= maxCount) {
            throw new FlowMaxCountException();
        }
        return true;
    }

}
