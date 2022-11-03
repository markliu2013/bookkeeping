package com.jiukuaitech.bookkeeping.user.transfer;

import com.jiukuaitech.bookkeeping.user.balance_flow.BalanceFlow;
import com.jiukuaitech.bookkeeping.user.transaction.TransactionUpdateRequest;
import com.jiukuaitech.bookkeeping.user.validation.AmountValidator;
import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Positive;
import java.math.BigDecimal;

@Getter
@Setter
public class TransferUpdateRequest extends TransactionUpdateRequest {

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
    public void updatePrimitive(BalanceFlow po) {
        super.updatePrimitive(po);
//        po.setAmount(amount); //涉及到退款问题，需要在退款之前改变
    }

}
