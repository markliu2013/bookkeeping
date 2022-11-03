package com.jiukuaitech.bookkeeping.user.payee;

import com.jiukuaitech.bookkeeping.user.validation.NameValidator;
import com.jiukuaitech.bookkeeping.user.validation.NotesValidator;
import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotEmpty;

@Getter
@Setter
public class PayeeAddRequest {

    @NotEmpty
    @NameValidator
    private String name;

    @NotesValidator
    private String notes;

    private Boolean expenseable = false;
    private Boolean incomeable = false;

}
