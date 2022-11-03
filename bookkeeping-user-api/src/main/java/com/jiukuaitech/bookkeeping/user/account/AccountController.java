package com.jiukuaitech.bookkeeping.user.account;

import com.jiukuaitech.bookkeeping.user.adjust_balance.AdjustBalanceAddRequest;
import com.jiukuaitech.bookkeeping.user.base.BaseController;
import com.jiukuaitech.bookkeeping.user.response.BaseResponse;
import com.jiukuaitech.bookkeeping.user.response.DataResponse;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.Valid;

@RestController
@RequestMapping("/accounts")
public class AccountController extends BaseController {

    @Resource
    private AccountService accountService;

    // 搜索流水的下拉框需要显示所有可用的account
    @RequestMapping(method = RequestMethod.GET, value = "/enable")
    public BaseResponse handleEnable(@RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(accountService.getEnable(userSignInId));
    }

    @RequestMapping(method = RequestMethod.GET, value = "/expenseable")
    public BaseResponse handleExpenseble(@RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(accountService.getAllExpenseable(userSignInId));
    }
    
    @RequestMapping(method = RequestMethod.GET, value = "/incomeable")
    public BaseResponse handleIncomeble(@RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(accountService.getAllIncomeable(userSignInId));
    }

    @RequestMapping(method = RequestMethod.GET, value = "/transfer-from-able")
    public BaseResponse handleTransferFromAble(@RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(accountService.getAllTransferFromAble(userSignInId));
    }

    @RequestMapping(method = RequestMethod.GET, value = "/transfer-to-able")
    public BaseResponse handleTransferToAble(@RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(accountService.getAllTransferToAble(userSignInId));
    }

    @RequestMapping(method = RequestMethod.GET, value = "/{id}")
    public BaseResponse handleGet(@PathVariable("id") Integer id, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(accountService.get(id, userSignInId));
    }

    @RequestMapping(method = RequestMethod.POST, value = "/{id}/adjust-balance")
    public BaseResponse handleAdjustBalance(
            @PathVariable("id") Integer id,
            @Valid @RequestBody AdjustBalanceAddRequest request,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(accountService.adjustBalance(id, request, userSignInId));
    }

    @RequestMapping(method = RequestMethod.DELETE, value = "/{id}")
    public BaseResponse handleDelete(@PathVariable("id") Integer id, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(accountService.remove(id, userSignInId));
    }

    @RequestMapping(method = RequestMethod.PUT, value = "/{id}/toggle")
    public BaseResponse handleToggle(@PathVariable("id") Integer id, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(accountService.toggle(id, userSignInId));
    }

    @RequestMapping(method = RequestMethod.PUT, value = "/{id}/toggleInclude")
    public BaseResponse handleToggleInclude(@PathVariable("id") Integer id, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(accountService.toggleInclude(id, userSignInId));
    }

    @RequestMapping(method = RequestMethod.PUT, value = "/{id}/toggleExpenseable")
    public BaseResponse handleToggleExpenseable(@PathVariable("id") Integer id, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(accountService.toggleExpenseable(id, userSignInId));
    }

    @RequestMapping(method = RequestMethod.PUT, value = "/{id}/toggleIncomeable")
    public BaseResponse handleToggleIncomeable(@PathVariable("id") Integer id, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(accountService.toggleIncomeable(id, userSignInId));
    }

    @RequestMapping(method = RequestMethod.PUT, value = "/{id}/toggleTransferFromAble")
    public BaseResponse handleToggleTransferFromAble(@PathVariable("id") Integer id, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(accountService.toggleTransferFromAble(id, userSignInId));
    }

    @RequestMapping(method = RequestMethod.PUT, value = "/{id}/toggleTransferToAble")
    public BaseResponse handleToggleTransferToAble(@PathVariable("id") Integer id, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(accountService.toggleTransferToAble(id, userSignInId));
    }

    @RequestMapping(method = RequestMethod.PUT, value = "/{id}")
    public BaseResponse handleUpdate(
            @PathVariable("id") Integer id,
            @Valid @RequestBody AccountUpdateRequest request,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(accountService.update(id, request, userSignInId));
    }

}