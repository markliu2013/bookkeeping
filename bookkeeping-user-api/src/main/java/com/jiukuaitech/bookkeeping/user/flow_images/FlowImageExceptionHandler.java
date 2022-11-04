package com.jiukuaitech.bookkeeping.user.flow_images;
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
public class FlowImageExceptionHandler {

    private static final Locale LANG = Locale.CHINA;

    @Resource
    private MessageSource messageSource;

    @ExceptionHandler(value = ImageExistsException.class)
    @ResponseBody
    public BaseResponse handleException(ImageExistsException e) {
        return new ErrorResponse(702, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

    @ExceptionHandler(value = UploadKeyEmptyException.class)
    @ResponseBody
    public BaseResponse handleException(UploadKeyEmptyException e) {
        return new ErrorResponse(703, messageSource.getMessage(e.getClass().getSimpleName(), null, LANG));
    }

}
