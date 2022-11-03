package com.jiukuaitech.bookkeeping.user.item;

import com.jiukuaitech.bookkeeping.user.utils.EnumUtils;
import lombok.Getter;
import lombok.Setter;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;

@Getter
@Setter
public class ItemVOForList {

    private  Integer id;
    private String title;
    private String notes;
    private Long startDate;
    private Long endDate;
    private Integer repeatType;
    private Integer interval;
    private String repeatDescription;
    private Long countDown;//倒计时天数
    //下次执行日期
    private Long nextDate;
    //总执行次数
    private Integer totalCount;
    //已执行次数
    private Integer runCount;
    //剩余次数
    private Integer remainCount;

    public static ItemVOForList fromEntity(Item po) {
        if (po == null) return null;
        ItemVOForList vo = new ItemVOForList();
        vo.setId(po.getId());
        vo.setTitle(po.getTitle());
        vo.setNotes(po.getNotes());
        vo.setStartDate(po.getStartDate());
        vo.setEndDate(po.getEndDate());
        vo.setNextDate(po.getNextDate());
        vo.setRepeatType(po.getRepeatType());
        vo.setInterval(po.getInterval());
        vo.setTotalCount(po.getTotalCount());
        vo.setRunCount(po.getRunCount());
        if (po.getRepeatType() == 0) {
            vo.setRepeatDescription("单次执行");
        } else {
            vo.setRepeatDescription("每" + (po.getInterval() != 1 ? po.getInterval() : "") + EnumUtils.translateItemRepeatType(po.getRepeatType()) + "执行一次");
        }
        LocalDate now = LocalDate.now();
        LocalDate nextDate = Instant.ofEpochMilli(vo.getNextDate()).atZone(ZoneId.systemDefault()).toLocalDate();
        vo.setCountDown(ChronoUnit.DAYS.between(
            LocalDate.of(now.getYear(), now.getMonth(), now.getDayOfMonth()),
            LocalDate.of(nextDate.getYear(), nextDate.getMonth(), nextDate.getDayOfMonth())
        ));
        vo.setRemainCount(po.getTotalCount() - po.getRunCount());
        return vo;
    }
}
