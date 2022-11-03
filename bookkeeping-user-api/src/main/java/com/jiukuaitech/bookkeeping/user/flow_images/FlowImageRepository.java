package com.jiukuaitech.bookkeeping.user.flow_images;

import com.jiukuaitech.bookkeeping.user.balance_flow.BalanceFlow;
import com.jiukuaitech.bookkeeping.user.user.User;
import com.jiukuaitech.bookkeeping.user.base.BaseRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;


@Repository
public interface FlowImageRepository extends BaseRepository<FlowImage, Integer> {

    Optional<FlowImage> findByUserAndUri(User user, String uri);

    List<FlowImage> findByFlow(BalanceFlow flow);

    Optional<FlowImage> findByUserAndId(User user, Integer id);

}
