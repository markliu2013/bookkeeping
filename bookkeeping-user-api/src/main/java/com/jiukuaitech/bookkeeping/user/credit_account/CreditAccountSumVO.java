package com.jiukuaitech.bookkeeping.user.credit_account;

import com.jiukuaitech.bookkeeping.user.account.AccountSumVO;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class CreditAccountSumVO extends AccountSumVO {

    private BigDecimal limit;

    public BigDecimal getRemainLimit() {
        return limit.add(getBalance());
    }
}
