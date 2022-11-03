package com.jiukuaitech.bookkeeping.user.balance_flow;

import com.jiukuaitech.bookkeeping.user.response.BaseResponse;
import com.jiukuaitech.bookkeeping.user.response.DataResponse;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import javax.validation.Valid;
import java.util.Set;

@RestController
@RequestMapping("/flows")
public class BalanceFlowController {

    @Resource
    private BalanceFlowService balanceFlowService;

    @RequestMapping(method = RequestMethod.GET, value = "")
    public BaseResponse handleQuery(
            @Valid BalanceFlowQueryRequest request,
            @PageableDefault(sort = {"createTime", "id"}, direction = Sort.Direction.DESC) Pageable page,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(balanceFlowService.queryWithDefaultBook(request, page, userSignInId));
    }

    @RequestMapping(method = RequestMethod.GET, value = "audit")
    public BaseResponse handleAudit(
            @Valid BalanceFlowQueryRequest request,
            @PageableDefault(sort = {"createTime", "id"}, direction = Sort.Direction.DESC) Pageable page,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(balanceFlowService.query(request, page, userSignInId));
    }

    @RequestMapping(method = RequestMethod.GET, value = "/{id}")
    public BaseResponse handleGet(@PathVariable("id") Integer id, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(balanceFlowService.get(id, userSignInId));
    }

    @RequestMapping(method = RequestMethod.DELETE, value = "/{id}")
    public BaseResponse handleDelete(
            @PathVariable("id") Integer id,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(balanceFlowService.remove(id, userSignInId));
    }

    @RequestMapping(method = RequestMethod.PUT, value = "/{id}/confirm")
    public BaseResponse handleConfirm(
            @PathVariable("id") Integer id,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(balanceFlowService.confirm(id, userSignInId));
    }

    @RequestMapping(method = RequestMethod.GET, value = "/{id}/images")
    public BaseResponse handleImages(@PathVariable("id") Integer id, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(balanceFlowService.getImages(id, userSignInId));
    }

    @RequestMapping(method = RequestMethod.POST, value = "/{id}/images")
    public BaseResponse handleUpdateImages(
            @PathVariable("id") Integer id,
            @Valid @RequestBody Set<Integer> images,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(balanceFlowService.updateImages(id, images, userSignInId));
    }

    @RequestMapping(method = RequestMethod.POST, value = "/{id}/image")
    public BaseResponse handleAddImage(
            @PathVariable("id") Integer id,
            @Valid @RequestBody Integer imageId,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(balanceFlowService.addImage(id, imageId, userSignInId));
    }

}