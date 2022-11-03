package com.jiukuaitech.bookkeeping.user.group;

import com.jiukuaitech.bookkeeping.user.validation.NameValidator;
import com.jiukuaitech.bookkeeping.user.validation.NotesValidator;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class GroupUpdateRequest {

    @NameValidator
    private String name;

    @NotesValidator
    private String notes;

}
