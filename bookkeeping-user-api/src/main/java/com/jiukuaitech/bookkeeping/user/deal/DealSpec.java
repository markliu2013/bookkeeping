package com.jiukuaitech.bookkeeping.user.deal;

import com.jiukuaitech.bookkeeping.user.balance_flow.BalanceFlowQueryRequest;
import com.jiukuaitech.bookkeeping.user.category_relation.CategoryRelation;
import com.jiukuaitech.bookkeeping.user.group.Group;
import com.jiukuaitech.bookkeeping.user.payee.Payee;
import com.jiukuaitech.bookkeeping.user.category_relation.CategoryRelation_;
import com.jiukuaitech.bookkeeping.user.transaction.TransactionSpec;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.util.CollectionUtils;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.Join;
import java.util.Set;

public final class DealSpec {

    public static<T extends Deal> Specification<T> payeeIn(Set<Integer> payees) {
        return (root, query, criteriaBuilder) -> {
            CriteriaBuilder.In<Payee> in = criteriaBuilder.in(root.get(Deal_.payee));
            payees.forEach(i -> in.value(new Payee(i)));
            return in;
        };
    }

    public static<T extends Deal> Specification<T> categoriesIn(Set<Integer> categories) {
        return (root, query, criteriaBuilder) -> {
            Join<T, CategoryRelation> join = root.join(Deal_.categories);
            return join.get(CategoryRelation_.category).in(categories);
        };
    }

    public static<T extends Deal> Specification<T> buildSpecification(BalanceFlowQueryRequest request, Group group) {
        Specification<T> specification = TransactionSpec.buildSpecification(request, group);
        if (!CollectionUtils.isEmpty(request.getPayees())) {
            specification = specification.and(payeeIn(request.getPayees()));
        }
        if (!CollectionUtils.isEmpty(request.getCategories())) {
            specification = specification.and(categoriesIn(request.getCategories()));
        }
        return specification;
    }

}
