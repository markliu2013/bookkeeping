package com.jiukuaitech.bookkeeping.user.transaction;

import com.jiukuaitech.bookkeeping.user.balance_flow.BalanceFlowVOForExtend;
import com.jiukuaitech.bookkeeping.user.tag_relation.TagRelationVOForList;
import lombok.Getter;
import lombok.Setter;
import java.util.HashSet;
import java.util.Set;
import java.util.stream.Collectors;

@Getter
@Setter
public class TransactionVOForList extends BalanceFlowVOForExtend {

    private Set<TagRelationVOForList> tags = new HashSet<>();

    public void setValue(Transaction po) {
        super.setValue(po);
        setTags(po.getTags().stream().map(TagRelationVOForList::fromEntity).collect(Collectors.toSet()));
    }

}
