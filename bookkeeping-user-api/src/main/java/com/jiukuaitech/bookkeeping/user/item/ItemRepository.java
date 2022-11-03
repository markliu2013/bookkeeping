package com.jiukuaitech.bookkeeping.user.item;

import com.jiukuaitech.bookkeeping.user.base.BaseRepository;
import com.jiukuaitech.bookkeeping.user.user.User;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface ItemRepository extends BaseRepository<Item, Integer> {

    Optional<Item> findOneByUserAndTitle(User user, String title);

    Optional<Item> findOneByUserAndId(User user, Integer id);

}
