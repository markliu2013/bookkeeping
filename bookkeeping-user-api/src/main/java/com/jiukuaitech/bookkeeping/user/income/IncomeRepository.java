package com.jiukuaitech.bookkeeping.user.income;

import com.jiukuaitech.bookkeeping.user.base.HasBookRepository;
import com.jiukuaitech.bookkeeping.user.book.Book;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;


@Repository
public interface IncomeRepository extends HasBookRepository<Income> {

    @Query("SELECT COALESCE(SUM(p.convertedAmount), 0) FROM Income p WHERE p.book = :book AND p.status <> 2 AND p.createTime BETWEEN :start AND :end")
    BigDecimal findSumAmount(Book book, Long start, Long end);

    @Query("SELECT COUNT(p) FROM Income p WHERE p.book = :book AND p.status <> 2 AND p.createTime BETWEEN :start AND :end")
    Integer findCount(Book book, Long start, Long end);

}
