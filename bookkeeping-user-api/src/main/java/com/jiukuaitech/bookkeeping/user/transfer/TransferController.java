package com.jiukuaitech.bookkeeping.user.transfer;

import com.jiukuaitech.bookkeeping.user.balance_flow.BalanceFlowQueryRequest;
import com.jiukuaitech.bookkeeping.user.base.BaseController;
import com.jiukuaitech.bookkeeping.user.response.BaseResponse;
import com.jiukuaitech.bookkeeping.user.response.DataResponse;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.Valid;

@RestController
@RequestMapping("/transfers")
public class TransferController extends BaseController {

    @Resource
    private TransferService transferService;

    @RequestMapping(method = RequestMethod.POST, value = "")
    public BaseResponse handleAdd(
            @Valid @RequestBody TransferAddRequest request,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new BaseResponse(transferService.add(request, userSignInId));
    }

    @RequestMapping(method = RequestMethod.GET, value = "")
    public BaseResponse handleQuery(
            @Valid BalanceFlowQueryRequest request,
            @PageableDefault(sort = {"createTime", "id"}, direction = Sort.Direction.DESC) Pageable page,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(transferService.queryWithDefaultBook(request, page, userSignInId));
    }

    @RequestMapping(method = RequestMethod.PUT, value = "/{id}")
    public BaseResponse handleUpdate(
            @PathVariable("id") Integer id,
            @Valid @RequestBody TransferUpdateRequest request,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new BaseResponse(transferService.update(id, request, userSignInId));
    }

}
