package com.jiukuaitech.bookkeeping.user.category;

import com.jiukuaitech.bookkeeping.user.validation.NameValidator;
import com.jiukuaitech.bookkeeping.user.validation.NotesValidator;
import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotBlank;

@Getter
@Setter
public class CategoryAddRequest {

    @NotBlank
    @NameValidator
    private String name;

    @NotesValidator
    private String notes;

    private Integer parentId;

}
