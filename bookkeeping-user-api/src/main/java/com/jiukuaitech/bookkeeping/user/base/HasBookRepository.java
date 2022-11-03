package com.jiukuaitech.bookkeeping.user.base;


import com.jiukuaitech.bookkeeping.user.book.Book;
import org.springframework.data.repository.NoRepositoryBean;
import java.util.Optional;

@NoRepositoryBean
public interface HasBookRepository<T extends HasBookEntity> extends BaseRepository<T, Integer>  {

    Optional<T> findOneByBookAndId(Book book, Integer id);

}
