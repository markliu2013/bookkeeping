package com.jiukuaitech.bookkeeping.user.payee;

import com.jiukuaitech.bookkeeping.user.base.BookNameNotesEnableEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "t_payee", uniqueConstraints = {@UniqueConstraint(columnNames = {"book_id", "name"})})
@Getter
@Setter
/**
 * 交易对象
 */
public class Payee extends BookNameNotesEnableEntity {

    @Column(nullable = false)
    @NotNull
    private Boolean expenseable = true; //是否可支出

    @Column(nullable = false)
    @NotNull
    private Boolean incomeable = true; //是否可收入

    public Payee() { }

    public Payee(Integer id) {
        super.setId(id);
    }

}
