package com.jiukuaitech.bookkeeping.user.adjust_balance;

import com.jiukuaitech.bookkeeping.user.balance_flow.BalanceFlowVOForExtend;


public class AdjustBalanceVOForList extends BalanceFlowVOForExtend {

    public static AdjustBalanceVOForList fromEntity(AdjustBalance po) {
        AdjustBalanceVOForList vo = new AdjustBalanceVOForList();
        vo.setValue(po);
        return vo;
    }

}
