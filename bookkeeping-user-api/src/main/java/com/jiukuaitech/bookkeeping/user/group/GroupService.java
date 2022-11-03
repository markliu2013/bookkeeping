package com.jiukuaitech.bookkeeping.user.group;

import com.jiukuaitech.bookkeeping.user.book.Book;
import com.jiukuaitech.bookkeeping.user.user.*;
import com.jiukuaitech.bookkeeping.user.book.BookRepository;
import com.jiukuaitech.bookkeeping.user.currency.CurrencyService;
import com.jiukuaitech.bookkeeping.user.exception.ItemNotFoundException;
import com.jiukuaitech.bookkeeping.user.exception.PermissionException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import javax.annotation.Resource;
import javax.persistence.criteria.Join;
import javax.persistence.criteria.Predicate;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class GroupService {

    @Resource
    private UserGroupRelationRepository userGroupRelationRepository;

    @Resource
    private GroupRepository groupRepository;

    @Resource
    private BookRepository bookRepository;

    @Resource
    private CurrencyService currencyService;

    @Resource
    private UserService userService;

    public Page<GroupVOForList> query(Pageable page, Integer userSignInId) {
        Specification<Group> specification = (root, query, criteriaBuilder) -> {
            List<Predicate> predicates = new ArrayList<>();
            query.distinct(true);
            Join<Group, UserGroupRelation> join = root.join(Group_.relations);
            predicates.add(criteriaBuilder.equal(join.get(UserGroupRelation_.user), userSignInId));
            return criteriaBuilder.and(predicates.toArray(new Predicate[0]));
        };
        Page<Group> poPage = groupRepository.findAll(specification, page);
        return poPage.map(GroupVOForList::fromEntity);
    }

    public List<GroupVOForList> getEnable(Integer userSignInId) {
        Specification<Group> specification = (root, query, criteriaBuilder) -> {
            List<Predicate> predicates = new ArrayList<>();
            Join<Group, UserGroupRelation> join = root.join(Group_.relations);
            predicates.add(criteriaBuilder.equal(join.get(UserGroupRelation_.user), userSignInId));
            return criteriaBuilder.and(predicates.toArray(new Predicate[0]));
        };
        List<Group> entityList = groupRepository.findAll(specification);
        return entityList.stream().map(GroupVOForList::fromEntity).collect(Collectors.toList());
    }

    @Transactional
    public boolean add(GroupAddRequest request, Integer userSignInId) {
        currencyService.checkCode(request.getDefaultCurrencyCode());
        User user = userService.getUser(userSignInId);
        Group po = new Group();
        po.setName(request.getName());
        po.setNotes(request.getNotes());
        po.setDefaultCurrencyCode(request.getDefaultCurrencyCode());
        po.setCreator(user);
        groupRepository.save(po);
        Book book = new Book();
        book.setName("默认账本");
        book.setGroup(po);
        bookRepository.save(book);
        po.setDefaultBook(book);
        groupRepository.save(po);
        UserGroupRelation userGroupRelationToAdd = new UserGroupRelation(user, po, 1);
        userGroupRelationRepository.save(userGroupRelationToAdd);
        return true;
    }

    public boolean update(Integer id, GroupUpdateRequest request, Integer userSignInId) {
        Group po = groupRepository.findById(id).orElseThrow(ItemNotFoundException::new);
        UserGroupRelation relation = userGroupRelationRepository.findOneByUserAndGroup(new User(userSignInId), po);
        if (relation == null) throw new PermissionException("No Permission");
        if (StringUtils.hasText(request.getName())) po.setName(request.getName());
        if (request.getNotes() != null) po.setNotes(request.getNotes());
        groupRepository.save(po);
        return true;
    }

    @Transactional
    public boolean remove(Integer id, Integer userSignInId) {
        // 检查关联性
        if (bookRepository.countByGroup_id(id) > 0) {
            throw new GroupHasBookException();
        }
        Group po = groupRepository.findById(id).orElseThrow(ItemNotFoundException::new);
        UserGroupRelation relation = userGroupRelationRepository.findOneByUserAndGroup(new User(userSignInId), po);
        if (relation == null) throw new PermissionException("No Permission");
        userGroupRelationRepository.deleteByGroup(po);
        groupRepository.delete(po);
        return true;
    }

}
