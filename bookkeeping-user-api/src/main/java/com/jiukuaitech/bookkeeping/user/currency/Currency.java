package com.jiukuaitech.bookkeeping.user.currency;

import com.jiukuaitech.bookkeeping.user.base.BaseEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;

@Entity
@Table(name = "t_currency")
@Getter
@Setter
public class Currency extends BaseEntity {

    @Column(length = 8, nullable = false, unique = true)
    @NotNull
    private String code;

    @Column(length = 128, nullable = false)
    @NotNull
    private String description;

    @Column(nullable = false) //最多9亿
    @NotNull
    private BigDecimal rate;

}
