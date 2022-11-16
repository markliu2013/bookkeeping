package com.jiukuaitech.bookkeeping.user.category_relation;

import com.jiukuaitech.bookkeeping.user.book.Book;
import com.jiukuaitech.bookkeeping.user.category.Category;
import com.jiukuaitech.bookkeeping.user.deal.Deal;
import com.jiukuaitech.bookkeeping.user.validation.AmountValidator;
import com.jiukuaitech.bookkeeping.user.balance_flow.AmountInvalidateException;
import com.jiukuaitech.bookkeeping.user.deal.CategoryConflictException;
import lombok.Getter;
import lombok.Setter;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Getter
@Setter
public class CategoryRelationAddRequest {

    @NotNull
    private Integer categoryId;

    @NotNull
    @AmountValidator
//    @Positive ///可以负数，代表退款
    private BigDecimal amount;

    private BigDecimal convertedAmount;

    public static void checkCategory(List<CategoryRelationAddRequest> categories) {
        Set<Integer> set = new HashSet<>();
        for (CategoryRelationAddRequest item : categories) {
            if (BigDecimal.ZERO.compareTo(item.getAmount()) == 0) {
                throw new AmountInvalidateException();
            }
            if (BigDecimal.ZERO.compareTo(item.getConvertedAmount()) == 0) {
                throw new AmountInvalidateException();
            }
            if (set.contains(item.getCategoryId())) {
                throw new CategoryConflictException();
            } else {
                set.add(item.getCategoryId());
            }
        }
    }

    public CategoryRelation getRelation(Deal deal, Book book) {
        CategoryRelation po = new CategoryRelation();
        po.setAmount(amount);
        if (deal.getAccount().getCurrencyCode().equals(book.getDefaultCurrencyCode())) {
            po.setConvertedAmount(amount);
        } else {
            po.setConvertedAmount(convertedAmount);
        }
        po.setCategory(new Category(categoryId));
        po.setDeal(deal);
        return po;
    }


}
