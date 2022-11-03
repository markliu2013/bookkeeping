package com.jiukuaitech.bookkeeping.user.dashboard;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class AssetOverviewVO {

    private BigDecimal asset;//资产
    private BigDecimal debt;//负债

    public BigDecimal getNetWorth() {
        return asset.subtract(debt);
    }

}
