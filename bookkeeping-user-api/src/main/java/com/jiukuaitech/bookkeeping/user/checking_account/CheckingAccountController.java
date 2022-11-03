package com.jiukuaitech.bookkeeping.user.checking_account;

import com.jiukuaitech.bookkeeping.user.account.AccountQueryRequest;
import com.jiukuaitech.bookkeeping.user.account.AccountService;
import com.jiukuaitech.bookkeeping.user.base.BaseController;
import com.jiukuaitech.bookkeeping.user.response.BaseResponse;
import com.jiukuaitech.bookkeeping.user.response.DataResponse;
import com.jiukuaitech.bookkeeping.user.account.AccountAddRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.Valid;

@RestController
@RequestMapping("/checking-accounts")
public class CheckingAccountController extends BaseController {

    @Resource
    private CheckingAccountService checkingAccountService;

    @Resource
    private AccountService accountService;

    @RequestMapping(method = RequestMethod.GET, value = "")
    public BaseResponse handleQuery(
            @Valid AccountQueryRequest request,
            @PageableDefault(sort = "balance", direction = Sort.Direction.DESC) Pageable page,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(checkingAccountService.query(request, page, userSignInId));
    }

    @RequestMapping(method = RequestMethod.POST, value = "")
    public BaseResponse handleAdd(
            @Valid @RequestBody AccountAddRequest request,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(accountService.add(1, request, userSignInId));
    }

    @RequestMapping(method = RequestMethod.GET, value = "/sum")
    public BaseResponse handleSum(@RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(checkingAccountService.sum(userSignInId));
    }

}
