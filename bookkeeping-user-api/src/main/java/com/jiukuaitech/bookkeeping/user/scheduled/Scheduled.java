package com.jiukuaitech.bookkeeping.user.scheduled;

import com.jiukuaitech.bookkeeping.user.base.BaseEntity;
import com.jiukuaitech.bookkeeping.user.expense.Expense;
import com.jiukuaitech.bookkeeping.user.income.Income;
import com.jiukuaitech.bookkeeping.user.transfer.Transfer;
import com.jiukuaitech.bookkeeping.user.validation.NameValidator;
import com.jiukuaitech.bookkeeping.user.validation.TimeValidator;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Entity
@Table(name="t_scheduled")
@Getter
@Setter
public class Scheduled extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(length = 16, nullable = false, name = "name")
    @NotNull
    @NameValidator
    private String name;

    @Column(nullable = false)
    @NotNull
    @TimeValidator
    private Long startTime;

    @Column(nullable = false)
    private Integer endType; // 1 永不结束 2 设置结束日期 3 设置执行次数

    @TimeValidator
    private Long endTime; //结束日期

    private Integer loopTimes; //执行次数

    @Column(nullable = false)
    private Integer frequencyType;// 1 每天 2 每周 3 每月

    private Integer hour;

    private Integer minute;

    private Boolean autoConfirmed = true;

    @Column(nullable = false)
    private Integer type; // 1 支出 2 收入 3 转账

    @OneToOne
    private Expense expense;

    @OneToOne
    private Income income;

    @OneToOne
    private Transfer transfer;

}
