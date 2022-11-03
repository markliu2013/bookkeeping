package com.jiukuaitech.bookkeeping.user.item;

import com.jiukuaitech.bookkeeping.user.response.BaseResponse;
import com.jiukuaitech.bookkeeping.user.response.DataResponse;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import javax.validation.Valid;

@RestController
@RequestMapping("/items")
public class ItemController {

    @Resource
    private ItemService itemService;

    @RequestMapping(method = RequestMethod.POST, value = "")
    public BaseResponse handleAdd(
            @Valid @RequestBody ItemAddRequest request,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new BaseResponse(itemService.add(request, userSignInId));
    }

    @RequestMapping(method = RequestMethod.PUT, value = "/{id}/run")
    public BaseResponse handleRun(@PathVariable("id") Integer id, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new BaseResponse(itemService.run(id, userSignInId));
    }

    @RequestMapping(method = RequestMethod.PUT, value = "/{id}/recall")
    public BaseResponse handleRecall(@PathVariable("id") Integer id, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new BaseResponse(itemService.recall(id, userSignInId));
    }

    @RequestMapping(method = RequestMethod.GET, value = "")
    public BaseResponse handleQuery(
            @Valid ItemQueryRequest request,
            @PageableDefault(sort = "id", direction = Sort.Direction.DESC) Pageable page,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(itemService.query(request, page, userSignInId));
    }

    @RequestMapping(method = RequestMethod.DELETE, value = "/{id}")
    public BaseResponse handleDelete(@PathVariable("id") Integer id, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(itemService.remove(id, userSignInId));
    }

    @RequestMapping(method = RequestMethod.PUT, value = "/{id}")
    public BaseResponse handleUpdate(
            @PathVariable("id") Integer id,
            @Valid @RequestBody ItemUpdateRequest request,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new BaseResponse(itemService.update(id, request, userSignInId));
    }

}
