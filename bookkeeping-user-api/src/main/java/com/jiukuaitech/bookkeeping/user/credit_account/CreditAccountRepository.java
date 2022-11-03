package com.jiukuaitech.bookkeeping.user.credit_account;

import com.jiukuaitech.bookkeeping.user.base.BaseRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CreditAccountRepository extends BaseRepository<CreditAccount, Integer> {

/*
    @Query("SELECT COALESCE(SUM(p.balance), 0), " +
            "COALESCE(SUM(p.expense), 0), " +
            "COALESCE(SUM(p.income), 0), " +
            "COALESCE(SUM(p.transferFrom), 0), " +
            "COALESCE(SUM(p.transferTo), 0), " +
            "COALESCE(SUM(p.limit), 0) " +
            "FROM CreditAccount p WHERE p.book = :book AND p.enable = true")
    List<BigDecimal[]> findSum(Book book);

    @Query("SELECT COALESCE(SUM(p.balance), 0) FROM CreditAccount p WHERE p.book = :book AND p.enable = true AND p.include = true")
    BigDecimal findSumBalance(Book book);
*/

}
