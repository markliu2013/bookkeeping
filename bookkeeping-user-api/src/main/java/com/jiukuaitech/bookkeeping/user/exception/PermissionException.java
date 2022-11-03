package com.jiukuaitech.bookkeeping.user.exception;


public class PermissionException extends RuntimeException {

    private static final long serialVersionUID = -3240641871841704086L;

    public PermissionException() {}

    public PermissionException(String msg) {
        super(msg);
    }

}
