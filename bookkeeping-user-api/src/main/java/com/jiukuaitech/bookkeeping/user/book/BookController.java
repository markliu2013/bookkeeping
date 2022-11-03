package com.jiukuaitech.bookkeeping.user.book;

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
@RequestMapping("/books")
public class BookController extends BaseController {

    @Resource
    private BookService bookService;

    /*
    @RequestMapping(method = RequestMethod.GET, value = "")
    public BaseResponse handleGetAll(@RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(bookService.getAll(userSignInId));
    }
    */

    @RequestMapping(method = RequestMethod.GET, value = "")
    public BaseResponse handleQuery(
            @PageableDefault(sort = "id", direction = Sort.Direction.DESC) Pageable page,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(bookService.query(page, userSignInId));
    }

    @RequestMapping(method = RequestMethod.GET, value = "/{id}")
    public BaseResponse handleGet(@PathVariable("id") Integer id, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(bookService.get(id, userSignInId));
    }

    @RequestMapping(method = RequestMethod.POST, value = "")
    public BaseResponse handleAdd(@Valid @RequestBody BookAddRequest request, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new BaseResponse(bookService.add(request, userSignInId));
    }

    @RequestMapping(method = RequestMethod.PUT, value = "/{id}")
    public BaseResponse handleUpdate(
            @PathVariable("id") Integer id,
            @Valid @RequestBody BookUpdateRequest request,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(bookService.update(id, request, userSignInId));
    }

    @RequestMapping(method = RequestMethod.PUT, value = "/config")
    public BaseResponse handleConfig(
            @Valid @RequestBody BookUpdateRequest request,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(bookService.config(request, userSignInId));
    }

    @RequestMapping(method = RequestMethod.DELETE, value = "/{id}")
    public BaseResponse handleDelete(@PathVariable("id") Integer id, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new BaseResponse(bookService.remove(id, userSignInId));
    }

    @RequestMapping(method = RequestMethod.PUT, value = "/{id}/toggle")
    public BaseResponse handleToggle(@PathVariable("id") Integer id, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(bookService.toggle(id, userSignInId));
    }

}
