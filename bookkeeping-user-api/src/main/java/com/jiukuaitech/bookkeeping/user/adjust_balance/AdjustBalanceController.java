package com.jiukuaitech.bookkeeping.user.adjust_balance;

import com.jiukuaitech.bookkeeping.user.base.BaseController;
import com.jiukuaitech.bookkeeping.user.response.BaseResponse;
import com.jiukuaitech.bookkeeping.user.response.DataResponse;
import com.jiukuaitech.bookkeeping.user.balance_flow.BalanceFlowUpdateRequest;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.Valid;


@RestController
@RequestMapping("/adjust-balances")
public class AdjustBalanceController extends BaseController {

    @Resource
    private AdjustBalanceService adjustBalanceService;

    @RequestMapping(method = RequestMethod.PUT, value = "/{id}")
    public BaseResponse handleUpdate(
            @PathVariable("id") Integer id,
            @Valid @RequestBody BalanceFlowUpdateRequest request,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(adjustBalanceService.update(id, request, userSignInId));
    }

}
