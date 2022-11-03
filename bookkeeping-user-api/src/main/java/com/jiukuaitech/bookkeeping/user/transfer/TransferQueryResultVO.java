package com.jiukuaitech.bookkeeping.user.transfer;

import lombok.Getter;
import lombok.Setter;
import org.springframework.data.domain.Page;

import java.math.BigDecimal;

@Getter
@Setter
public class TransferQueryResultVO {

    private Page<TransferVOForList> result;
    private BigDecimal total;

}
