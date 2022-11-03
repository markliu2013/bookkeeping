package com.jiukuaitech.bookkeeping.user.account;

import com.jiukuaitech.bookkeeping.user.group.Group;
import com.jiukuaitech.bookkeeping.user.base.BookNameNotesEnableSpec;
import org.springframework.data.jpa.domain.Specification;

public final class AccountSpec {

    public static<T extends Account> Specification<T> includeTrue() {
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get(Account_.include), true);
    }

    public static<T extends Account> Specification<T> expenseable() {
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get(Account_.expenseable), true);
    }

    public static<T extends Account> Specification<T> incomeable() {
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get(Account_.incomeable), true);
    }

    public static<T extends Account> Specification<T> transferFromAble() {
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get(Account_.transferFromAble), true);
    }

    public static<T extends Account> Specification<T> transferToAble() {
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get(Account_.transferToAble), true);
    }

    public static<T extends Account> Specification<T> inGroup(Group group) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get(Account_.group), group);
    }

    public static<T extends Account> Specification<T> inGroupAndEnable(Group group) {
        Specification<T> specification = inGroup(group);
        return specification.and(BookNameNotesEnableSpec.enable());
    }

    public static<T extends Account> Specification<T> inGroupAndInclude(Group group) {
        Specification<T> specification = inGroupAndEnable(group);
        return specification.and(includeTrue());
    }

    public static<T extends Account> Specification<T> inGroupAndExpenseable(Group group) {
        Specification<T> specification = inGroupAndEnable(group);
        return specification.and(expenseable());
    }

    public static<T extends Account> Specification<T> inGroupAndIncomeable(Group group) {
        Specification<T> specification = inGroupAndEnable(group);
        return specification.and(incomeable());
    }

    public static<T extends Account> Specification<T> inGroupAndTransferFromAble(Group group) {
        Specification<T> specification = inGroupAndEnable(group);
        return specification.and(transferFromAble());
    }

    public static<T extends Account> Specification<T> inGroupAndTransferToAble(Group group) {
        Specification<T> specification = inGroupAndEnable(group);
        return specification.and(transferToAble());
    }

    public static<T extends Account> Specification<T> buildSpecification(AccountQueryRequest request, Group group) {
        Specification<T> specification = inGroup(group);
        if (request.getEnable() != null) {
            specification = specification.and(BookNameNotesEnableSpec.isEnable(request.getEnable()));
        }
        return specification;
    }

}
