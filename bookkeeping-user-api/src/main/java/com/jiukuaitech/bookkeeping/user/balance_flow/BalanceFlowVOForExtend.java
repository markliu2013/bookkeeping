package com.jiukuaitech.bookkeeping.user.balance_flow;

import com.jiukuaitech.bookkeeping.user.account.AccountVOForExtend;
import com.jiukuaitech.bookkeeping.user.utils.EnumUtils;
import com.jiukuaitech.bookkeeping.user.response.HasNameVO;
import lombok.Getter;
import lombok.Setter;
import java.math.BigDecimal;

@Getter
@Setter
public class BalanceFlowVOForExtend {

    private Integer id;
    private HasNameVO book;
    private BigDecimal amount;
    private BigDecimal convertedAmount;
    private String currencyCode;
    private Boolean needConvert;
    private String toCurrencyCode;
    private AccountVOForExtend account;
    private String accountName;
    private Long createTime;
    private String description;
    private String notes;
    private Integer status;

    public void setValue(BalanceFlow po) {
        setId(po.getId());
        setBook(new HasNameVO(po.getBook().getId(), po.getBook().getName()));
        setAmount(po.getAmount());
        setConvertedAmount(po.getConvertedAmount());
        if (po.getAccount() != null) setAccount(AccountVOForExtend.fromEntity(po.getAccount()));
        setAccountName(getAccount() == null ? null : getAccount().getName());
        setCreateTime(po.getCreateTime());
        setDescription(po.getDescription());
        setNotes(po.getNotes());
        setStatus(po.getStatus());
    }

    public static BalanceFlowVOForExtend fromEntity(BalanceFlow balanceFlow) {
        BalanceFlowVOForExtend result = new BalanceFlowVOForExtend();
        result.setValue(balanceFlow);
        return result;
    }

    public String getStatusName() {
        return EnumUtils.translateFlowStatus(getStatus());
    }

}
