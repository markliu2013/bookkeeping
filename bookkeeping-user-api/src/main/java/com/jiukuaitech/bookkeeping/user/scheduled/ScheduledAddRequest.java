package com.jiukuaitech.bookkeeping.user.scheduled;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ScheduledAddRequest {

    private String name;
    private Long startTime;
    private Integer endType;
    private Long endTime;
    private Integer loopTimes;
    private Integer frequencyType;
    private Integer hour;
    private Integer minute;
    private Boolean autoConfirmed;

}
