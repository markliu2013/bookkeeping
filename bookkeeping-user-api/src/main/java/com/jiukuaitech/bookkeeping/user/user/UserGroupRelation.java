package com.jiukuaitech.bookkeeping.user.user;

import com.jiukuaitech.bookkeeping.user.base.BaseEntity;
import com.jiukuaitech.bookkeeping.user.group.Group;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Entity
@Table(name="t_user_group_relation", uniqueConstraints = {@UniqueConstraint(columnNames = {"user_id", "group_id"})})
@Getter
@Setter
public class UserGroupRelation extends BaseEntity {

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    @NotNull
    private User user;
    
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "group_id")
    @NotNull
    private Group group;

    @Column(nullable = false)
    @NotNull
    private Integer role;//1 所有者 2维护者 3访客
    
    public UserGroupRelation() { }
    
    public UserGroupRelation(User user, Group group, Integer role) {
        this.user = user;
        this.group = group;
        this.role = role;
    }

}
