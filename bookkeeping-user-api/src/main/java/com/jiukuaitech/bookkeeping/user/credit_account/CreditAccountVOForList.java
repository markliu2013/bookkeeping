package com.jiukuaitech.bookkeeping.user.credit_account;

import com.jiukuaitech.bookkeeping.user.account.AccountVOForExtend;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class CreditAccountVOForList extends AccountVOForExtend {

    private BigDecimal limit;
    private Integer billDay;

    public static CreditAccountVOForList fromEntity(CreditAccount po) {
        CreditAccountVOForList vo = new CreditAccountVOForList();
        vo.setValue(po);
        vo.setLimit(po.getLimit());
        vo.setBillDay(po.getBillDay());
        return vo;
    }

    public BigDecimal getRemainLimit() {
        return limit.add(getBalance());
    }
}
