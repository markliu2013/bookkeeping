package com.jiukuaitech.bookkeeping.user.deal;

import com.jiukuaitech.bookkeeping.user.base.BaseEntity;
import com.jiukuaitech.bookkeeping.user.book.Book;
import com.jiukuaitech.bookkeeping.user.category.Category;
import com.jiukuaitech.bookkeeping.user.category_relation.CategoryRelationAddRequest;
import com.jiukuaitech.bookkeeping.user.exception.InputNotValidException;
import com.jiukuaitech.bookkeeping.user.transaction.TransactionAddRequest;
import lombok.Getter;
import lombok.Setter;
import javax.validation.Valid;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.List;
import java.util.stream.Collectors;

@Getter
@Setter
public class DealAddRequest extends TransactionAddRequest {

    @NotNull
    private Integer accountId;

    private Integer payeeId;

    @NotEmpty
    @Valid
    private List<CategoryRelationAddRequest> categories;

    public void copyCategories(Deal po, List<Category> categories, Book book) {
        getCategories().forEach(i-> {
            List<Integer> categoryIds = categories.stream().map(BaseEntity::getId).collect(Collectors.toList());
            if (categoryIds.contains(i.getCategoryId())) {
                po.getCategories().add(i.getRelation(po, book));
            } else {
                throw new InputNotValidException();
            }
        });
    }

}
