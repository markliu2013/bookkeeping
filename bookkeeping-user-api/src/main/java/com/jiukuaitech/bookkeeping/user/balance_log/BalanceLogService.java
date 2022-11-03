package com.jiukuaitech.bookkeeping.user.balance_log;

import com.jiukuaitech.bookkeeping.user.exception.ItemNotFoundException;
import com.jiukuaitech.bookkeeping.user.group.Group;
import com.jiukuaitech.bookkeeping.user.user.User;
import com.jiukuaitech.bookkeeping.user.user.UserService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import javax.persistence.criteria.Predicate;
import java.util.ArrayList;
import java.util.List;


@Service
public class BalanceLogService {

    @Resource
    private BalanceLogRepository balanceLogRepository;

    @Resource
    private UserService userService;

    public Page<BalanceLogVOForList> query(Pageable page, Integer userSignInId) {
        Group group = userService.getUser(userSignInId).getDefaultGroup();
        Specification<BalanceLog> specification = (root, query, criteriaBuilder) -> {
            List<Predicate> predicates = new ArrayList<>();
            predicates.add(criteriaBuilder.equal(root.get(BalanceLog_.group), group));
            return criteriaBuilder.and(predicates.toArray(new Predicate[0]));
        };
        Page<BalanceLog> poPage = balanceLogRepository.findAll(specification, page);
        return poPage.map(BalanceLogVOForList::fromEntity);
    }

    public BalanceLogVOForList add(BalanceLogAddRequest request, Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        Group group = user.getDefaultGroup();
        BalanceLog po = new BalanceLog();
        po.setGroup(group);
        po.setCreator(user);
        po.setAsset(request.getAsset());
        po.setDebt(request.getDebt());
        po.setCreateTime(request.getCreateTime());
        return BalanceLogVOForList.fromEntity(balanceLogRepository.save(po));
    }

    public BalanceLogVOForList remove(Integer id, Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        Group group = user.getDefaultGroup();
        BalanceLog po = balanceLogRepository.findOneByGroupAndId(group, id).orElseThrow(ItemNotFoundException::new);
        balanceLogRepository.delete(po);
        return BalanceLogVOForList.fromEntity(po);
    }

}
