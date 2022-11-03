package com.jiukuaitech.bookkeeping.user.utils;

public class EnumUtils {

    public static String translateFlowType(int value) {
        switch (value) {
            case 1:
                return "支出";
            case 2:
                return "收入";
            case 3:
                return "转账";
            case 4:
                return "余额调整";
        }
        return "未知";
    }

    public static String translateFlowStatus(int value) {
        switch (value) {
            case 1:
                return "正常";
            case 2:
                return "待确认";
            case 3:
                return "已退款";
        }
        return "未知";
    }

    public static String translateAccountType(int value) {
        switch (value) {
            case 1:
                return "活期账户";
            case 2:
                return "信用账户";
            case 3:
                return "贷款账户";
            case 4:
                return "资产账户";
        }
        return "未知";
    }

    public static String translateItemRepeatType(int type) {
        switch (type) {
            case 1:
                return "天";
            case 2:
                return "月";
            case 3:
                return "年";
        }
        return "未知";
    }

}
