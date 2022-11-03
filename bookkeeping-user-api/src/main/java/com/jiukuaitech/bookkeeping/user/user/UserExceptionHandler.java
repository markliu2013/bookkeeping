package com.jiukuaitech.bookkeeping.user.user;

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
public class UserExceptionHandler {

    private static final Locale LANG = Locale.CHINA;

    @Resource
    private MessageSource messageSource;

    @ExceptionHandler(value = RegisterNameExistsException.class)
    @ResponseBody
    public BaseResponse handleException(RegisterNameExistsException e) {
        return new ErrorResponse(701, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

    @ExceptionHandler(value = InviteCodeErrorException.class)
    @ResponseBody
    public BaseResponse handleException(InviteCodeErrorException e) {
        return new ErrorResponse(702, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

    @ExceptionHandler(value = SigninFailedException.class)
    @ResponseBody
    public BaseResponse handleException(SigninFailedException e) {
        return new ErrorResponse(703, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

    @ExceptionHandler(value = UploadNotImageException.class)
    @ResponseBody
    public BaseResponse handleException(UploadNotImageException e) {
        return new ErrorResponse(704, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

    @ExceptionHandler(value = SessionUserNotFoundException.class)
    @ResponseBody
    public BaseResponse handleException(SessionUserNotFoundException e) {
        return new ErrorResponse(705, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

    @ExceptionHandler(value = OldPasswordErrorException.class)
    @ResponseBody
    public BaseResponse handleException(OldPasswordErrorException e) {
        return new ErrorResponse(706, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

    @ExceptionHandler(value = UserDisabledException.class)
    @ResponseBody
    public BaseResponse handleException(UserDisabledException e) {
        return new ErrorResponse(706, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

}
