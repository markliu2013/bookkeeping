package com.jiukuaitech.bookkeeping.user.dashboard;

import com.jiukuaitech.bookkeeping.user.base.BaseController;
import com.jiukuaitech.bookkeeping.user.response.BaseResponse;
import com.jiukuaitech.bookkeeping.user.response.DataResponse;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
@RequestMapping("/dashboard")
public class DashboardController  extends BaseController {

    @Resource
    private DashboardService dashboardService;

    @RequestMapping(method = RequestMethod.GET, value = "asset-overview")
    public BaseResponse handleAssetOverview(@RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(dashboardService.assetOverview(userSignInId));
    }

    @RequestMapping(method = RequestMethod.GET, value = "expense-income-table")
    public BaseResponse handleTable(@RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(dashboardService.expenseIncomeTable(userSignInId));
    }

    @RequestMapping(method = RequestMethod.GET, value = "expense-trend")
    public BaseResponse handleExpenseTrend(@RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(dashboardService.expenseTrend(userSignInId));
    }

    @RequestMapping(method = RequestMethod.GET, value = "income-trend")
    public BaseResponse handleIncomeTrend(@RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(dashboardService.incomeTrend(userSignInId));
    }

    @RequestMapping(method = RequestMethod.GET, value = "expense-category")
    public BaseResponse handleExpenseCategory(@RequestParam Long start, @RequestParam Long end, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(dashboardService.expenseCategory(start, end, userSignInId));
    }

    @RequestMapping(method = RequestMethod.GET, value = "income-category")
    public BaseResponse handleIncomeCategory(@RequestParam Long start, @RequestParam Long end, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(dashboardService.incomeCategory(start, end, userSignInId));
    }

}
