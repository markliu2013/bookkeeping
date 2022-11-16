package com.jiukuaitech.bookkeeping.user.user_log;

import com.jiukuaitech.bookkeeping.user.response.BaseResponse;
import com.jiukuaitech.bookkeeping.user.response.ErrorResponse;
import org.springframework.context.MessageSource;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import javax.annotation.Resource;
import java.util.Locale;

@RestControllerAdvice
@Order(Ordered.HIGHEST_PRECEDENCE)
public class UserActionExceptionHandler {

    private static final Locale LANG = Locale.CHINA;

    @Resource
    private MessageSource messageSource;

    @ExceptionHandler(value = FlowMaxCountException.class)
    @ResponseBody
    public BaseResponse handleException(FlowMaxCountException e) {
        return new ErrorResponse(601, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

}
