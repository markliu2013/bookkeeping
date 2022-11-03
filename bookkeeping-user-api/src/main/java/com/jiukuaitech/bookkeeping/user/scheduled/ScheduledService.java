package com.jiukuaitech.bookkeeping.user.scheduled;


import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class ScheduledService {

    @Resource
    private ScheduledRepository scheduledRepository;

    public boolean addExpense(ScheduledExpenseAddRequest request, Integer userSignInId) {
        return true;
    }

}
