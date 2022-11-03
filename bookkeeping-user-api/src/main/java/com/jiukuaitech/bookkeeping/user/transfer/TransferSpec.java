package com.jiukuaitech.bookkeeping.user.transfer;

import com.jiukuaitech.bookkeeping.user.account.Account;
import com.jiukuaitech.bookkeeping.user.balance_flow.BalanceFlowQueryRequest;
import com.jiukuaitech.bookkeeping.user.group.Group;
import com.jiukuaitech.bookkeeping.user.transaction.TransactionSpec;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.util.CollectionUtils;

import javax.persistence.criteria.CriteriaBuilder;
import java.util.Set;

public final class TransferSpec {

    public static Specification<Transfer> fromIn(Set<Integer> accounts) {
        return (root, query, criteriaBuilder) -> {
            CriteriaBuilder.In<Account> in = criteriaBuilder.in(root.get(Transfer_.account));
            accounts.forEach(i -> in.value(new Account(i)));
            return in;
        };
    }

    public static Specification<Transfer> toIn(Set<Integer> accounts) {
        return (root, query, criteriaBuilder) -> {
            CriteriaBuilder.In<Account> in = criteriaBuilder.in(root.get(Transfer_.to));
            accounts.forEach(i -> in.value(new Account(i)));
            return in;
        };
    }

    public static Specification<Transfer> buildSpecification(BalanceFlowQueryRequest request, Group group) {
        Specification<Transfer> specification = TransactionSpec.buildSpecification(request, group);
        if (!CollectionUtils.isEmpty(request.getFromAccounts())) {
            specification = specification.and(fromIn(request.getFromAccounts()));
        }
        if (!CollectionUtils.isEmpty(request.getToAccounts())) {
            specification = specification.and(toIn(request.getToAccounts()));
        }
        return specification;
    }

}
