package com.jiukuaitech.bookkeeping.user.deal;

import com.jiukuaitech.bookkeeping.user.category_relation.CategoryRelationVOForList;
import com.jiukuaitech.bookkeeping.user.response.HasNameVO;
import com.jiukuaitech.bookkeeping.user.transaction.TransactionVOForList;
import lombok.Getter;
import lombok.Setter;

import java.util.HashSet;
import java.util.Set;
import java.util.stream.Collectors;

@Getter
@Setter
public class DealVOForList extends TransactionVOForList {

    private HasNameVO payee;
    private String categoryName;
    private Set<CategoryRelationVOForList> categories = new HashSet<>();

    public void setValue(Deal po) {
        super.setValue(po);
        if (po.getPayee() != null) setPayee(new HasNameVO(po.getPayee().getId(), po.getPayee().getName()));
        setCategoryName(po.getCategories().stream().map(i -> i.getCategory().getName() + "(" + i.getAmount().stripTrailingZeros().toPlainString()+")").collect(Collectors.joining(", ")));
        setCategories(po.getCategories().stream().map(CategoryRelationVOForList::fromEntity).collect(Collectors.toSet()));
    }

    public static DealVOForList fromEntity(Deal po) {
        DealVOForList vo = new DealVOForList();
        vo.setValue(po);
        return vo;
    }

}
