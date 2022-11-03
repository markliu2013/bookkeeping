package com.jiukuaitech.bookkeeping.user.book;

import java.util.ArrayList;
import java.util.List;

import com.jiukuaitech.bookkeeping.user.expense_category.ExpenseCategory;
import com.jiukuaitech.bookkeeping.user.group.Group;
import com.jiukuaitech.bookkeeping.user.income_category.IncomeCategory;
import com.jiukuaitech.bookkeeping.user.user.User;
import com.jiukuaitech.bookkeeping.user.user.UserGroupRelation;
import com.jiukuaitech.bookkeeping.user.account.AccountRepository;
import com.jiukuaitech.bookkeeping.user.exception.ItemNotFoundException;
import com.jiukuaitech.bookkeeping.user.exception.NameExistsException;
import com.jiukuaitech.bookkeeping.user.exception.PermissionException;
import com.jiukuaitech.bookkeeping.user.user.UserGroupRelationRepository;
import com.jiukuaitech.bookkeeping.user.user.UserService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import javax.annotation.Resource;
import javax.persistence.criteria.Predicate;

@Service
public class BookService {

    @Resource
    private UserGroupRelationRepository userGroupRelationRepository;

    @Resource
    private UserService userService;

    @Resource
    private BookRepository bookRepository;

    @Resource
    private AccountRepository accountRepository;

    public Page<BookVOForList> query(Pageable page, Integer userSignInId) {
        Specification<Book> specification = (root, query, criteriaBuilder) -> {
            List<Predicate> predicates = new ArrayList<>();
            User user = userService.getUser(userSignInId);
            predicates.add(criteriaBuilder.equal(root.get(Book_.group), user.getDefaultGroup()));
            return criteriaBuilder.and(predicates.toArray(new Predicate[0]));
        };
        Page<Book> poPage = bookRepository.findAll(specification, page);
        return poPage.map(BookVOForList::fromEntity);
    }

    public BookVOForList get(Integer id, Integer userSignInId) {
        Group group = userService.getUser(userSignInId).getDefaultGroup();
        Book po = bookRepository.findOneByGroupAndId(group, id).orElseThrow(ItemNotFoundException::new);
        return BookVOForList.fromEntity(po);
    }

    public boolean add(BookAddRequest request, Integer userSignInId) {
        Group group = userService.getUser(userSignInId).getDefaultGroup();
        if (bookRepository.findOneByGroupAndName(group, request.getName()).isPresent()) {
            throw new NameExistsException();
        }
        Book po = new Book();
        po.setName(request.getName());
        po.setNotes(request.getNotes());
        po.setGroup(group);
        po.setDescriptionEnable(request.getDescriptionEnable());
        po.setTimeEnable(request.getTimeEnable());
        po.setImageEnable(request.getImageEnable());
        bookRepository.save(po);
        return true;
    }

    public BookVOForList update(Integer id, BookUpdateRequest request, Integer userSignInId) {
        Group group = userService.getUser(userSignInId).getDefaultGroup();
        Book po = bookRepository.findOneByGroupAndId(group, id).orElseThrow(ItemNotFoundException::new);
        if (StringUtils.hasText(request.getName())) {
            if (!po.getName().equals(request.getName())) {
                if (bookRepository.findOneByGroupAndName(po.getGroup(), request.getName()).isPresent()) {
                    throw new NameExistsException();
                }
            }
        }
        if (StringUtils.hasText(request.getName())) po.setName(request.getName());
        if (request.getNotes() != null) po.setNotes(request.getNotes());
        bookRepository.save(po);
        return BookVOForList.fromEntity(po);
    }

    public BookVOForList config(BookUpdateRequest request, Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        Book po = user.getDefaultBook();
        // 不检查默认的账户和分类是不是该账本下的了，后果就是无法记账默认值而已。
        if (request.getDefaultExpenseAccountId() != null) {
            po.setDefaultExpenseAccount(accountRepository.getById(request.getDefaultExpenseAccountId()));
        } else {
            po.setDefaultExpenseAccount(null);
        }

        if (request.getDefaultIncomeAccountId() != null) {
            po.setDefaultIncomeAccount(accountRepository.getById(request.getDefaultIncomeAccountId()));
        } else {
            po.setDefaultIncomeAccount(null);
        }

        if (request.getDefaultTransferFromAccountId() != null) {
            po.setDefaultTransferFromAccount(accountRepository.getById(request.getDefaultTransferFromAccountId()));
        } else {
            po.setDefaultTransferFromAccount(null);
        }

        if (request.getDefaultTransferToAccountId() != null) {
            po.setDefaultTransferToAccount(accountRepository.getById(request.getDefaultTransferToAccountId()));
        } else {
            po.setDefaultTransferToAccount(null);
        }

        if (request.getDefaultExpenseCategoryId() != null) {
            po.setDefaultExpenseCategory(new ExpenseCategory(request.getDefaultExpenseCategoryId()));
        } else {
            po.setDefaultExpenseCategory(null);
        }

        if (request.getDefaultIncomeCategoryId() != null) {
            po.setDefaultIncomeCategory(new IncomeCategory(request.getDefaultIncomeCategoryId()));
        } else {
            po.setDefaultIncomeCategory(null);
        }

        if (request.getDescriptionEnable() != null) po.setDescriptionEnable(request.getDescriptionEnable());
        if (request.getTimeEnable() != null) po.setTimeEnable(request.getTimeEnable());
        if (request.getImageEnable() != null) po.setImageEnable(request.getImageEnable());

        bookRepository.save(po);
        return BookVOForList.fromEntity(po);
    }

    public boolean remove(Integer id, Integer userSignInId) {
        Group group = userService.getUser(userSignInId).getDefaultGroup();
        Book po = bookRepository.findOneByGroupAndId(group, id).orElseThrow(ItemNotFoundException::new);
        UserGroupRelation userGroupRelation = userGroupRelationRepository.findOneByUserAndGroup(new User(userSignInId), po.getGroup());
        if (userGroupRelation == null || userGroupRelation.getRole() != 1) {
            throw new PermissionException("No Permission");
        }
        bookRepository.delete(po);
        return true;
    }

    public boolean toggle(Integer id, Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        Group group = user.getDefaultGroup();
        Book po = bookRepository.findOneByGroupAndId(group, id).orElseThrow(ItemNotFoundException::new);
        if (user.getDefaultBook().equals(po)) {
            throw new ItemNotFoundException();
        }
        po.setEnable(!po.getEnable());
        bookRepository.save(po);
        return true;
    }

}
