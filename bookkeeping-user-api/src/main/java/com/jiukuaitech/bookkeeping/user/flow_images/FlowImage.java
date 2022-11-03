package com.jiukuaitech.bookkeeping.user.flow_images;

import com.jiukuaitech.bookkeeping.user.balance_flow.BalanceFlow;
import com.jiukuaitech.bookkeeping.user.user.User;
import com.jiukuaitech.bookkeeping.user.base.BaseEntity;
import com.jiukuaitech.bookkeeping.user.validation.TimeValidator;
import lombok.Getter;
import lombok.Setter;
import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Entity
@Table(name="t_flow_image")
@Getter
@Setter
public class FlowImage extends BaseEntity {

    @Column(length = 256)
    private String host;

    @Column(length = 128)
    private String uri;

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    @NotNull
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "flow_id")
    private BalanceFlow flow;

    @Column(nullable = false)
    @NotNull
    @TimeValidator
    private Long createTime;

}
