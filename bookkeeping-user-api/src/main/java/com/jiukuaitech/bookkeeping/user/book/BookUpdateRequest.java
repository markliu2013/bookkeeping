package com.jiukuaitech.bookkeeping.user.book;

import com.jiukuaitech.bookkeeping.user.validation.NameValidator;
import com.jiukuaitech.bookkeeping.user.validation.NotesValidator;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BookUpdateRequest {

    @NameValidator
    private String name;

    @NotesValidator
    private String notes;

    private Integer defaultExpenseAccountId;
    private Integer defaultIncomeAccountId;
    private Integer defaultTransferFromAccountId;
    private Integer defaultTransferToAccountId;
    private Integer defaultExpenseCategoryId;
    private Integer defaultIncomeCategoryId;
    private Boolean descriptionEnable;
    private Boolean timeEnable;
    private Boolean imageEnable;

}
