package com.jiukuaitech.bookkeeping.user.user;

import com.jiukuaitech.bookkeeping.user.book.BookVOForList;
import com.jiukuaitech.bookkeeping.user.group.GroupVOForList;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SessionVO {

    private UserSessionVO userSessionVO;
    private BookVOForList defaultBook;
    private GroupVOForList defaultGroup;

}
