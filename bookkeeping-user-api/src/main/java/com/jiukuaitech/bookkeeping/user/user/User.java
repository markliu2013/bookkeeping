package com.jiukuaitech.bookkeeping.user.user;

import com.jiukuaitech.bookkeeping.user.base.BaseEntity;
import com.jiukuaitech.bookkeeping.user.book.Book;
import com.jiukuaitech.bookkeeping.user.group.Group;
import com.jiukuaitech.bookkeeping.user.validation.*;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "t_user")
@Getter
@Setter
public class User extends BaseEntity {
    
    @Column(length = 16, unique = true, nullable = false)
    @NotNull
    @UserNameValidator
    private String userName;
    
    @Column(length = 16)
    @NameValidator
    private String nickName;
    
    @Column(length = 32, nullable = false)
    @NotNull
    @PasswordValidator
    private String password;

    @Column(length = 16)
    @NameValidator
    private String telephone;
    
    @Column(length = 32)
    @Email
    private String email;
    
    @Column(length = 32, nullable = true)
    private String ip;
    
    @Column(length = 64)
    @AvatarValidator
    private String avatar;
    
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    private Group defaultGroup; //用户默认操作的组
    
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    private Book defaultBook; //用户默认操作的账本

    @Column(nullable = false)
    @NotNull
    @TimeValidator
    private Long vipTime; //会员到期日

    // 上次登录ip，时间，哪个国家 设备等信息 TODO

    @Column(nullable = false)
    @NotNull
    private Boolean enable = true;

    @Column(nullable = false)
    @NotNull
    @TimeValidator
    private Long registerTime; //注册时间
    
    public User() { }

    public User(Integer id) {
        super.setId(id);
    }

    public User(String userName, String password) {
        this.userName = userName;
        this.password = password;
    }
}
