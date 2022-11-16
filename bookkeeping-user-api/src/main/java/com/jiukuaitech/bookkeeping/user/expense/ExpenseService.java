package com.jiukuaitech.bookkeeping.user.expense;

import com.jiukuaitech.bookkeeping.user.deal.DealQueryResultVO;
import com.jiukuaitech.bookkeeping.user.deal.DealSpec;
import com.jiukuaitech.bookkeeping.user.deal.DealVOForList;
import com.jiukuaitech.bookkeeping.user.group.Group;
import com.jiukuaitech.bookkeeping.user.user.User;
import com.jiukuaitech.bookkeeping.user.user.UserService;
import com.jiukuaitech.bookkeeping.user.balance_flow.BalanceFlowQueryRequest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.math.BigDecimal;

@Service
public class ExpenseService {

    @Resource
    private ExpenseRepository expenseRepository;

    @Resource
    private UserService userService;

    public DealQueryResultVO queryWithDefaultBook(BalanceFlowQueryRequest request, Pageable page, Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        request.setBookId(user.getDefaultBook().getId());
        return query(request, page, userSignInId);
    }

    public DealQueryResultVO query(BalanceFlowQueryRequest request, Pageable page, Integer userSignInId) {
        DealQueryResultVO result = new DealQueryResultVO();
        // 缓存了，可以避免n+1
//        payeeRepository.findByBookAndEnableAndExpenseable(user.getDefaultBook(), true, true);
//        accountRepository.findByBookAndEnableAndExpenseable(user.getDefaultBook(), true, true);
//        expenseCategoryRepository.findByBook(user.getDefaultBook());
//        tagRepository.findByBookAndEnableAndExpenseable(user.getDefaultBook(), true, true);
//        Specification<Expense> specification = (root, query, criteriaBuilder) -> {
//            List<Predicate> predicates = DealUtils.buildExpensePredicates(request, user, root, criteriaBuilder);
            // join查询，避免n+1
//            root.fetch("payee");
//            root.fetch("account");
//            root.fetch("categories");
//            root.fetch("tags");
//            return criteriaBuilder.and(predicates.toArray(new Predicate[0]));
//        };
        Group defaultGroup = userService.getUser(userSignInId).getDefaultGroup();
        Specification<Expense> specification = DealSpec.buildSpecification(request, defaultGroup);
        Page<Expense> poPage = expenseRepository.findAll(specification, page);
        Page<DealVOForList> voPage = poPage.map(expense -> {
            DealVOForList vo = DealVOForList.fromEntity(expense);
            vo.setCurrencyCode(expense.getAccount().getCurrencyCode());
            if (expense.getBook().getDefaultCurrencyCode().equals(expense.getAccount().getCurrencyCode())) {
                vo.setNeedConvert(false);
            } else {
                vo.setNeedConvert(true);
                vo.setToCurrencyCode(expense.getBook().getDefaultCurrencyCode());
            }
            return vo;
        });
        result.setResult(voPage);
/*
        CriteriaBuilder criteriaBuilder = em.getCriteriaBuilder();
        CriteriaQuery<Tuple> query = criteriaBuilder.createTupleQuery();
        Root<Expense> root = query.from(Expense.class);
        query.select(criteriaBuilder.tuple(criteriaBuilder.sum(root.get(Expense_.amount))));
        query.where(predicates.toArray(new Predicate[0]));
        TypedQuery<Tuple> resultQuery = em.createQuery(query);
        Tuple tuple = resultQuery.getSingleResult();
        result.setTotal(tuple.get(0) == null ? BigDecimal.valueOf(0) : (BigDecimal) tuple.get(0));
        */

        // 解决join查询重复问题，应该考虑子查询
        if (CollectionUtils.isEmpty(request.getTags())) {
            result.setTotal(expenseRepository.calcAggregate(specification, Expense_.convertedAmount, Expense.class));
        } else {
            result.setTotal(expenseRepository.findAll(specification).stream().map(Expense::getConvertedAmount).reduce(BigDecimal.ZERO, BigDecimal::add));
        }

        return result;
    }

}