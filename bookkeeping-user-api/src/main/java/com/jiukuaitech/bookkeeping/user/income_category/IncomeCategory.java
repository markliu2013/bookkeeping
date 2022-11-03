package com.jiukuaitech.bookkeeping.user.income_category;

import javax.persistence.*;

import com.jiukuaitech.bookkeeping.user.category.Category;
import lombok.NoArgsConstructor;

/**
 * 收入类别
 */
@Entity
@DiscriminatorValue(value = "2")
@NoArgsConstructor
public class IncomeCategory extends Category {

    public IncomeCategory(Integer id) {
        super(id);
    }

}
