package com.jiukuaitech.bookkeeping.user.tag;

import com.jiukuaitech.bookkeeping.user.base.BookNameNotesEnableSpec;
import com.jiukuaitech.bookkeeping.user.book.Book;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.util.StringUtils;

public final class TagSpec {

    public static Specification<Tag> isExpenseable(Boolean expenseable) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get(Tag_.EXPENSEABLE), expenseable);
    }

    public static Specification<Tag> isIncomeable(Boolean incomeable) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get(Tag_.INCOMEABLE), incomeable);
    }

    public static Specification<Tag> isTransferable(Boolean transferable) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get(Tag_.TRANSFERABLE), transferable);
    }

    public static Specification<Tag> buildSpecification(TagQueryRequest request, Book book) {
        Specification<Tag> specification = BookNameNotesEnableSpec.isBook(book);
        if (StringUtils.hasText(request.getName())) {
            specification = specification.and(BookNameNotesEnableSpec.nameLike(request.getName()));
        }
        if (request.getEnable() != null) {
            specification = specification.and(BookNameNotesEnableSpec.isEnable(request.getEnable()));
        }
        if (request.getExpenseable() != null) {
            specification = specification.and(isExpenseable(request.getExpenseable()));
        }
        if (request.getIncomeable() != null) {
            specification = specification.and(isIncomeable(request.getIncomeable()));
        }
        if (request.getTransferable() != null) {
            specification = specification.and(isTransferable(request.getIncomeable()));
        }
        return specification;
    }

}
