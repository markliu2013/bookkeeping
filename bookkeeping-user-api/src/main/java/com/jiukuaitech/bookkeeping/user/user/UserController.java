package com.jiukuaitech.bookkeeping.user.user;

import com.jiukuaitech.bookkeeping.user.base.BaseController;
import com.jiukuaitech.bookkeeping.user.response.BaseResponse;
import com.jiukuaitech.bookkeeping.user.response.DataResponse;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import javax.validation.Valid;

// 登录，注册，注销等
@RestController
public class UserController extends BaseController {

    @Resource
    private UserService userService;
    
    // 登录
    @RequestMapping(method = RequestMethod.POST, value = "/signin")
    public BaseResponse handleSignin(@Valid @RequestBody UserSignInRequest request) {
        return new DataResponse<>(userService.signin(request));
    }
    
    // 注册
    @RequestMapping(method = RequestMethod.POST, value = "/register")
    public BaseResponse handleRegister(@Valid @RequestBody UserRegisterRequest request) {
        return new BaseResponse(userService.register(request, getRequest()));
    }

    // 修改密码
    @RequestMapping(method = RequestMethod.PUT, value = "/updatePassword")
    public BaseResponse handleUpdatePassword(@RequestAttribute("userSignInId") Integer userSignInId, @Valid @RequestBody UserUpdatePasswordRequest request) {
        return new BaseResponse(userService.updatePassword(userSignInId, request));
    }

    @RequestMapping(method = RequestMethod.GET, value = "/session")
    public BaseResponse handleSession(@RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(userService.getSession(userSignInId));
    }

    @RequestMapping(method = RequestMethod.PUT, value = "/setDefaultBook/{id}")
    public BaseResponse handleSetDefaultBook(
            @PathVariable("id") Integer id,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(userService.setDefaultBook(id, userSignInId));
    }

    @RequestMapping(method = RequestMethod.PUT, value = "/setDefaultGroup/{id}")
    public BaseResponse handleSetDefaultGroup(
            @PathVariable("id") Integer id,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(userService.setDefaultGroup(id, userSignInId));
    }

}
