package com.jiukuaitech.bookkeeping.user.reports;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TrendTimeQueryRequest {

    private Long minTime;
    private Long maxTime = System.currentTimeMillis();

}
