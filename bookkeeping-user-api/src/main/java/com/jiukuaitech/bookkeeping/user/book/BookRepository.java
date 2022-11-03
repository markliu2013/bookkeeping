package com.jiukuaitech.bookkeeping.user.book;

import com.jiukuaitech.bookkeeping.user.base.BaseRepository;
import com.jiukuaitech.bookkeeping.user.group.Group;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface BookRepository extends BaseRepository<Book, Integer> {
    
    Integer countByGroup_id(Integer groupId);

    Optional<Book> findOneByGroupAndId(Group group, Integer id);

    Optional<Book> findOneByGroupAndName(Group group, String name);

}
