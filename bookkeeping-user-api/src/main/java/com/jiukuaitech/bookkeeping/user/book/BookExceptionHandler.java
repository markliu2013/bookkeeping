package com.jiukuaitech.bookkeeping.user.book;

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
public class BookExceptionHandler {

    private static final Locale LANG = Locale.CHINA;

    @Resource
    private MessageSource messageSource;

    @ExceptionHandler(value = BookMaxCountException.class)
    @ResponseBody
    public BaseResponse handleException(BookMaxCountException e) {
        return new ErrorResponse(602, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

}
