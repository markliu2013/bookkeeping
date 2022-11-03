package com.jiukuaitech.bookkeeping.user.credit_account;

import com.jiukuaitech.bookkeeping.user.account.Account;
import com.jiukuaitech.bookkeeping.user.validation.BillDayValidator;
import com.jiukuaitech.bookkeeping.user.validation.CreditLimitValidator;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.validation.constraints.NotNull;

/**
 * 信用账户，例如信用卡，花呗，白条等。一般可以直接用于支出，但不能作为收入的入账账户。
 */
@Entity
@DiscriminatorValue(value = "2")
@Getter
@Setter
public class CreditAccount extends Account {

    // 非空
    @Column(name = "credit_limit")
    @NotNull
    @CreditLimitValidator
    private BigDecimal limit; // 信用额度

    @BillDayValidator
    private Integer billDay; // 每月多少号是账单日

}
