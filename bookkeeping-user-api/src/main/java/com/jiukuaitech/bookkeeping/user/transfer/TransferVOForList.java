package com.jiukuaitech.bookkeeping.user.transfer;

import com.jiukuaitech.bookkeeping.user.account.AccountVOForExtend;
import com.jiukuaitech.bookkeeping.user.transaction.TransactionVOForList;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TransferVOForList extends TransactionVOForList {

    private AccountVOForExtend from;
    private AccountVOForExtend to;
    private Integer fromId;
    private Integer toId;
    private String accountName;

    public static TransferVOForList fromEntity(Transfer po) {
        TransferVOForList vo = new TransferVOForList();
        vo.setValue(po);
        vo.setAccountName(po.getAccount().getName() + " -> " + po.getTo().getName());
        vo.setFrom(AccountVOForExtend.fromEntity(po.getAccount()));
        vo.setTo(AccountVOForExtend.fromEntity(po.getTo()));
        vo.setFromId(po.getAccount().getId());
        vo.setToId(po.getTo().getId());
        return vo;
    }

}
