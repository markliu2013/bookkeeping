package com.jiukuaitech.bookkeeping.user.exception;

import com.jiukuaitech.bookkeeping.user.response.BaseResponse;
import com.jiukuaitech.bookkeeping.user.response.ErrorResponse;

import org.springframework.context.MessageSource;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.validation.BindException;
import org.springframework.web.HttpMediaTypeNotSupportedException;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.servlet.NoHandlerFoundException;

import javax.annotation.Resource;
import javax.validation.ConstraintViolationException;
import java.util.Locale;

@RestControllerAdvice
public class GlobalExceptionHandler {

    @Resource
    private MessageSource messageSource;

    private static final Locale LANG = Locale.CHINA;


    @ExceptionHandler(value = Exception.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public BaseResponse defaultExceptionHandler(Exception e) {
        // TODO 日志记录
        System.out.println("------------------------------------------");
        e.printStackTrace();
        return new ErrorResponse(0, messageSource.getMessage("DefaultException", null, LANG));
    }

    // 请求头的Content-Type不正确
    @ExceptionHandler(value = HttpMediaTypeNotSupportedException.class)
    @ResponseStatus(HttpStatus.UNSUPPORTED_MEDIA_TYPE)
    public BaseResponse exceptionHandler1(Exception e) {
        return new ErrorResponse(1, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

    // 404
    @ExceptionHandler(value = NoHandlerFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public BaseResponse exceptionHandler2(Exception e) {
        return new ErrorResponse(404, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

    // 更新的数据违反了数据库约束
    @ExceptionHandler(value = {DataIntegrityViolationException.class, ConstraintViolationException.class})
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public BaseResponse exceptionHandler3(Exception e) {
        e.printStackTrace();
        return new ErrorResponse(3, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

    // 前端传递的参数不合法。
    @ExceptionHandler({
            MethodArgumentNotValidException.class,
            BindException.class,
            InputNotValidException.class,
            HttpMessageNotReadableException.class
    })
    @ResponseBody
    public BaseResponse exceptionHandler6(Exception e) {
        e.printStackTrace();
        return new ErrorResponse(6, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

    //
    @ExceptionHandler(value = HttpRequestMethodNotSupportedException.class)
    @ResponseStatus(HttpStatus.METHOD_NOT_ALLOWED)
    public BaseResponse exceptionHandler7(Exception e) {
        return new ErrorResponse(7, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

    @ExceptionHandler(value = TokenEmptyException.class)
    @ResponseBody
    public BaseResponse exceptionHandler8(Exception e) {
        return new ErrorResponse(8, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

    @ExceptionHandler(value = TokenNotValidException.class)
    @ResponseBody
    public BaseResponse exceptionHandler10(Exception e) {
        return new ErrorResponse(10, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

    @ExceptionHandler(value = PermissionException.class)
    @ResponseStatus(HttpStatus.FORBIDDEN)
    public BaseResponse exceptionHandler9(Exception e) {
        return new ErrorResponse(9, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

    @ExceptionHandler(value = ItemNotFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public BaseResponse handleException(ItemNotFoundException e) {
        return new ErrorResponse(404, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

    @ExceptionHandler(value = NameExistsException.class)
    @ResponseStatus(HttpStatus.CONFLICT)
    public BaseResponse handleException(NameExistsException e) {
        return new ErrorResponse(408, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

}

