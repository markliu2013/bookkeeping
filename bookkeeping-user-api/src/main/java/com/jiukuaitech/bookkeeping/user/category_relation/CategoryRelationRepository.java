package com.jiukuaitech.bookkeeping.user.category_relation;

import com.jiukuaitech.bookkeeping.user.book.Book;
import com.jiukuaitech.bookkeeping.user.base.BaseRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface CategoryRelationRepository extends BaseRepository<CategoryRelation, Integer> {

    @Query("SELECT p1 FROM CategoryRelation p1 INNER JOIN p1.deal p2 WHERE p2.book = :book AND p2.status <> 2 AND p2.createTime BETWEEN :start AND :end")
    List<CategoryRelation> findByBookAndCreateTimeBetween(Book book, Long start, Long end);

    Integer countByCategory_id(Integer id);

}
