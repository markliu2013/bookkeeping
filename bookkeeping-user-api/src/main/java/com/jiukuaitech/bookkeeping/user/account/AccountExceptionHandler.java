package com.jiukuaitech.bookkeeping.user.account;

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
public class AccountExceptionHandler {

    private static final Locale LANG = Locale.CHINA;

    @Resource
    private MessageSource messageSource;

    @ExceptionHandler(value = AccountNameExistsException.class)
//    @ResponseStatus(HttpStatus.CONFLICT)
    @ResponseBody
    public BaseResponse handleException(AccountNameExistsException e) {
        return new ErrorResponse(409, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

    @ExceptionHandler(value = AccountMaxCountException.class)
    @ResponseBody
    public BaseResponse handleException(AccountMaxCountException e) {
        return new ErrorResponse(501, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

    @ExceptionHandler(value = AccountHasTransactionException.class)
    @ResponseBody
    public BaseResponse handleException(AccountHasTransactionException e) {
        return new ErrorResponse(601, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

    @ExceptionHandler(value = AccountAdjustBalanceNotValidException.class)
    @ResponseBody
    public BaseResponse handleException(AccountAdjustBalanceNotValidException e) {
        return new ErrorResponse(602, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

    @ExceptionHandler(value = DefaultExpenseAccountException.class)
    @ResponseBody
    public BaseResponse handleException(DefaultExpenseAccountException e) {
        return new ErrorResponse(603, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

    @ExceptionHandler(value = DefaultIncomeAccountException.class)
    @ResponseBody
    public BaseResponse handleException(DefaultIncomeAccountException e) {
        return new ErrorResponse(604, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

    @ExceptionHandler(value = DefaultTransferFromAccountException.class)
    @ResponseBody
    public BaseResponse handleException(DefaultTransferFromAccountException e) {
        return new ErrorResponse(605, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

    @ExceptionHandler(value = DefaultTransferToAccountException.class)
    @ResponseBody
    public BaseResponse handleException(DefaultTransferToAccountException e) {
        return new ErrorResponse(606, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

}
