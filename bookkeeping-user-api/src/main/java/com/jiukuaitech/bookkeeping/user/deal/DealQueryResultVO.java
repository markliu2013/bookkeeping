package com.jiukuaitech.bookkeeping.user.deal;

import lombok.Getter;
import lombok.Setter;
import org.springframework.data.domain.Page;

import java.math.BigDecimal;

@Getter
@Setter
public class DealQueryResultVO {

    private Page<DealVOForList> result;
    private BigDecimal total;

}
