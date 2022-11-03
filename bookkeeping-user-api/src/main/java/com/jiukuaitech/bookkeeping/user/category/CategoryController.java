package com.jiukuaitech.bookkeeping.user.category;

import com.jiukuaitech.bookkeeping.user.base.BaseController;
import com.jiukuaitech.bookkeeping.user.response.BaseResponse;
import com.jiukuaitech.bookkeeping.user.response.DataResponse;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
@RequestMapping("/categories")
public class CategoryController extends BaseController {

    @Resource
    private CategoryService categoryService;

    @RequestMapping(method = RequestMethod.DELETE, value = "/{id}")
    public BaseResponse handleDelete(@PathVariable("id") Integer id, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new BaseResponse(categoryService.remove(id, userSignInId));
    }

    @RequestMapping(method = RequestMethod.PUT, value = "/{id}/toggle")
    public BaseResponse handleToggle(@PathVariable("id") Integer id, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new BaseResponse(categoryService.toggle(id, userSignInId));
    }

    @RequestMapping(method = RequestMethod.GET, value = "/{id}")
    public BaseResponse handleGet(@PathVariable("id") Integer id, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(categoryService.get(id, userSignInId));
    }

}
