package com.jiukuaitech.bookkeeping.user.refund;

import com.jiukuaitech.bookkeeping.user.deal.Deal;
import com.jiukuaitech.bookkeeping.user.base.BaseEntity;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Entity
@Table(name="t_refund")
@Getter
@Setter
@NoArgsConstructor
public class Refund extends BaseEntity {

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @NotNull
    private Deal deal;

    @OneToOne(optional = false, fetch = FetchType.LAZY)
    @NotNull
    private Deal refund;

    public Refund(Deal deal, Deal refund) {
        this.deal = deal;
        this.refund = refund;
    }
}
