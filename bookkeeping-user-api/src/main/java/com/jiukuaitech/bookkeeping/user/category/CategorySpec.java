package com.jiukuaitech.bookkeeping.user.category;

import com.jiukuaitech.bookkeeping.user.book.Book;
import com.jiukuaitech.bookkeeping.user.base.BookNameNotesEnableSpec;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.util.StringUtils;

public final class CategorySpec {

    public static Specification<Category> typeEqual(Integer type) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get(Category_.type), type);
    }

    public static Specification<Category> buildSpecification(CategoryQueryRequest request, Integer type, Book book) {
        Specification<Category> specification = BookNameNotesEnableSpec.isBook(book);
        if (request != null) {
            if (StringUtils.hasText(request.getName())) {
                specification = specification.and(BookNameNotesEnableSpec.nameLike(request.getName()));
            }
            if (request.getEnable() != null) {
                specification = specification.and(BookNameNotesEnableSpec.isEnable(request.getEnable()));
            }
        }
        specification = specification.and(typeEqual(type));
        return specification;
    }

}
