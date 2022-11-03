package com.jiukuaitech.bookkeeping.user.payee;

import com.jiukuaitech.bookkeeping.user.base.BookNameNotesEnableSpec;
import com.jiukuaitech.bookkeeping.user.book.Book;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.util.StringUtils;

public final class PayeeSpec {

    public static Specification<Payee> isExpenseable(Boolean expenseable) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get(Payee_.EXPENSEABLE), expenseable);
    }

    public static Specification<Payee> isIncomeable(Boolean incomeable) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get(Payee_.INCOMEABLE), incomeable);
    }

    public static Specification<Payee> buildSpecification(PayeeQueryRequest request, Book book) {
        Specification<Payee> specification = BookNameNotesEnableSpec.isBook(book);
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
        return specification;
    }

}
