package com.jiukuaitech.bookkeeping.user.base;

import com.jiukuaitech.bookkeeping.user.response.BaseResponse;
import com.jiukuaitech.bookkeeping.user.response.DataResponse;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import javax.servlet.http.HttpServletRequest;


@RestController
public class TestController {

    @RequestMapping(method = RequestMethod.GET, value = "/test1")
    public BaseResponse handleTest1() {
        return new DataResponse<>(9);
    }

    @GetMapping("/test2")
    public BaseResponse getBaseUrl(HttpServletRequest request) {
        String baseUrl = ServletUriComponentsBuilder
                .fromRequestUri(request)
                .replacePath(null)
                .build()
                .toUriString();
        return new DataResponse<>(baseUrl);
    }

}
