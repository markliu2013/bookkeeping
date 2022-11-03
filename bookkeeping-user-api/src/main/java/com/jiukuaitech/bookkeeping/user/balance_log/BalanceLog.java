package com.jiukuaitech.bookkeeping.user.balance_log;

import com.jiukuaitech.bookkeeping.user.group.Group;
import com.jiukuaitech.bookkeeping.user.user.User;
import com.jiukuaitech.bookkeeping.user.validation.BalanceValidator;
import com.jiukuaitech.bookkeeping.user.validation.TimeValidator;
import com.jiukuaitech.bookkeeping.user.base.BaseEntity;
import lombok.Getter;
import lombok.Setter;
import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;

@Entity
@Table(name="t_balance_log")
@Getter
@Setter
public class BalanceLog extends BaseEntity {

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "group_id")
    @NotNull
    private Group group; // 账簿必须属于某个组

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @NotNull
    private User creator;

    @Column(nullable = false) //最多9亿
    @NotNull
    @BalanceValidator
    private BigDecimal asset;

    @Column(nullable = false) //最多9亿
    @NotNull
    @BalanceValidator
    private BigDecimal debt;

    @Column(nullable = false)
    @NotNull
    @TimeValidator
    private Long createTime;

}
