package com.jiukuaitech.bookkeeping.user.user;

import com.jiukuaitech.bookkeeping.user.validation.PasswordValidator;
import com.jiukuaitech.bookkeeping.user.validation.UserNameValidator;
import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.Email;

@Getter
@Setter
public class UserRegisterRequest {
    
    @UserNameValidator
    private String userName;
    
    @PasswordValidator
    private String password;

    private String inviteCode;

    @Email
    private String email;

}
