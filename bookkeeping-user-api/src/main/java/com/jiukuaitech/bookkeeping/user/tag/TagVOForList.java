package com.jiukuaitech.bookkeeping.user.tag;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TagVOForList {

    private Integer id;
    private String name;
    private String notes;
    private Boolean enable;
    private Boolean expenseable;
    private Boolean incomeable;
    private Boolean transferable;
    private Integer parentId;

    public static TagVOForList fromEntity(Tag po) {
        if (po == null) return null;
        TagVOForList vo = new TagVOForList();
        vo.setId(po.getId());
        vo.setName(po.getName());
        vo.setNotes(po.getNotes());
        vo.setEnable(po.getEnable());
        vo.setExpenseable(po.getExpenseable());
        vo.setIncomeable(po.getIncomeable());
        vo.setTransferable(po.getTransferable());
        vo.setParentId(po.getParent() != null ? po.getParent().getId() : 0);
        return vo;
    }

}
