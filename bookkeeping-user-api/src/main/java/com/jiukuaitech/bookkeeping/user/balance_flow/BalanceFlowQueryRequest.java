package com.jiukuaitech.bookkeeping.user.balance_flow;

import java.util.Set;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BalanceFlowQueryRequest {

    private Double minAmount;
    private Double maxAmount;
    private Long minTime;
    private Long maxTime;

    private Integer bookId;
    private Integer accountId;
    private Set<Integer> accounts;
    private Integer status;
    private Integer type;
    private String description;
    private Integer creatorId;
    private Set<Integer> tags;
    private Set<Integer> categories;
    private Set<Integer> payees;

    private Set<Integer> fromAccounts;
    private Set<Integer> toAccounts;

    // 统计支出分类用到
    private Integer categoryId;

    // 按id查询，比如找出退款对应的两条记录
    private Set<Integer> id;

}
