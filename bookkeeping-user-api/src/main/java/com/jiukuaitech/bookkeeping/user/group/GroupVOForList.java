package com.jiukuaitech.bookkeeping.user.group;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class GroupVOForList {

    private Integer id;
    private String name;
    private String notes;
    private String defaultCurrencyCode;
    private Integer role;

    public static GroupVOForList fromEntity(Group po) {
        GroupVOForList vo = new GroupVOForList();
        vo.setId(po.getId());
        vo.setName(po.getName());
        vo.setNotes(po.getNotes());
        vo.setDefaultCurrencyCode(po.getDefaultCurrencyCode());
        return vo;
    }

}
