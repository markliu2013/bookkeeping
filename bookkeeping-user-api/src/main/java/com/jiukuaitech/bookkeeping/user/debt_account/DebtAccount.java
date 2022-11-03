package com.jiukuaitech.bookkeeping.user.debt_account;

import com.jiukuaitech.bookkeeping.user.account.Account;
import com.jiukuaitech.bookkeeping.user.validation.AprValidator;
import com.jiukuaitech.bookkeeping.user.validation.CreditLimitValidator;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import java.math.BigDecimal;

/**
 * 负债账户，例如房贷，车贷，应付账款，借呗等。一般不能直接用于支出和收入。
 */
@Entity
@DiscriminatorValue(value = "3")
@Getter
@Setter
public class DebtAccount extends Account {

    @Column(name = "credit_limit")
    @CreditLimitValidator
    private BigDecimal limit; // 信用额度

    @AprValidator
    private BigDecimal apr; // 年化利率(%)

    public DebtAccount() { }

}
