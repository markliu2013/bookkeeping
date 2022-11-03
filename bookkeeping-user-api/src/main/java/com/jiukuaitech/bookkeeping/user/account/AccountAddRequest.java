package com.jiukuaitech.bookkeeping.user.account;

import java.math.BigDecimal;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import com.jiukuaitech.bookkeeping.user.validation.BalanceValidator;
import com.jiukuaitech.bookkeeping.user.validation.NameValidator;
import com.jiukuaitech.bookkeeping.user.validation.NoValidator;
import com.jiukuaitech.bookkeeping.user.validation.NotesValidator;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AccountAddRequest {

    @NotBlank(message="name must not be blank")
    @NameValidator
    private String name;

    @NoValidator
    private String no;

    @NotNull
    @BalanceValidator
    private BigDecimal balance;

    private Boolean include = true;
    private Boolean transferFromAble = true;
    private Boolean transferToAble = true;
    private Boolean expenseable = true;
    private Boolean incomeable = true;

    @NotesValidator
    private String notes;

    @NotBlank
    private String currencyCode;

    public void copyPrimitive(Account po) {
        po.setName(name);
        po.setNo(no);
        po.setBalance(balance);
        po.setInitialBalance(balance);
        po.setInclude(include);
        po.setTransferFromAble(transferFromAble);
        po.setTransferToAble(transferToAble);
        po.setExpenseable(expenseable);
        po.setIncomeable(incomeable);
        po.setNotes(notes);
        po.setCurrencyCode(currencyCode);
    }

}
