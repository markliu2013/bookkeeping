package com.jiukuaitech.bookkeeping.user.payee;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PayeeVOForList {

    private Integer id;
    private String name;
    private String notes;
    private Boolean enable;
    private Boolean expenseable;
    private Boolean incomeable;

    public static PayeeVOForList fromEntity(Payee po) {
        if (po == null) return null;
        PayeeVOForList vo = new PayeeVOForList();
        vo.setId(po.getId());
        vo.setName(po.getName());
        vo.setNotes(po.getNotes());
        vo.setEnable(po.getEnable());
        vo.setExpenseable(po.getExpenseable());
        vo.setIncomeable(po.getIncomeable());
        return vo;
    }

}
