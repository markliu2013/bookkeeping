package com.jiukuaitech.bookkeeping.user.item;

import com.jiukuaitech.bookkeeping.user.user.User;
import org.springframework.data.jpa.domain.Specification;

public final class ItemSpec {

    public static Specification<Item> isUser(User user) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get("user"), user);
    }


    public static Specification<Item> buildSpecification(ItemQueryRequest request, User user) {
        return isUser(user);
    }
}
