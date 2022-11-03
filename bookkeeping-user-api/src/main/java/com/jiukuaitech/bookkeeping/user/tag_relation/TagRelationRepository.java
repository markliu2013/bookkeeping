package com.jiukuaitech.bookkeeping.user.tag_relation;

import com.jiukuaitech.bookkeeping.user.base.BaseRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface TagRelationRepository extends BaseRepository<TagRelation, Integer> {

    Integer countByTag_id(Integer tagId);

}
