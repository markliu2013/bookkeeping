package com.jiukuaitech.bookkeeping.user.group;

import com.jiukuaitech.bookkeeping.user.book.Book;
import com.jiukuaitech.bookkeeping.user.user.User;
import com.jiukuaitech.bookkeeping.user.user.UserGroupRelation;
import com.jiukuaitech.bookkeeping.user.base.NameNotesEnableEntity;
import com.jiukuaitech.bookkeeping.user.validation.AvatarValidator;
import lombok.Getter;
import lombok.Setter;
import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "t_group")
@Getter
@Setter
/**
 * 多个人一个组一起记账。
 * 组名name，可以重复。
 */
public class Group extends NameNotesEnableEntity {

    @ManyToOne(optional = true, fetch = FetchType.LAZY)
    private User creator;

    @Column(length = 128)
    @AvatarValidator
    private String avatar;

    @OneToMany(mappedBy = "group", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private Set<UserGroupRelation> relations = new HashSet<>();

    @ManyToOne(fetch = FetchType.LAZY)
    private Book defaultBook; //组默认操作的账本

    @Column(nullable = false, length = 8)
    @NotNull
    private String defaultCurrencyCode;//默认的币种

    public Group() { }

    public Group(Integer id) {
        super.setId(id);
    }

}
