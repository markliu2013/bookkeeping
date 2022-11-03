package com.jiukuaitech.bookkeeping.user.deal;

import com.jiukuaitech.bookkeeping.user.base.BaseController;
import com.jiukuaitech.bookkeeping.user.refund.RefundService;
import com.jiukuaitech.bookkeeping.user.response.BaseResponse;
import com.jiukuaitech.bookkeeping.user.response.DataResponse;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;

@RestController
@RequestMapping("/deals")
public class DealController extends BaseController {

    @Resource
    private RefundService refundService;

    @RequestMapping(method = RequestMethod.GET, value = "/{id}/refunds")
    public BaseResponse handleRefunds(@PathVariable("id") Integer id, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(refundService.getRefunds(id, userSignInId));
    }

}
