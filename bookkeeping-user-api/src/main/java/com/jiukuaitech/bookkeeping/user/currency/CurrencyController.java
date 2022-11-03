package com.jiukuaitech.bookkeeping.user.currency;

import com.jiukuaitech.bookkeeping.user.base.BaseController;
import com.jiukuaitech.bookkeeping.user.response.BaseResponse;
import com.jiukuaitech.bookkeeping.user.response.DataResponse;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;

@RestController
@RequestMapping("/currency")
public class CurrencyController extends BaseController {

    @Resource
    private CurrencyService currencyService;

    @RequestMapping(method = RequestMethod.GET, value = "/all")
    public BaseResponse handleAll() {
        return new DataResponse<>(currencyService.getAll());
    }

}