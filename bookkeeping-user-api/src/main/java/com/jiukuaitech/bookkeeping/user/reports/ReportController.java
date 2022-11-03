package com.jiukuaitech.bookkeeping.user.reports;

import com.jiukuaitech.bookkeeping.user.balance_flow.BalanceFlowQueryRequest;
import com.jiukuaitech.bookkeeping.user.base.BaseController;
import com.jiukuaitech.bookkeeping.user.response.BaseResponse;
import com.jiukuaitech.bookkeeping.user.response.DataResponse;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.validation.Valid;

@RestController
@RequestMapping("/reports")
public class ReportController extends BaseController {

    @Resource
    private ReportService reportService;

    @RequestMapping(method = RequestMethod.GET, value = "expense-category")
    public BaseResponse handleExpenseCategory(@Valid BalanceFlowQueryRequest request, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(reportService.reportExpenseCategory(request, userSignInId));
    }

    @RequestMapping(method = RequestMethod.GET, value = "expense-tag")
    public BaseResponse handleExpenseTag(@Valid BalanceFlowQueryRequest request, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(reportService.reportExpenseTag(request, userSignInId));
    }

    @RequestMapping(method = RequestMethod.GET, value = "income-category")
    public BaseResponse handleIncomeCategory(@Valid BalanceFlowQueryRequest request,  @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(reportService.reportIncomeCategory(request, userSignInId));
    }

    @RequestMapping(method = RequestMethod.GET, value = "income-tag")
    public BaseResponse handleIncomeTag(@Valid BalanceFlowQueryRequest request, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(reportService.reportIncomeTag(request, userSignInId));
    }

    @RequestMapping(method = RequestMethod.GET, value = "expense-income-trend")
    public BaseResponse handleTrend(@Valid ExpenseIncomeTrendQueryRequest request, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(reportService.reportExpenseIncomeTrend(request, userSignInId));
    }

    @RequestMapping(method = RequestMethod.GET, value = "asset")
    public BaseResponse handleAsset(@RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(reportService.reportAsset(userSignInId));
    }

    @RequestMapping(method = RequestMethod.GET, value = "debt")
    public BaseResponse handleDebt(@RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(reportService.reportDebt(userSignInId));
    }

    @RequestMapping(method = RequestMethod.GET, value = "asset-debt-trend")
    public BaseResponse handleAssetTrend(@Valid TrendTimeQueryRequest request, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(reportService.reportAssetDebtTrend(request, userSignInId));
    }
}
