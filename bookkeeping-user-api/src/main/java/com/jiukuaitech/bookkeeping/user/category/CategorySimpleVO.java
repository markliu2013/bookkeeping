package com.jiukuaitech.bookkeeping.user.category;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CategorySimpleVO {

    private Integer id;
    private String name;
    private String notes;
    private Boolean enable;
    private Integer parentId;

    public static CategorySimpleVO fromEntity(Category po) {
        if (po == null) return null;
        CategorySimpleVO vo =  new CategorySimpleVO();
        vo.setId(po.getId());
        vo.setName(po.getName());
        vo.setNotes(po.getNotes());
        vo.setEnable(po.getEnable());
        vo.setParentId(po.getParent() != null ? po.getParent().getId() : 0);
        return vo;
    }

}
