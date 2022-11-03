package com.jiukuaitech.bookkeeping.user.asset_account;

import com.jiukuaitech.bookkeeping.user.account.AccountVOForExtend;
import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
public class AssetAccountVOForList extends AccountVOForExtend {

    private Long asOfDate;

    public static AssetAccountVOForList fromEntity(AssetAccount po) {
        AssetAccountVOForList vo = new AssetAccountVOForList();
        vo.setValue(po);
        vo.setAsOfDate(po.getAsOfDate());
        return vo;
    }

}
