package com.jiukuaitech.bookkeeping.user.reports;

import lombok.Getter;
import lombok.Setter;
import java.math.BigDecimal;

@Getter
@Setter
public class ChartVO {

    private String x;
    private BigDecimal y;
    private BigDecimal percent;

    public ChartVO() { }

    public ChartVO(String x, BigDecimal y) {
        this.x = x;
        this.y = y;
    }

}
