package com.jiukuaitech.bookkeeping.user.balance_flow;

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
public class BalanceFlowExceptionHandler {

    private static final Locale LANG = Locale.CHINA;

    @Resource
    private MessageSource messageSource;

    @ExceptionHandler(value = AccountInvalidateException.class)
    @ResponseBody
    public BaseResponse handleException(AccountInvalidateException e) {
        return new ErrorResponse(702, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

    @ExceptionHandler(value = StatusNotValidateException.class)
    @ResponseBody
    public BaseResponse handleException(StatusNotValidateException e) {
        return new ErrorResponse(703, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

    @ExceptionHandler(value = AmountInvalidateException.class)
    @ResponseBody
    public BaseResponse handleException(AmountInvalidateException e) {
        return new ErrorResponse(704, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

}
