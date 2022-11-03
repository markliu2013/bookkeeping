package com.jiukuaitech.bookkeeping.user.credit_account;

import com.jiukuaitech.bookkeeping.user.account.AccountAddRequest;
import com.jiukuaitech.bookkeeping.user.validation.BillDayValidator;
import com.jiukuaitech.bookkeeping.user.validation.CreditLimitValidator;
import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotNull;
import java.math.BigDecimal;

@Getter
@Setter
public class CreditAccountAddRequest extends AccountAddRequest {

    @NotNull
    @CreditLimitValidator
    private BigDecimal limit; // 信用额度

    @BillDayValidator
    private Integer billDay; // 每月多少号是账单日

    public void copyPrimitive(CreditAccount po) {
        super.copyPrimitive(po);
        po.setLimit(limit);
        po.setBillDay(billDay);
    }

}
