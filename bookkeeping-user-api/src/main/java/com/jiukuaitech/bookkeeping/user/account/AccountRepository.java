package com.jiukuaitech.bookkeeping.user.account;

import com.jiukuaitech.bookkeeping.user.base.BaseRepository;
import com.jiukuaitech.bookkeeping.user.group.Group;
import com.jiukuaitech.bookkeeping.user.user.User;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface AccountRepository extends BaseRepository<Account, Integer> {

    Optional<Account> findOneByGroupAndName(Group group, String name);

    Optional<Account> findOneByGroupAndId(Group group, Integer id);

    long countByGroup(Group group);

}
