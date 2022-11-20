package com.jiukuaitech.bookkeeping.user.base;

import lombok.Getter;
import lombok.Setter;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Getter
@Setter
public class BaseController {

    @Resource
    private HttpServletRequest request;

    @Resource
    private HttpServletResponse response;

}
