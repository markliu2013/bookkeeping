package com.jiukuaitech.bookkeeping.user.tag_relation;

import lombok.Getter;
import lombok.Setter;
import java.math.BigDecimal;

@Getter
@Setter
public class TagRelationVOForList {

    private Integer id;
    private BigDecimal amount;
    private BigDecimal convertedAmount;
    private Integer tagId;
    private String tagName;

    public static TagRelationVOForList fromEntity(TagRelation po) {
        if (po == null) return null;
        TagRelationVOForList vo = new TagRelationVOForList();
        vo.setId(po.getId());
        vo.setAmount(po.getAmount());
        vo.setConvertedAmount(po.getConvertedAmount());
        vo.setTagId(po.getTag().getId());
        vo.setTagName(po.getTag().getName());
        return vo;
    }

}
