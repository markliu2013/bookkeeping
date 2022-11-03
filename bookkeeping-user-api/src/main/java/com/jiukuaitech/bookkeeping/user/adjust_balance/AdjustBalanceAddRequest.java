package com.jiukuaitech.bookkeeping.user.adjust_balance;

import com.jiukuaitech.bookkeeping.user.balance_flow.BalanceFlowAddRequest;
import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotNull;
import java.math.BigDecimal;

@Getter
@Setter
public class AdjustBalanceAddRequest extends BalanceFlowAddRequest {

    @NotNull
    private BigDecimal balance;

}
