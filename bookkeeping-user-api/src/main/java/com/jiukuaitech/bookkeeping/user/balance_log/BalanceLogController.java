package com.jiukuaitech.bookkeeping.user.balance_log;

import com.jiukuaitech.bookkeeping.user.response.BaseResponse;
import com.jiukuaitech.bookkeeping.user.response.DataResponse;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.Valid;

@RestController
@RequestMapping("/logs")
public class BalanceLogController {

    @Resource
    private BalanceLogService balanceLogService;

    @RequestMapping(method = RequestMethod.GET, value = "")
    public BaseResponse handleQuery(
            @PageableDefault(sort = "createTime", direction = Sort.Direction.DESC) Pageable page,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(balanceLogService.query(page, userSignInId));
    }

    @RequestMapping(method = RequestMethod.POST, value = "")
    public BaseResponse handleAdd(
            @Valid @RequestBody BalanceLogAddRequest request,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(balanceLogService.add(request, userSignInId));
    }

    @RequestMapping(method = RequestMethod.DELETE, value = "/{id}")
    public BaseResponse handleDelete(@PathVariable("id") Integer id, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(balanceLogService.remove(id, userSignInId));
    }

}
