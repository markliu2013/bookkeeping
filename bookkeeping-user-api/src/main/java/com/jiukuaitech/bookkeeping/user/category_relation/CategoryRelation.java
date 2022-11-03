package com.jiukuaitech.bookkeeping.user.category_relation;

import com.jiukuaitech.bookkeeping.user.category.Category;
import com.jiukuaitech.bookkeeping.user.deal.Deal;
import com.jiukuaitech.bookkeeping.user.validation.AmountValidator;
import com.jiukuaitech.bookkeeping.user.base.BaseEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;

@Entity
//@Table(name = "t_category_relation", uniqueConstraints = {@UniqueConstraint(columnNames = {"deal_id", "category_id"})})
@Table(name = "t_category_relation")
@Getter
@Setter
public class CategoryRelation extends BaseEntity {

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id")
    @NotNull
    private Category category;

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "deal_id")
    @NotNull
    private Deal deal;

    @Column(nullable = false)
    @NotNull
    @AmountValidator
    private BigDecimal amount; // 金额

    @Column(nullable = false)
    @NotNull
    @AmountValidator
    private BigDecimal convertedAmount; // 金额

}
