package com.jiukuaitech.bookkeeping.user.item;

import com.jiukuaitech.bookkeeping.user.validation.NameValidator;
import com.jiukuaitech.bookkeeping.user.validation.TimeValidator;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ItemUpdateRequest {

    @NameValidator
    private String title;

    private String notes;

    @TimeValidator
    private Long endDate;

}
