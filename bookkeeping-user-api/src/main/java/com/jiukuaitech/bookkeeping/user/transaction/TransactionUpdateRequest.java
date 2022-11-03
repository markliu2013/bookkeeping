package com.jiukuaitech.bookkeeping.user.transaction;

import com.jiukuaitech.bookkeeping.user.balance_flow.BalanceFlowUpdateRequest;
import com.jiukuaitech.bookkeeping.user.base.BaseEntity;
import com.jiukuaitech.bookkeeping.user.tag.Tag;
import com.jiukuaitech.bookkeeping.user.utils.CommonUtils;
import com.jiukuaitech.bookkeeping.user.exception.InputNotValidException;
import lombok.Getter;
import lombok.Setter;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Getter
@Setter
public class TransactionUpdateRequest extends BalanceFlowUpdateRequest {

    private Set<Integer> tags;

    public void updateTags(Transaction po, List<Tag> tags) {
        if (getTags() != null) {
            CommonUtils.cleanTagRelation(po.getTags(), getTags());
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
