package com.jiukuaitech.bookkeeping.user.account;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class AccountVOForList extends AccountVOForExtend {

    private BigDecimal limit;
    private Integer billDay;

    private BigDecimal apr;
    private Long asOfDate;

    public BigDecimal getRemainLimit() {
        if (limit == null) return null;
        return limit.add(getBalance());
    }

}
