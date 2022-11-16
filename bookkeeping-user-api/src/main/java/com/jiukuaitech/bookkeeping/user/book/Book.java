package com.jiukuaitech.bookkeeping.user.book;

import com.jiukuaitech.bookkeeping.user.expense_category.ExpenseCategory;
import com.jiukuaitech.bookkeeping.user.income_category.IncomeCategory;
import com.jiukuaitech.bookkeeping.user.account.Account;
import com.jiukuaitech.bookkeeping.user.base.NameNotesEnableEntity;
import com.jiukuaitech.bookkeeping.user.group.Group;
import lombok.Getter;
import lombok.Setter;
import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Entity
@Table(name="t_book", uniqueConstraints = {@UniqueConstraint(columnNames = {"group_id", "name"})})
@Getter
@Setter
/**
 * 账簿类，它属于某个组管理。下面会有很多账户。
 * group+name决定一个账簿。
 */
public class Book extends NameNotesEnableEntity {

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "group_id")
    @NotNull
    private Group group; // 账簿必须属于某个组

    @OneToOne
    private Account defaultExpenseAccount;

    @OneToOne
    private Account defaultIncomeAccount;

    @OneToOne
    private Account defaultTransferFromAccount;

    @OneToOne
    private Account defaultTransferToAccount;

    @OneToOne
    private ExpenseCategory defaultExpenseCategory;

    @OneToOne
    private IncomeCategory defaultIncomeCategory;

    @Column(nullable = false)
    @NotNull
    private Boolean descriptionEnable = true;

    @Column(nullable = false)
    @NotNull
    private Boolean timeEnable = false;

    @Column(nullable = false)
    @NotNull
    private Boolean imageEnable = false;

    @Column(nullable = false, length = 8)
    @NotNull
    private String defaultCurrencyCode;//默认的币种

    public Book() { }

    public Book(Integer id) {
        super.setId(id);
    }
}
