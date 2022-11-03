package com.jiukuaitech.bookkeeping.user.scheduled;

import com.jiukuaitech.bookkeeping.user.response.BaseResponse;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.Valid;

@RestController
@RequestMapping("/scheduleds")
public class ScheduledController {

    @Resource
    private ScheduledService scheduledService;

    @RequestMapping(method = RequestMethod.POST, value = "")
    public BaseResponse handleAdd(@Valid @RequestBody ScheduledExpenseAddRequest request, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new BaseResponse(scheduledService.addExpense(request, userSignInId));
    }


}
