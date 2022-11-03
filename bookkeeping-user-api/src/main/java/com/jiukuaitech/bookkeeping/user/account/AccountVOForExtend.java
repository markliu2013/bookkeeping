package com.jiukuaitech.bookkeeping.user.account;

import com.jiukuaitech.bookkeeping.user.utils.EnumUtils;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class AccountVOForExtend {

    private Integer type; //1活期，2信用，3贷款，4资产
    private Integer id;
    private String name;
    private String no;
    private BigDecimal balance;
    private BigDecimal convertedBalance;
    private String currencyCode;
    private Boolean enable;
    private Boolean include;
    private Boolean expenseable;
    private Boolean incomeable;
    private Boolean transferFromAble;
    private Boolean transferToAble;
    private BigDecimal initialBalance;
    private String notes;

    public void setValue(Account po) {
        setType(po.getType());
        setId(po.getId());
        setName(po.getName());
        setNo(po.getNo());
        setBalance(po.getBalance());
        setEnable(po.getEnable());
        setInclude(po.getInclude());
        setExpenseable(po.getExpenseable());
        setIncomeable(po.getIncomeable());
        setTransferFromAble(po.getTransferFromAble());
        setTransferToAble(po.getTransferToAble());
        setInitialBalance(po.getInitialBalance());
        setNotes(po.getNotes());
        setCurrencyCode(po.getCurrencyCode());
    }

    public static AccountVOForExtend fromEntity(Account po) {
        if (po == null) return null;
        AccountVOForExtend vo = new AccountVOForExtend();
        vo.setValue(po);
        return vo;
    }

    public String getTypeName() {
        return EnumUtils.translateAccountType(type);
    }

    public String getBalanceFormatted() {
        return String.format("%.2f", balance);
    }

}
