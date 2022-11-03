package com.jiukuaitech.bookkeeping.user.transaction;

import com.jiukuaitech.bookkeeping.user.tag.Tag;
import com.jiukuaitech.bookkeeping.user.utils.CommonUtils;
import com.jiukuaitech.bookkeeping.user.balance_flow.BalanceFlowAddRequest;
import com.jiukuaitech.bookkeeping.user.base.BaseEntity;
import com.jiukuaitech.bookkeeping.user.exception.InputNotValidException;
import lombok.Getter;
import lombok.Setter;
import org.springframework.util.CollectionUtils;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Getter
@Setter
public class TransactionAddRequest extends BalanceFlowAddRequest {

    private Boolean confirmed = true;
    private Set<Integer> tags;

    public void copyPrimitive(Transaction po) {
        super.copyPrimitive(po);
        po.setStatus(confirmed ? 1 : 2);
    }

    public void copyTags(Transaction po, List<Tag> tags) {
        if (!CollectionUtils.isEmpty(getTags())) {
            // 自动保存关联对象
            List<Integer> tagIds = tags.stream().map(BaseEntity::getId).collect(Collectors.toList());
            getTags().forEach(i-> {
                if (tagIds.contains(i)) {
                    po.getTags().add(CommonUtils.getTagRelation(i, po));
                } else {
                    throw new InputNotValidException();
                }
            });
        }
    }

}
