package com.jiukuaitech.bookkeeping.user.setting;

import com.jiukuaitech.bookkeeping.user.user.User;
import com.jiukuaitech.bookkeeping.user.base.BaseEntity;
import com.jiukuaitech.bookkeeping.user.validation.NameValidator;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "t_setting", uniqueConstraints = {@UniqueConstraint(columnNames = {"user_id", "c_key"})})
@Getter
@Setter
public class Setting extends BaseEntity {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @Column(name= "c_key", length = 16, nullable = false, unique = true)
    @NotNull
    @NameValidator
    private String key;
    
    @Column(length = 16, nullable = false)
    @NotNull
    @NameValidator
    private String value;
    
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    @NotNull
    private User user;

}
