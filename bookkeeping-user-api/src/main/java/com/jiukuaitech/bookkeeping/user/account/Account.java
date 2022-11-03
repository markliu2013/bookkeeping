package com.jiukuaitech.bookkeeping.user.account;

import com.jiukuaitech.bookkeeping.user.base.NameNotesEnableEntity;
import com.jiukuaitech.bookkeeping.user.group.Group;
import com.jiukuaitech.bookkeeping.user.validation.BalanceValidator;
import com.jiukuaitech.bookkeeping.user.validation.NoValidator;
import lombok.Getter;
import lombok.Setter;
import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;

@Entity
@Table(name = "t_account", uniqueConstraints = {@UniqueConstraint(columnNames = {"group_id", "name"})})
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "type", discriminatorType = DiscriminatorType.INTEGER, columnDefinition = "TINYINT(1)")
@Getter
@Setter
public class Account extends NameNotesEnableEntity {

    @Column(insertable = false, updatable = false)
    private Integer type; //1活期，2信用，3贷款，4资产

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "group_id")
    @NotNull
    private Group group; // 账簿必须属于某个组

    @Column(length = 32)
    @NoValidator
    private String no; //卡号

    @Column(nullable = false) //最多9亿
    @NotNull
    @BalanceValidator
    private BigDecimal balance; // 当前余额

    @Column(nullable = false)
    @NotNull
    private Boolean include = true; //净资产是否包含

    @Column(nullable = false)
    @NotNull
    private Boolean expenseable = true; //是否可支出

    @Column(nullable = false)
    @NotNull
    private Boolean incomeable = true; //是否可收入

    @Column(nullable = false)
    @NotNull
    private Boolean transferFromAble = true; //是否转账可转出

    @Column(nullable = false)
    @NotNull
    private Boolean transferToAble = true; //是否转账可转入

    @Column(nullable = false, length = 8)
    @NotNull
    private String currencyCode;

    @Column
    @BalanceValidator
    private BigDecimal initialBalance; // 期初余额

    public Account() { }

    public Account(Integer id) {
        super.setId(id);
    }
}
