package com.jiukuaitech.bookkeeping.user.expense;

import com.jiukuaitech.bookkeeping.user.deal.Deal;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@DiscriminatorValue(value = "1")
@Getter
@Setter
// n+1
//@NamedEntityGraph(name = "Expense.Graph", attributeNodes = {
//        @NamedAttributeNode("tags"),
//        @NamedAttributeNode("categories"),
//        @NamedAttributeNode("payee"),
//        @NamedAttributeNode("account"),
//})
public class Expense extends Deal {

}
