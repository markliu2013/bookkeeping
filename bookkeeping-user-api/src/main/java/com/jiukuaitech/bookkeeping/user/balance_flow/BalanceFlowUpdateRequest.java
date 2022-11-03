package com.jiukuaitech.bookkeeping.user.balance_flow;

import com.jiukuaitech.bookkeeping.user.validation.DescriptionValidator;
import com.jiukuaitech.bookkeeping.user.validation.NotesValidator;
import com.jiukuaitech.bookkeeping.user.validation.TimeValidator;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BalanceFlowUpdateRequest {

    @TimeValidator
    private Long createTime;

    @DescriptionValidator
    private String description;

    @NotesValidator
    private String notes;

    public void updatePrimitive(BalanceFlow po) {
        if (createTime != null) po.setCreateTime(createTime);
        if (description != null) po.setDescription(description);
        if (notes != null) po.setNotes(notes);
    }

}
