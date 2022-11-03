package com.jiukuaitech.bookkeeping.user.balance_log;

import lombok.Getter;
import lombok.Setter;
import java.math.BigDecimal;

@Getter
@Setter
public class BalanceLogVOForList {

    private Integer id;
    private BigDecimal asset;
    private BigDecimal debt;
    private Long createTime;

    public static BalanceLogVOForList fromEntity(BalanceLog po) {
        BalanceLogVOForList vo = new BalanceLogVOForList();
        vo.setId(po.getId());
        vo.setAsset(po.getAsset());
        vo.setDebt(po.getDebt());
        vo.setCreateTime(po.getCreateTime());
        return vo;
    }

}
