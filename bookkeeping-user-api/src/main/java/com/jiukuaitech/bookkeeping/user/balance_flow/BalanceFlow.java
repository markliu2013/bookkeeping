package com.jiukuaitech.bookkeeping.user.balance_flow;

import com.jiukuaitech.bookkeeping.user.account.Account;
import com.jiukuaitech.bookkeeping.user.base.HasBookEntity;
import com.jiukuaitech.bookkeeping.user.flow_images.FlowImage;
import com.jiukuaitech.bookkeeping.user.group.Group;
import com.jiukuaitech.bookkeeping.user.user.User;
import com.jiukuaitech.bookkeeping.user.validation.*;
import lombok.Getter;
import lombok.Setter;
import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name="t_balance_flow")
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "type", discriminatorType = DiscriminatorType.INTEGER, columnDefinition = "TINYINT(1)")
@Getter
@Setter
public class BalanceFlow extends HasBookEntity {

    @Column(nullable = false)
    @NotNull
    @AmountValidator
    private BigDecimal amount; // 金额

    @AmountValidator
    private BigDecimal convertedAmount; //汇率换算之后的金额

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @NotNull
    private Account account;

    @Column(nullable = false)
    @NotNull
    @TimeValidator
    private Long createTime;

    @Column(nullable = false, columnDefinition = "TINYINT(1)")
    @NotNull
    @TransactionStatusValidator
    private Integer status = 1; // 1正常 2是待确认 3是已退款

    @Column(insertable = false, updatable = false)
    private Integer type; //1支出，2收入，3转账，4余额调整

    @Column(length = 16)
    @DescriptionValidator
    private String description; //描述

    @Column(length = 1024)
    @NotesValidator
    private String notes; //备注

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @NotNull
    private User creator;

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @NotNull
    private Group group;

    @OneToMany(mappedBy = "flow", fetch = FetchType.LAZY)
    private Set<FlowImage> images = new HashSet<>();

}
