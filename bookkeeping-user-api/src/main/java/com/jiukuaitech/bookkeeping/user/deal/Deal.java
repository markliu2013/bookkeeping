package com.jiukuaitech.bookkeeping.user.deal;

import com.jiukuaitech.bookkeeping.user.payee.Payee;
import com.jiukuaitech.bookkeeping.user.category_relation.CategoryRelation;
import com.jiukuaitech.bookkeeping.user.transaction.Transaction;
import lombok.Getter;
import lombok.Setter;
import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Getter
@Setter
public class Deal extends Transaction {

    @ManyToOne(fetch = FetchType.LAZY)
    private Payee payee;

    @OneToMany(mappedBy = "deal", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
//    @NotEmpty
    private Set<CategoryRelation> categories = new HashSet<>();

}
