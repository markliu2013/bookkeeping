package com.jiukuaitech.bookkeeping.user.response;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BaseResponse {

    private boolean success;

    public BaseResponse(boolean success) {
        this.success = success;
    }

}
