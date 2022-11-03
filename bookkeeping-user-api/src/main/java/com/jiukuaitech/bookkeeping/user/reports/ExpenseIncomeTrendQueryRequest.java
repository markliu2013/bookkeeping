package com.jiukuaitech.bookkeeping.user.reports;

import com.jiukuaitech.bookkeeping.user.validation.TimeValidator;
import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.Set;

@Getter
@Setter
public class ExpenseIncomeTrendQueryRequest extends TrendTimeQueryRequest {

    private Set<Integer> expenseAccounts;
    private Set<Integer> expensePayees;
    private Set<Integer> expenseCategories;
    private Set<Integer> expenseTags;

    private Set<Integer> incomeAccounts;
    private Set<Integer> incomePayees;
    private Set<Integer> incomeCategories;
    private Set<Integer> incomeTags;

    @NotNull
    @TimeValidator
    private Long minTime;

    @NotNull
    @TimeValidator
    private Long maxTime;

    @NotEmpty
    private String breakType;

}
