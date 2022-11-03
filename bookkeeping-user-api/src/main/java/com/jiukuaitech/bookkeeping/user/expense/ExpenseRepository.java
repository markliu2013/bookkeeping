package com.jiukuaitech.bookkeeping.user.expense;

import com.jiukuaitech.bookkeeping.user.base.HasBookRepository;
import com.jiukuaitech.bookkeeping.user.book.Book;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.math.BigDecimal;


@Repository
public interface ExpenseRepository extends HasBookRepository<Expense> {

    @Query("SELECT COALESCE(SUM(p.convertedAmount), 0) FROM Expense p WHERE p.book = :book AND p.status <> 2 AND p.createTime BETWEEN :start AND :end")
    BigDecimal findSumAmount(Book book, Long start, Long end);

    @Query("SELECT COUNT(p) FROM Expense p WHERE p.book = :book AND p.status <> 2 AND p.createTime BETWEEN :start AND :end")
    Integer findCount(Book book, Long start, Long end);

    // n+1
//    @EntityGraph(value = "Expense.Graph", type = EntityGraph.EntityGraphType.FETCH)
//    List<Expense> findAll(Specification<Expense> specification);
//
//    @EntityGraph(value = "Expense.Graph", type = EntityGraph.EntityGraphType.FETCH)
//    Page<Expense> findAll(Specification<Expense> specification, Pageable page);

}
