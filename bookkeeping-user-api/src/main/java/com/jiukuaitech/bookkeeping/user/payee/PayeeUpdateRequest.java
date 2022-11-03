package com.jiukuaitech.bookkeeping.user.payee;

import com.jiukuaitech.bookkeeping.user.validation.NameValidator;
import com.jiukuaitech.bookkeeping.user.validation.NotesValidator;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PayeeUpdateRequest {

    @NameValidator
    private String name;

    @NotesValidator
    private String notes;

    private Boolean expenseable;
    private Boolean incomeable;

}
