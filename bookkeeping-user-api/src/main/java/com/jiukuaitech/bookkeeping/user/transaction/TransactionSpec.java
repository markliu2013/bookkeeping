package com.jiukuaitech.bookkeeping.user.transaction;

import com.jiukuaitech.bookkeeping.user.balance_flow.BalanceFlowQueryRequest;
import com.jiukuaitech.bookkeeping.user.group.Group;
import com.jiukuaitech.bookkeeping.user.tag_relation.TagRelation;
import com.jiukuaitech.bookkeeping.user.balance_flow.BalanceFlowSpec;
import com.jiukuaitech.bookkeeping.user.tag_relation.TagRelation_;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.util.CollectionUtils;

import javax.persistence.criteria.*;
import java.util.Set;

public final class TransactionSpec {

    public static<T extends Transaction> Specification<T> tagsIn(Set<Integer> tags) {
        return (root, query, criteriaBuilder) -> {
            Join<T, TagRelation> join = root.join(Transaction_.tags);
            return join.get(TagRelation_.tag).in(tags);
        };
    }

    public static<T extends Transaction> Specification<T> buildSpecification(BalanceFlowQueryRequest request, Group group) {
        Specification<T> specification = BalanceFlowSpec.buildSpecification(request, group);
        if (!CollectionUtils.isEmpty(request.getTags())) {
            specification = specification.and(tagsIn(request.getTags()));
        }
        return specification;
    }

}
