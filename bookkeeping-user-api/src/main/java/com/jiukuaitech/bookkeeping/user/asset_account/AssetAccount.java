package com.jiukuaitech.bookkeeping.user.asset_account;

import com.jiukuaitech.bookkeeping.user.account.Account;
import com.jiukuaitech.bookkeeping.user.validation.TimeValidator;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@DiscriminatorValue(value = "4")
@Getter
@Setter
public class AssetAccount extends Account {

    @TimeValidator
    private Long asOfDate; //截止时间，资产余额对应的时间

}
