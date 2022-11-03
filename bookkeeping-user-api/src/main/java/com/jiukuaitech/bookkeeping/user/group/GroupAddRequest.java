package com.jiukuaitech.bookkeeping.user.group;

import com.jiukuaitech.bookkeeping.user.validation.NameValidator;
import com.jiukuaitech.bookkeeping.user.validation.NotesValidator;
import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotBlank;

@Getter
@Setter
public class GroupAddRequest {

    @NotBlank(message="name must not be blank")
    @NameValidator
    private String name;

    @NotesValidator
    private String notes;

    @NotBlank
    private String defaultCurrencyCode;

}
