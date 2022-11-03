package com.jiukuaitech.bookkeeping.user.user;

import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotEmpty;

@Getter
@Setter
public class UserSignInRequest {

    @NotEmpty
    private String userName;
    
    private String password;
    
//    @Max(value = 60*24*60*60)
//    @Min(value = 0)
//    private Integer rememberTime = 60*60; //记住登录状态时间，单位，秒。默认为1小时
    
    private Boolean remember = false; //是否记住30天

}
