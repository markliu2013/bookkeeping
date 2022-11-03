package com.jiukuaitech.bookkeeping.user.user;

import com.jiukuaitech.bookkeeping.user.validation.PasswordValidator;
import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
public class UserUpdatePasswordRequest {
    
    @PasswordValidator
    private String oldPassword;

    @PasswordValidator
    private String newPassword;

}
