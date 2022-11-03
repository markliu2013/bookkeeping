package com.jiukuaitech.bookkeeping.user.income_category;

import com.jiukuaitech.bookkeeping.user.category.CategoryAddRequest;
import com.jiukuaitech.bookkeeping.user.category.CategoryService;
import com.jiukuaitech.bookkeeping.user.category.CategoryUpdateRequest;
import com.jiukuaitech.bookkeeping.user.base.BaseController;
import com.jiukuaitech.bookkeeping.user.category.CategoryQueryRequest;
import com.jiukuaitech.bookkeeping.user.response.BaseResponse;
import com.jiukuaitech.bookkeeping.user.response.DataResponse;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import javax.validation.Valid;

@RestController
@RequestMapping("/income-categories")
public class IncomeCategoryController extends BaseController {

    @Resource
    private CategoryService categoryService;

    @RequestMapping(method = RequestMethod.POST, value = "")
    public BaseResponse handleAdd(
            @Valid @RequestBody CategoryAddRequest request,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new BaseResponse(categoryService.add(2, request, userSignInId));
    }

    @RequestMapping(method = RequestMethod.GET, value = "/enable")
    public BaseResponse handleGetAllEnable(@RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(categoryService.getAllEnable(2, userSignInId));
    }

    @RequestMapping(method = RequestMethod.GET, value = "")
    public BaseResponse handleQuery(@Valid CategoryQueryRequest request, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(categoryService.getAllTree(request, 2, userSignInId));
    }

    // 接口没用上
    @RequestMapping(method = RequestMethod.GET, value = "/simple")
    public BaseResponse handleQuerySimple(
            @PageableDefault(sort = "id", direction = Sort.Direction.DESC) Pageable page,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(categoryService.query(2, page, userSignInId));
    }

    @RequestMapping(method = RequestMethod.PUT, value = "/{id}")
    public BaseResponse handleUpdate(
            @PathVariable("id") Integer id,
            @Valid @RequestBody CategoryUpdateRequest request,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new BaseResponse(categoryService.update(2, id, request, userSignInId));
    }

}
