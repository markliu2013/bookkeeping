package com.jiukuaitech.bookkeeping.user.response;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ErrorResponse extends BaseResponse {

    private Integer errorCode;
    private String errorMsg;


    public ErrorResponse() {
        super(false);
    }

    public ErrorResponse(Integer errorCode) {
        super(false);
        this.errorCode = errorCode;
    }

    public ErrorResponse(Integer errorCode, String errorMsg) {
        super(false);
        this.errorCode = errorCode;
        this.errorMsg = errorMsg;
    }

}
