package com.jiukuaitech.bookkeeping.user.user;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserSignInResponse {

    private String token;
    private SessionVO sessionVO;
    private Boolean remember;

}
