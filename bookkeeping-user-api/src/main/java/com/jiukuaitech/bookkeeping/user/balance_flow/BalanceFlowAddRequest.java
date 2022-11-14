package com.jiukuaitech.bookkeeping.user.balance_flow;

import com.jiukuaitech.bookkeeping.user.validation.DescriptionValidator;
import com.jiukuaitech.bookkeeping.user.validation.NotesValidator;
import com.jiukuaitech.bookkeeping.user.validation.TimeValidator;
import lombok.Getter;
import lombok.Setter;

import java.time.Instant;

@Getter
@Setter
public class BalanceFlowAddRequest {

    @TimeValidator
    private Long createTime;

    @DescriptionValidator
    private String description;

    @NotesValidator
    private String notes;

    public void copyPrimitive(BalanceFlow po) {
        if (createTime == null) {
            po.setCreateTime(Instant.now().toEpochMilli());
        } else {
            po.setCreateTime(createTime);
        }
        po.setDescription(description);
        po.setNotes(notes);
    }

}
