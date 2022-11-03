package com.jiukuaitech.bookkeeping.user.balance_flow;

import com.jiukuaitech.bookkeeping.user.account.Account;
import com.jiukuaitech.bookkeeping.user.book.Book;
import com.jiukuaitech.bookkeeping.user.category_relation.CategoryRelation;
import com.jiukuaitech.bookkeeping.user.deal.Deal;
import com.jiukuaitech.bookkeeping.user.group.Group;
import com.jiukuaitech.bookkeeping.user.payee.Payee;
import com.jiukuaitech.bookkeeping.user.tag_relation.TagRelation;
import com.jiukuaitech.bookkeeping.user.transfer.Transfer;
import com.jiukuaitech.bookkeeping.user.user.User;
import com.jiukuaitech.bookkeeping.user.base.BookNameNotesEnableSpec;
import com.jiukuaitech.bookkeeping.user.category_relation.CategoryRelation_;
import com.jiukuaitech.bookkeeping.user.deal.Deal_;
import com.jiukuaitech.bookkeeping.user.tag_relation.TagRelation_;
import com.jiukuaitech.bookkeeping.user.transaction.Transaction;
import com.jiukuaitech.bookkeeping.user.transaction.Transaction_;
import com.jiukuaitech.bookkeeping.user.transfer.Transfer_;
import com.jiukuaitech.bookkeeping.user.utils.CalendarUtils;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import javax.persistence.criteria.*;
import java.util.Set;

public final class BalanceFlowSpec {
    
