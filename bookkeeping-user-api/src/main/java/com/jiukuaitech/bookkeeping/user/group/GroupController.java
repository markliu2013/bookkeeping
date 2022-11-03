package com.jiukuaitech.bookkeeping.user.group;

import com.jiukuaitech.bookkeeping.user.response.BaseResponse;
import com.jiukuaitech.bookkeeping.user.response.DataResponse;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.Valid;

@RestController
@RequestMapping("/groups")
public class GroupController {

    @Resource
    private GroupService groupService;

    @RequestMapping(method = RequestMethod.GET, value = "")
    public BaseResponse handleQuery(
            @PageableDefault(sort = "id", direction = Sort.Direction.DESC) Pageable page,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(groupService.query(page, userSignInId));
    }

    @RequestMapping(method = RequestMethod.GET, value = "/enable")
    public BaseResponse handleEnable(@RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(groupService.getEnable(userSignInId));
    }

    @RequestMapping(method = RequestMethod.POST, value = "")
    public BaseResponse handleAdd(@Valid @RequestBody GroupAddRequest groupAddRequest, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new BaseResponse(groupService.add(groupAddRequest, userSignInId));
    }

    @RequestMapping(method = RequestMethod.PUT, value = "/{id}")
    public BaseResponse handleUpdate(
            @PathVariable("id") Integer id,
            @Valid @RequestBody GroupUpdateRequest request,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new BaseResponse(groupService.update(id, request, userSignInId));
    }

    @RequestMapping(method = RequestMethod.DELETE, value = "/{id}")
    public BaseResponse handleDelete(@PathVariable("id") Integer id, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new BaseResponse(groupService.remove(id, userSignInId));
    }
}
