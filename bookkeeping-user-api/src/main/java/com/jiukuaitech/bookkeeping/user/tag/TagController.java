package com.jiukuaitech.bookkeeping.user.tag;

import com.jiukuaitech.bookkeeping.user.base.BaseController;
import com.jiukuaitech.bookkeeping.user.response.BaseResponse;
import com.jiukuaitech.bookkeeping.user.response.DataResponse;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.Valid;

@RestController
@RequestMapping("/tags")
public class TagController extends BaseController {

    @Resource
    private TagService tagService;

    @RequestMapping(method = RequestMethod.GET, value = "")
    public BaseResponse handleQuery(
            @Valid TagQueryRequest request,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(tagService.getAllTree(request, userSignInId));
    }

    @RequestMapping(method = RequestMethod.GET, value = "/{id}")
    public BaseResponse handleGet(@PathVariable("id") Integer id, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(tagService.get(id, userSignInId));
    }

    @RequestMapping(method = RequestMethod.GET, value = "/enable")
    public BaseResponse handleEnable(@RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(tagService.getAllEnable(userSignInId));
    }

    @RequestMapping(method = RequestMethod.GET, value = "/expenseable")
    public BaseResponse handleExpenseable(@RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(tagService.getExpenseable(userSignInId));
    }

    @RequestMapping(method = RequestMethod.GET, value = "/incomeable")
    public BaseResponse handleIncomeable(@RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(tagService.getIncomeable(userSignInId));
    }

    @RequestMapping(method = RequestMethod.GET, value = "/transferable")
    public BaseResponse handleTransferable(@RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(tagService.getTransferable(userSignInId));
    }

    @RequestMapping(method = RequestMethod.POST, value = "")
    public BaseResponse handleAdd(
            @Valid @RequestBody TagAddRequest request,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(tagService.add(request, userSignInId));
    }

    @RequestMapping(method = RequestMethod.PUT, value = "/{id}/toggle")
    public BaseResponse handleToggle(@PathVariable("id") Integer id, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new BaseResponse(tagService.toggle(id, userSignInId));
    }

    @RequestMapping(method = RequestMethod.PUT, value = "/{id}")
    public BaseResponse handleUpdate(
            @PathVariable("id") Integer id,
            @Valid @RequestBody TagUpdateRequest request,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(tagService.update(id, request, userSignInId));
    }

    @RequestMapping(method = RequestMethod.DELETE, value = "/{id}")
    public BaseResponse handleDelete(@PathVariable("id") Integer id, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(tagService.remove(id, userSignInId));
    }

}
