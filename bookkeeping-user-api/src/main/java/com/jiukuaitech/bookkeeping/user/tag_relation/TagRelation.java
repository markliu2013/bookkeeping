package com.jiukuaitech.bookkeeping.user.tag_relation;

import com.jiukuaitech.bookkeeping.user.base.BaseEntity;
import com.jiukuaitech.bookkeeping.user.tag.Tag;
import com.jiukuaitech.bookkeeping.user.transaction.Transaction;
import com.jiukuaitech.bookkeeping.user.validation.AmountValidator;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;

@Entity
@Table(name = "t_tag_relation", uniqueConstraints = {@UniqueConstraint(columnNames = {"transaction_id", "tag_id"})})
@Getter
@Setter
public class TagRelation extends BaseEntity {
    
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @NotNull
    @JoinColumn(name = "tag_id")
    private Tag tag;

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @NotNull
    @JoinColumn(name = "transaction_id")
    private Transaction transaction;

    @Column(nullable = false)
    @NotNull
    @AmountValidator
    private BigDecimal amount;

    @Column(nullable = false)
    @NotNull
    @AmountValidator
    private BigDecimal convertedAmount; // 金额

}
