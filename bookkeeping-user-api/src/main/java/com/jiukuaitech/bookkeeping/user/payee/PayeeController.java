package com.jiukuaitech.bookkeeping.user.payee;

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
@RequestMapping("/payees")
public class PayeeController extends BaseController {

    @Resource
    private PayeeService payeeService;

    @RequestMapping(method = RequestMethod.GET, value = "")
    public BaseResponse handleQuery(
            @PageableDefault(sort = "id", direction = Sort.Direction.DESC) Pageable page,
            @Valid PayeeQueryRequest request,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(payeeService.query(request, page, userSignInId));
    }

    @RequestMapping(method = RequestMethod.GET, value = "/{id}")
    public BaseResponse handleGet(@PathVariable("id") Integer id, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(payeeService.get(id, userSignInId));
    }

    @RequestMapping(method = RequestMethod.GET, value = "/enable")
    public BaseResponse handleEnable(@RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(payeeService.getEnable(userSignInId));
    }

    @RequestMapping(method = RequestMethod.GET, value = "/expenseable")
    public BaseResponse handleExpenseable(@RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(payeeService.getExpenseable(userSignInId));
    }

    @RequestMapping(method = RequestMethod.GET, value = "/incomeable")
    public BaseResponse handleIncomeable(@RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(payeeService.getIncomeable(userSignInId));
    }

    @RequestMapping(method = RequestMethod.POST, value = "")
    public BaseResponse handleAdd(
            @Valid @RequestBody PayeeAddRequest request,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(payeeService.add(request, userSignInId));
    }

    @RequestMapping(method = RequestMethod.PUT, value = "/{id}/toggle")
    public BaseResponse handleToggle(@PathVariable("id") Integer id, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(payeeService.toggle(id, userSignInId));
    }

    @RequestMapping(method = RequestMethod.PUT, value = "/{id}")
    public BaseResponse handleUpdate(
            @PathVariable("id") Integer id,
            @Valid @RequestBody PayeeUpdateRequest request,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(payeeService.update(id, request, userSignInId));
    }

    @RequestMapping(method = RequestMethod.DELETE, value = "/{id}")
    public BaseResponse handleDelete(@PathVariable("id") Integer id, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(payeeService.remove(id, userSignInId));
    }

}
