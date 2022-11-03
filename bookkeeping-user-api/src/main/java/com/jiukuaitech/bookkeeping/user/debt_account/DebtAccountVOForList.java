package com.jiukuaitech.bookkeeping.user.debt_account;

import com.jiukuaitech.bookkeeping.user.account.AccountVOForExtend;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class DebtAccountVOForList extends AccountVOForExtend {

    private BigDecimal apr;
    private BigDecimal limit;

    public static DebtAccountVOForList fromEntity(DebtAccount po) {
        DebtAccountVOForList vo = new DebtAccountVOForList();
        vo.setValue(po);
        vo.setApr(po.getApr());
        vo.setLimit(po.getLimit());
        return vo;
    }

    public BigDecimal getRemainLimit() {
        if (limit == null) return null;
//        if (limit.signum() == 0) return BigDecimal.valueOf(0);
        return limit.add(getBalance());
    }
}
