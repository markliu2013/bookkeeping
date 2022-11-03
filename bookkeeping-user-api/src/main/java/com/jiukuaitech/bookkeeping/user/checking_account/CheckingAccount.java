package com.jiukuaitech.bookkeeping.user.checking_account;

import com.jiukuaitech.bookkeeping.user.account.Account;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;

/**
 * 活期账户，例如银行卡的活期账户，支付宝余额，余额宝，微信零钱等，一般是可以直接用于支出，也可作为收入的入账账户。
 */
@Entity
@DiscriminatorValue(value = "1")
public class CheckingAccount extends Account {

    
}
