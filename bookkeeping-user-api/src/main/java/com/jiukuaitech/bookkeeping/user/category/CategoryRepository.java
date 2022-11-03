package com.jiukuaitech.bookkeeping.user.category;

import com.jiukuaitech.bookkeeping.user.book.Book;
import com.jiukuaitech.bookkeeping.user.base.HasBookRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface CategoryRepository extends HasBookRepository<Category> {

    Optional<Category> findOneByBookAndNameAndParentAndType(Book book, String name, Category parent, Integer type);

    List<Category> findAllByBookAndType(Book book, Integer type);

    List<Category> findAllByBook(Book book);

    List<Category> findAllByBookAndTypeAndEnable(Book book, Integer type, Boolean enable);

}
