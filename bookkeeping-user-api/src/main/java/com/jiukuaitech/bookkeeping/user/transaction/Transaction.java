package com.jiukuaitech.bookkeeping.user.transaction;

import com.jiukuaitech.bookkeeping.user.balance_flow.BalanceFlow;
import com.jiukuaitech.bookkeeping.user.tag_relation.TagRelation;
import lombok.Getter;
import lombok.Setter;
import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Getter
@Setter
public abstract class Transaction extends BalanceFlow {

    @OneToMany(mappedBy = "transaction", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private Set<TagRelation> tags = new HashSet<>();

}
