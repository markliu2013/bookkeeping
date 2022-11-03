package com.jiukuaitech.bookkeeping.user.expense;

import com.jiukuaitech.bookkeeping.user.balance_flow.BalanceFlowQueryRequest;
import com.jiukuaitech.bookkeeping.user.deal.DealAddRequest;
import com.jiukuaitech.bookkeeping.user.deal.DealUpdateRequest;
import com.jiukuaitech.bookkeeping.user.base.BaseController;
import com.jiukuaitech.bookkeeping.user.deal.DealService;
import com.jiukuaitech.bookkeeping.user.response.BaseResponse;
import com.jiukuaitech.bookkeeping.user.response.DataResponse;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.Valid;

@RestController
@RequestMapping("/expenses")
public class ExpenseController extends BaseController {

    @Resource
    private ExpenseService expenseService;

    @Resource
    private DealService dealService;

    @RequestMapping(method = RequestMethod.POST, value = "")
    public BaseResponse handleAdd(
            @Valid @RequestBody DealAddRequest request,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        dealService.add(1, request, userSignInId, false);
        return new BaseResponse(true);
    }

    @RequestMapping(method = RequestMethod.GET, value = "")
    public BaseResponse handleQuery(
            @Valid BalanceFlowQueryRequest request,
            @PageableDefault(sort = {"createTime", "id"}, direction = Sort.Direction.DESC) Pageable page,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(expenseService.queryWithDefaultBook(request, page, userSignInId));
    }

    @RequestMapping(method = RequestMethod.PUT, value = "/{id}")
    public BaseResponse handleUpdate(
            @PathVariable("id") Integer id,
            @Valid @RequestBody DealUpdateRequest request,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new BaseResponse(dealService.update(1, id, request, userSignInId));
    }

    @RequestMapping(method = RequestMethod.POST, value = "{id}/refund")
    public BaseResponse handleRefund(
            @PathVariable("id") Integer id,
            @Valid @RequestBody DealAddRequest request,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new BaseResponse(dealService.refund(1, id, request, userSignInId));
    }

}
