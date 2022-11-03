package com.jiukuaitech.bookkeeping.user.income;

import com.jiukuaitech.bookkeeping.user.deal.Deal;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@DiscriminatorValue(value = "2")
@Getter
@Setter
public class Income extends Deal {
    
}