    public static<T extends BalanceFlow> Specification<T> amountGreaterThanOrEqualTo(Double amount) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.ge(root.get(BalanceFlow_.AMOUNT), amount);
    }

    public static<T extends BalanceFlow> Specification<T> amountLessThanOrEqualTo(Double amount) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.le(root.get(BalanceFlow_.AMOUNT), amount);
    }

    public static<T extends BalanceFlow> Specification<T> createTimeGreaterThanOrEqualTo(Long time) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.ge(root.get(BalanceFlow_.CREATE_TIME), time);
    }

    public static<T extends BalanceFlow> Specification<T> createTimeLessThanOrEqualTo(Long time) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.le(root.get(BalanceFlow_.CREATE_TIME), time);
    }

    public static<T extends BalanceFlow> Specification<T> creatorEqual(User user) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get(BalanceFlow_.CREATOR), user);
    }

    public static<T extends BalanceFlow> Specification<T> accountIn(Set<Integer> accounts) {
        return (root, query, criteriaBuilder) -> {
            CriteriaBuilder.In<Account> in = criteriaBuilder.in(root.get(BalanceFlow_.ACCOUNT));
            accounts.forEach(i -> in.value(new Account(i)));
            return in;
        };
    }

    public static<T extends BalanceFlow> Specification<T> idIn(Set<Integer> id) {
        return (root, query, criteriaBuilder) -> {
            CriteriaBuilder.In<Integer> in = criteriaBuilder.in(root.get(BalanceFlow_.ID));
            id.forEach(i -> in.value(i));
            return in;
        };
    }

    public static<T extends BalanceFlow> Specification<T> typeEqual(Integer type) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get(BalanceFlow_.TYPE), type);
    }

    public static<T extends BalanceFlow> Specification<T> isGroup(Group group) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get(BalanceFlow_.GROUP), group);
    }

    public static<T extends BalanceFlow> Specification<T> statusEqual(Integer status) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get(BalanceFlow_.STATUS), status);
    }

    // 不是待确认的状态
    public static<T extends BalanceFlow> Specification<T> statusConfirmed() {
        return (root, query, criteriaBuilder) -> criteriaBuilder.notEqual(root.get(BalanceFlow_.STATUS), 2);
    }

    public static<T extends BalanceFlow> Specification<T> descriptionEqual(String description) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get(BalanceFlow_.DESCRIPTION), description);
    }

    public static<T extends BalanceFlow> Specification<T> distinct() {
        return (root, query, cb) -> {
            query.distinct(true);
//            query.groupBy(root.get(BalanceFlow_.id));
            return null;
        };
    }

    private static<T extends BalanceFlow> Specification<T> buildBaseSpecification(BalanceFlowQueryRequest request, Group group) {
        Specification<T> specification = isGroup(group);
        if (request.getBookId() != null) {
            specification = specification.and(BookNameNotesEnableSpec.isBook(new Book(request.getBookId())));
        }
        if (request.getMinAmount() != null) {
            specification = specification.and(amountGreaterThanOrEqualTo(request.getMinAmount()));
        }
        if (request.getMaxAmount() != null) {
            specification = specification.and(amountLessThanOrEqualTo(request.getMaxAmount()));
        }
        if (request.getMinTime() != null) {
            specification = specification.and(createTimeGreaterThanOrEqualTo(CalendarUtils.getStartOfDay(request.getMinTime())));
        }
        if (request.getMaxTime() != null) {
            specification = specification.and(createTimeLessThanOrEqualTo(CalendarUtils.getEndOfDay(request.getMaxTime())));
        }
        if (request.getCreatorId() != null) {
            specification = specification.and(creatorEqual(new User(request.getCreatorId())));
        }
        if (request.getStatus() != null) {
            specification = specification.and(statusEqual(request.getStatus()));
        }
        if (StringUtils.hasText(request.getDescription())) {
            specification = specification.and(descriptionEqual(request.getDescription()));
        }
        if (!CollectionUtils.isEmpty(request.getId())) {
            specification = specification.and(idIn(request.getId()));
        }
        specification = specification.and(distinct());
        return specification;
    }

    // 给子类调用
    public static<T extends BalanceFlow> Specification<T> buildSpecification(BalanceFlowQueryRequest request, Group group) {
        Specification<T> specification = buildBaseSpecification(request, group);
        if (!CollectionUtils.isEmpty(request.getAccounts())) {
            specification = specification.and(accountIn(request.getAccounts()));
        }
        return specification;
    }

    public static Specification<BalanceFlow> buildFlowSpecification(BalanceFlowQueryRequest request, Group group) {
        Specification<BalanceFlow> specification = buildBaseSpecification(request, group);

        if (request.getAccountId() != null) {
            specification = specification.and((Specification<BalanceFlow>) (root, query, criteriaBuilder) -> {
                Account account = new Account(request.getAccountId());
                Predicate predicate1 = criteriaBuilder.equal(root.get(BalanceFlow_.account), account);
                // https://stackoverflow.com/questions/34251930/jpa-criteria-api-query-subclass-property
//                Root<Transfer> transferRoot = criteriaBuilder.treat(root, Transfer.class);
                @SuppressWarnings("unchecked")
                Root<Transfer> transferRoot = (Root<Transfer>) (Root<?>) root;
                Predicate predicate2 = criteriaBuilder.equal(transferRoot.get(Transfer_.to), account);
                return criteriaBuilder.or(predicate1, predicate2);
            });
        } else if (!CollectionUtils.isEmpty(request.getAccounts())) {
            specification = specification.and((Specification<BalanceFlow>) (root, query, criteriaBuilder) -> {
                CriteriaBuilder.In<Account> in1 = criteriaBuilder.in(root.get(BalanceFlow_.account));
                request.getAccounts().forEach(i -> in1.value(new Account(i)));
                @SuppressWarnings("unchecked")
                Root<Transfer> transferRoot = (Root<Transfer>) (Root<?>) root;
                CriteriaBuilder.In<Account> in2 = criteriaBuilder.in(transferRoot.get(Transfer_.to));
                request.getAccounts().forEach(i -> in2.value(new Account(i)));
                return criteriaBuilder.or(in1, in2);
            });
        }

        if (!CollectionUtils.isEmpty(request.getPayees())) {
            specification = specification.and((Specification<BalanceFlow>) (root, query, criteriaBuilder) -> {
//                Root<Deal> dealRoot = criteriaBuilder.treat(root, Deal.class);
                Root<Deal> dealRoot = (Root<Deal>) (Root<?>) root;
                CriteriaBuilder.In<Payee> in = criteriaBuilder.in(dealRoot.get(Deal_.payee));
                request.getPayees().forEach(i -> in.value(new Payee(i)));
                return in;
            });
        }

        if (!CollectionUtils.isEmpty(request.getCategories())) {
            specification = specification.and((Specification<BalanceFlow>) (root, query, criteriaBuilder) -> {
                Root<Deal> dealRoot = (Root<Deal>) (Root<?>) root;
                Join<Deal, CategoryRelation> join = dealRoot.join(Deal_.categories);
                return join.get(CategoryRelation_.category).in(request.getCategories());
            });
        }

        if (!CollectionUtils.isEmpty(request.getTags())) {
            specification = specification.and((Specification<BalanceFlow>) (root, query, criteriaBuilder) -> {
                Root<Transaction> transactionRoot = criteriaBuilder.treat(root, Transaction.class);
                Join<Transaction, TagRelation> join = transactionRoot.join(Transaction_.tags);
                return join.get(TagRelation_.tag).in(request.getTags());
            });
        }
        if (request.getType() != null) {
            specification = specification.and(typeEqual(request.getType()));
        }

        return specification;
    }

}
