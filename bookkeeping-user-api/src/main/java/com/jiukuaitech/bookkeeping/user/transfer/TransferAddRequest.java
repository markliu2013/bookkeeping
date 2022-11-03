package com.jiukuaitech.bookkeeping.user.transfer;

import com.jiukuaitech.bookkeeping.user.transaction.Transaction;
import com.jiukuaitech.bookkeeping.user.transaction.TransactionAddRequest;
import com.jiukuaitech.bookkeeping.user.validation.AmountValidator;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Positive;

@Getter
@Setter
public class TransferAddRequest extends TransactionAddRequest {

    @NotNull
    private Integer fromId;

    @NotNull
    private Integer toId;

    @NotNull
    @AmountValidator
    @Positive
    private BigDecimal amount;

    private BigDecimal convertedAmount;

    @Override
    public void copyPrimitive(Transaction po) {
        super.copyPrimitive(po);
        po.setAmount(amount);
    }

}
