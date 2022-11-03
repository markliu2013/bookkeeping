package com.jiukuaitech.bookkeeping.user.user;

import com.jiukuaitech.bookkeeping.user.base.BaseRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends BaseRepository<User, Integer> {
    
    User findOneByUserName(String userName);

}
