package com.jiukuaitech.bookkeeping.user.balance_log;

import com.jiukuaitech.bookkeeping.user.validation.BalanceValidator;
import com.jiukuaitech.bookkeeping.user.validation.TimeValidator;
import lombok.Getter;
import lombok.Setter;
import javax.persistence.Column;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;

@Getter
@Setter
public class BalanceLogAddRequest {

    @NotNull
    @BalanceValidator
    private BigDecimal asset;

    @NotNull
    @BalanceValidator
    private BigDecimal debt;

    @Column(nullable = false)
    @NotNull
    @TimeValidator
    private Long createTime;

}
