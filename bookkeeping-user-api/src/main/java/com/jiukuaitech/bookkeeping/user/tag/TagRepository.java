package com.jiukuaitech.bookkeeping.user.tag;

import com.jiukuaitech.bookkeeping.user.base.HasBookRepository;
import com.jiukuaitech.bookkeeping.user.book.Book;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface TagRepository extends HasBookRepository<Tag> {

    // 添加时判断名称是否重复
    Optional<Tag> findByBookAndName(Book book, String name);

    List<Tag> findByBookAndEnable(Book book, Boolean enable);

    List<Tag> findByBookAndEnableAndExpenseable(Book book, Boolean enable, Boolean expenseable);

    List<Tag> findByBookAndEnableAndIncomeable(Book book, Boolean enable, Boolean incomeable);

    List<Tag> findByBookAndEnableAndTransferable(Book book, Boolean enable, Boolean transferable);

    long countByBook(Book book);

}
