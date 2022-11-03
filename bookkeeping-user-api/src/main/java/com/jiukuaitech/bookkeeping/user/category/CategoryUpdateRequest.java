package com.jiukuaitech.bookkeeping.user.category;

import com.jiukuaitech.bookkeeping.user.validation.NameValidator;
import com.jiukuaitech.bookkeeping.user.validation.NotesValidator;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CategoryUpdateRequest {

    @NameValidator
    private String name;

    @NotesValidator
    private String notes;

    private Integer parentId;

}
