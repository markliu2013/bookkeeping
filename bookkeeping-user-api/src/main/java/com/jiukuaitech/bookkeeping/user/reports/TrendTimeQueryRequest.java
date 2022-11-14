package com.jiukuaitech.bookkeeping.user.reports;

import lombok.Getter;
import lombok.Setter;

import java.time.Instant;

@Getter
@Setter
public class TrendTimeQueryRequest {

    private Long minTime;
    private Long maxTime = Instant.now().toEpochMilli();

}
