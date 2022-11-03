package com.jiukuaitech.bookkeeping.user.user;

import com.jiukuaitech.bookkeeping.user.group.Group;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserGroupRelationRepository extends CrudRepository<UserGroupRelation, Integer> {
    
    UserGroupRelation findOneByUserAndGroup(User user, Group group);
    
    List<UserGroupRelation> findByUser(User user);

    Integer deleteByGroup(Group group);

}
