package com.jiukuaitech.bookkeeping.user.payee;

import com.jiukuaitech.bookkeeping.user.base.HasBookRepository;
import com.jiukuaitech.bookkeeping.user.book.Book;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface PayeeRepository extends HasBookRepository<Payee> {

    // 添加时判断名称是否重复
    Optional<Payee> findByBookAndName(Book book, String name);

    List<Payee> findByBookAndEnable(Book book, Boolean enable);

    List<Payee> findByBookAndEnableAndExpenseable(Book book, Boolean enable, Boolean expenseable);

    List<Payee> findByBookAndEnableAndIncomeable(Book book, Boolean enable, Boolean incomeable);

    long countByBook(Book book);

}
