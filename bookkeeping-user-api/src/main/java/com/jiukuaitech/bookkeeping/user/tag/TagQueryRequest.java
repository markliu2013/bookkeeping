package com.jiukuaitech.bookkeeping.user.tag;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TagQueryRequest {

    private String name;
    private Boolean enable;
    private Boolean expenseable;
    private Boolean incomeable;
    private Boolean transferable;

}
