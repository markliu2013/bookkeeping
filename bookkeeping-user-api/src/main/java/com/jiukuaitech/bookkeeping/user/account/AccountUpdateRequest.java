package com.jiukuaitech.bookkeeping.user.account;

import java.math.BigDecimal;

import com.jiukuaitech.bookkeeping.user.credit_account.CreditAccount;
import com.jiukuaitech.bookkeeping.user.debt_account.DebtAccount;
import com.jiukuaitech.bookkeeping.user.validation.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AccountUpdateRequest {

    @NameValidator
    private String name;
    @NoValidator
    private String no;
    private Boolean include;
    private Boolean transferFromAble;
    private Boolean transferToAble;
    private Boolean expenseable;
    private Boolean incomeable;
    @NotesValidator
    private String notes;

    // For Credit
    @CreditLimitValidator
    private BigDecimal limit; // 信用额度
    @BillDayValidator
    private Integer billDay; // 每月多少号是账单日

    @AprValidator
    private BigDecimal apr;

    public void updatePrimitive(Account po) {
        if (name != null) po.setName(name);
        if (no != null) po.setNo(no);
        if (include != null) po.setInclude(include);
        if (transferFromAble != null) po.setTransferFromAble(transferFromAble);
        if (transferToAble != null) po.setTransferToAble(transferToAble);
        if (expenseable != null) po.setExpenseable(expenseable);
        if (incomeable != null) po.setIncomeable(incomeable);
        if (notes != null) po.setNotes(notes);
        if (po instanceof CreditAccount) {
            if (limit != null) ((CreditAccount)po).setLimit(limit);
            if (billDay != null) ((CreditAccount)po).setBillDay(billDay);
        } else if (po instanceof DebtAccount) {
            if (limit != null) ((DebtAccount)po).setLimit(limit);
            if (apr != null) ((DebtAccount)po).setApr(apr);
        }
    }

}
