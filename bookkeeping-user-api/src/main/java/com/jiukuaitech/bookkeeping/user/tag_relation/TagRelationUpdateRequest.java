package com.jiukuaitech.bookkeeping.user.tag_relation;


import com.jiukuaitech.bookkeeping.user.validation.AmountValidator;
import lombok.Getter;
import lombok.Setter;
import java.math.BigDecimal;

@Getter
@Setter
public class TagRelationUpdateRequest {

    @AmountValidator
    private BigDecimal amount;

    private BigDecimal convertedAmount;

}
