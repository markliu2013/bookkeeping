package com.jiukuaitech.bookkeeping.user.category_relation;

import lombok.Getter;
import lombok.Setter;
import java.math.BigDecimal;


@Getter
@Setter
public class CategoryRelationVOForList {

    private Integer id;
    private BigDecimal amount;
    private BigDecimal convertedAmount;
    private Integer categoryId;
    private String categoryName;

    public static CategoryRelationVOForList fromEntity(CategoryRelation po) {
        if (po == null) return null;
        CategoryRelationVOForList vo = new CategoryRelationVOForList();
        vo.setId(po.getId());
        vo.setAmount(po.getAmount());
        vo.setConvertedAmount(po.getConvertedAmount());
        vo.setCategoryId(po.getCategory().getId());
        vo.setCategoryName(po.getCategory().getName());
        return vo;
    }

}
