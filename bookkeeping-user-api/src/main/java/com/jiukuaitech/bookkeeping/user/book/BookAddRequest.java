package com.jiukuaitech.bookkeeping.user.book;

import com.jiukuaitech.bookkeeping.user.validation.NameValidator;
import com.jiukuaitech.bookkeeping.user.validation.NotesValidator;
import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotBlank;

@Getter
@Setter
public class BookAddRequest {

    @NotBlank
    @NameValidator
    private String name;

    @NotesValidator
    private String notes;

    private Boolean descriptionEnable = true;
    private Boolean timeEnable = false;
    private Boolean imageEnable = false;

}
