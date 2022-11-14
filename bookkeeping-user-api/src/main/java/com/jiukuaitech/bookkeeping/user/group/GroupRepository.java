package com.jiukuaitech.bookkeeping.user.group;

import com.jiukuaitech.bookkeeping.user.base.BaseRepository;
import com.jiukuaitech.bookkeeping.user.user.User;
import org.springframework.stereotype.Repository;


@Repository
public interface GroupRepository extends BaseRepository<Group, Integer> {

    long countByCreator(User creator);

}
