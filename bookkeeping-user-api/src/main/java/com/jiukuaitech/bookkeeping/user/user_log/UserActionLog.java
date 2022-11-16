package com.jiukuaitech.bookkeeping.user.user_log;

import com.jiukuaitech.bookkeeping.user.base.BaseEntity;
import com.jiukuaitech.bookkeeping.user.user.User;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name = "t_user_action_log")
@Getter
@Setter
public class UserActionLog extends BaseEntity {

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    private User user;

    private Integer type;

    @Column(nullable = false)
    private Long actionTime;

    public UserActionLog() { }

    public UserActionLog(User user, Integer type, Long actionTime) {
        this.user = user;
        this.type = type;
        this.actionTime = actionTime;
    }
}
