package com.jiukuaitech.bookkeeping.user.debt_account;

import com.jiukuaitech.bookkeeping.user.account.AccountSumVO;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;


@Getter
@Setter
public class DebtAccountSumVO extends AccountSumVO {

    private BigDecimal limit;

    private BigDecimal remainLimit;

}
