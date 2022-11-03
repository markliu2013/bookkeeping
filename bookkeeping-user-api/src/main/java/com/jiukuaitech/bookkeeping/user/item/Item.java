package com.jiukuaitech.bookkeeping.user.item;

import com.jiukuaitech.bookkeeping.user.base.BaseEntity;
import com.jiukuaitech.bookkeeping.user.user.User;
import com.jiukuaitech.bookkeeping.user.validation.NameValidator;
import com.jiukuaitech.bookkeeping.user.validation.NotesValidator;
import com.jiukuaitech.bookkeeping.user.validation.TimeValidator;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "t_item")
@Getter
@Setter
public class Item extends BaseEntity {

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @NotNull
    @JoinColumn(name = "user_id")
    private User user;

    @Column(length = 16, nullable = false)
    @NotNull
    @NameValidator
    private String title;

    @Column(length = 1024)
    @NotesValidator
    private String notes; //备注

    @Column(nullable = false)
    @NotNull
    @TimeValidator
    private Long startDate; //起始日期

    @Column
    @NotNull
    @TimeValidator
    private Long endDate; //结束日期

    @Column
    @TimeValidator
    private Long nextDate; //下次执行日期

    @Column
    @NotNull
    private Integer repeatType; //0单次 1每天，2每月 3每年

    @Column(name = "c_interval")
    private Integer interval; //间隔

    //总执行次数
    @NotNull
    private Integer totalCount;

    //已执行次数
    @NotNull
    private Integer runCount;

}
