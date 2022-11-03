package com.jiukuaitech.bookkeeping.user.category;

import com.jiukuaitech.bookkeeping.user.response.BaseResponse;
import com.jiukuaitech.bookkeeping.user.response.ErrorResponse;
import org.springframework.context.MessageSource;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import javax.annotation.Resource;
import java.util.Locale;

@RestControllerAdvice
@Order(Ordered.HIGHEST_PRECEDENCE)
public class CategoryExceptionHandler {

    private static final Locale LANG = Locale.CHINA;

    @Resource
    private MessageSource messageSource;

    @ExceptionHandler(value = ParentCategoryNotEnableException.class)
    @ResponseBody
    public BaseResponse handleException(ParentCategoryNotEnableException e) {
        return new ErrorResponse(607, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

    @ExceptionHandler(value = CategoryNameExistsException.class)
    @ResponseStatus(HttpStatus.CONFLICT)
    public BaseResponse handleException(CategoryNameExistsException e) {
        return new ErrorResponse(409, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

    @ExceptionHandler(value = CategoryHasDealException.class)
    @ResponseBody
    public BaseResponse handleException(CategoryHasDealException e) {
        return new ErrorResponse(410, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

    @ExceptionHandler(value = CategoryLevelException.class)
    @ResponseBody
    public BaseResponse handleException(CategoryLevelException e) {
        return new ErrorResponse(703, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

    @ExceptionHandler(value = CategoryIsDefaultExpenseException.class)
    @ResponseBody
    public BaseResponse handleException(CategoryIsDefaultExpenseException e) {
        return new ErrorResponse(704, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

    @ExceptionHandler(value = CategoryIsDefaultIncomeException.class)
    @ResponseBody
    public BaseResponse handleException(CategoryIsDefaultIncomeException e) {
        return new ErrorResponse(705, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

}
