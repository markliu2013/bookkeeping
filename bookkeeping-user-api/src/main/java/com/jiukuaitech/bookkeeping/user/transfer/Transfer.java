package com.jiukuaitech.bookkeeping.user.transfer;

import com.jiukuaitech.bookkeeping.user.account.Account;
import com.jiukuaitech.bookkeeping.user.transaction.Transaction;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@DiscriminatorValue(value = "3")
@Getter
@Setter
public class Transfer extends Transaction {

    // from 和父类的 account 共用

    @ManyToOne(fetch = FetchType.LAZY)
    private Account to;

}
