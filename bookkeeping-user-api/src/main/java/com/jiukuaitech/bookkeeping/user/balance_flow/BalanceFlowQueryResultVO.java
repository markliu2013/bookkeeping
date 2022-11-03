package com.jiukuaitech.bookkeeping.user.balance_flow;

import lombok.Getter;
import lombok.Setter;
import org.springframework.data.domain.Page;
import java.math.BigDecimal;

@Getter
@Setter
public class BalanceFlowQueryResultVO {

    private Page<BalanceFlowVOForList> result;
    private BigDecimal expense;
    private BigDecimal income;

    public BigDecimal getSurplus() {
        return income.subtract(expense);
    }

}
