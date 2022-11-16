package com.jiukuaitech.bookkeeping.user.income;

import com.jiukuaitech.bookkeeping.user.balance_flow.BalanceFlowQueryRequest;
import com.jiukuaitech.bookkeeping.user.deal.DealQueryResultVO;
import com.jiukuaitech.bookkeeping.user.deal.DealSpec;
import com.jiukuaitech.bookkeeping.user.deal.DealVOForList;
import com.jiukuaitech.bookkeeping.user.group.Group;
import com.jiukuaitech.bookkeeping.user.user.User;
import com.jiukuaitech.bookkeeping.user.user.UserService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.math.BigDecimal;

@Service
public class IncomeService {

    @Resource
    private IncomeRepository incomeRepository;

    @Resource
    private UserService userService;

    public DealQueryResultVO queryWithDefaultBook(BalanceFlowQueryRequest request, Pageable page, Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        request.setBookId(user.getDefaultBook().getId());
        return query(request, page, userSignInId);
    }

    public DealQueryResultVO query(BalanceFlowQueryRequest request, Pageable page, Integer userSignInId) {
        DealQueryResultVO result = new DealQueryResultVO();
        Group defaultGroup = userService.getUser(userSignInId).getDefaultGroup();
        Specification<Income> specification = DealSpec.buildSpecification(request, defaultGroup);
        Page<Income> poPage = incomeRepository.findAll(specification, page);
        Page<DealVOForList> voPage = poPage.map(income -> {
            DealVOForList vo = DealVOForList.fromEntity(income);
            vo.setCurrencyCode(income.getAccount().getCurrencyCode());
            if (income.getBook().getDefaultCurrencyCode().equals(income.getAccount().getCurrencyCode())) {
                vo.setNeedConvert(false);
            } else {
                vo.setNeedConvert(true);
                vo.setToCurrencyCode(income.getBook().getDefaultCurrencyCode());
            }
            return vo;
        });
        result.setResult(voPage);
        if (CollectionUtils.isEmpty(request.getTags())) {
            result.setTotal(incomeRepository.calcAggregate(specification, Income_.convertedAmount, Income.class));
        } else {
            result.setTotal(incomeRepository.findAll(specification).stream().map(Income::getConvertedAmount).reduce(BigDecimal.ZERO, BigDecimal::add));
        }
        return result;
    }

}