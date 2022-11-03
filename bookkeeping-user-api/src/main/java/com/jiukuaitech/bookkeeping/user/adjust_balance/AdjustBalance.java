package com.jiukuaitech.bookkeeping.user.adjust_balance;

import com.jiukuaitech.bookkeeping.user.balance_flow.BalanceFlow;

import javax.persistence.*;

@Entity
@DiscriminatorValue(value = "4")
public class AdjustBalance extends BalanceFlow {
    
}
