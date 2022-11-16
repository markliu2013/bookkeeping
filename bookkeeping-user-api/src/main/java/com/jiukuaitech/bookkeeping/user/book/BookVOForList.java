package com.jiukuaitech.bookkeeping.user.book;

import com.jiukuaitech.bookkeeping.user.account.AccountVOForExtend;
import com.jiukuaitech.bookkeeping.user.response.HasNameVO;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BookVOForList {

    private Integer id;
    private String name;
    private String notes;
    private HasNameVO group;
    private AccountVOForExtend defaultExpenseAccount;
    private AccountVOForExtend defaultIncomeAccount;
    private AccountVOForExtend defaultTransferFromAccount;
    private AccountVOForExtend defaultTransferToAccount;
    private HasNameVO defaultExpenseCategory;
    private HasNameVO defaultIncomeCategory;
    private Boolean descriptionEnable;
    private Boolean timeEnable;
    private Boolean imageEnable;
    private Boolean enable;
    private String defaultCurrencyCode;

    public static BookVOForList fromEntity(Book po) {
        BookVOForList vo = new BookVOForList();
        vo.setId(po.getId());
        vo.setName(po.getName());
        vo.setDefaultCurrencyCode(po.getDefaultCurrencyCode());
        vo.setNotes(po.getNotes());
        vo.setGroup(new HasNameVO(po.getGroup().getId(), po.getGroup().getName()));
        vo.setDescriptionEnable(po.getDescriptionEnable());
        vo.setTimeEnable(po.getTimeEnable());
        vo.setImageEnable(po.getImageEnable());
        vo.setEnable(po.getEnable());
        if (po.getDefaultExpenseAccount() != null) {
            vo.setDefaultExpenseAccount(AccountVOForExtend.fromEntity(po.getDefaultExpenseAccount()));
        }
        if (po.getDefaultIncomeAccount() != null) {
            vo.setDefaultIncomeAccount(AccountVOForExtend.fromEntity(po.getDefaultIncomeAccount()));
        }
        if (po.getDefaultTransferFromAccount() != null) {
            vo.setDefaultTransferFromAccount(AccountVOForExtend.fromEntity(po.getDefaultTransferFromAccount()));
        }
        if (po.getDefaultTransferToAccount() != null) {
            vo.setDefaultTransferToAccount(AccountVOForExtend.fromEntity(po.getDefaultTransferToAccount()));
        }
        if (po.getDefaultExpenseCategory() != null) {
            vo.setDefaultExpenseCategory(new HasNameVO(po.getDefaultExpenseCategory().getId(), po.getDefaultExpenseCategory().getName()));
        }
        if (po.getDefaultIncomeCategory() != null) {
            vo.setDefaultIncomeCategory(new HasNameVO(po.getDefaultIncomeCategory().getId(), po.getDefaultIncomeCategory().getName()));
        }
        return vo;
    }

}
