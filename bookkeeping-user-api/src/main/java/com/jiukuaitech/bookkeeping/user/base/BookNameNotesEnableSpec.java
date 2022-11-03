package com.jiukuaitech.bookkeeping.user.base;

import com.jiukuaitech.bookkeeping.user.book.Book;
import org.springframework.data.jpa.domain.Specification;

import javax.persistence.criteria.CriteriaBuilder;
import java.util.Set;

public final class BookNameNotesEnableSpec {

    public static<T> Specification<T> isBook(Book book) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get(BookNameNotesEnableEntity_.BOOK), book);
    }

    public static<T> Specification<T> inBooks(Set<Integer> books) {
        return (root, query, criteriaBuilder) -> {
            CriteriaBuilder.In<Integer> in = criteriaBuilder.in(root.get(BookNameNotesEnableEntity_.BOOK));
            books.forEach(i -> in.value(i));
            return in;
        };
    }

    public static<T> Specification<T> enable() {
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get(BookNameNotesEnableEntity_.ENABLE), true);
    }

    public static<T> Specification<T> isEnable(Boolean enable) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get(BookNameNotesEnableEntity_.ENABLE), enable);
    }

    public static<T> Specification<T> nameLike(String name) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.like(root.get(BookNameNotesEnableEntity_.NAME), "%"+name+"%");
    }

}
