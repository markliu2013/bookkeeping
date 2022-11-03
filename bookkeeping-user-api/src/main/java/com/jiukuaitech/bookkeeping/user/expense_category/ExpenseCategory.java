package com.jiukuaitech.bookkeeping.user.expense_category;

import javax.persistence.*;

import com.jiukuaitech.bookkeeping.user.category.Category;
import lombok.NoArgsConstructor;

/**
 * 支出类别
 */
@Entity
@DiscriminatorValue(value = "1")
@NoArgsConstructor
public class ExpenseCategory extends Category {

    public ExpenseCategory(Integer id) {
        super(id);
    }

}
