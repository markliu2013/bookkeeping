package com.jiukuaitech.bookkeeping.user.payee;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PayeeQueryRequest {

    private String name;
    private Boolean enable;
    private Boolean expenseable;
    private Boolean incomeable;

}
