package com.jiukuaitech.bookkeeping.user.tag;

import com.jiukuaitech.bookkeeping.user.validation.NameValidator;
import com.jiukuaitech.bookkeeping.user.validation.NotesValidator;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TagUpdateRequest {

    private Integer parentId;

    @NameValidator
    private String name;

    @NotesValidator
    private String notes;

    private Boolean expenseable;
    private Boolean incomeable;
    private Boolean transferable;

}
