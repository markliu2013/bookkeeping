package com.jiukuaitech.bookkeeping.user.debt_account;

import com.jiukuaitech.bookkeeping.user.account.AccountAddRequest;
import com.jiukuaitech.bookkeeping.user.validation.AprValidator;
import com.jiukuaitech.bookkeeping.user.validation.CreditLimitValidator;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class DebtAccountAddRequest extends AccountAddRequest {

    @AprValidator
    private BigDecimal apr;

    @CreditLimitValidator
    private BigDecimal limit; // 信用额度

    public void copyPrimitive(DebtAccount po) {
        super.copyPrimitive(po);
        po.setApr(apr);
        po.setLimit(limit);
    }

}
