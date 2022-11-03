package com.jiukuaitech.bookkeeping.user.utils;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

public class CalendarUtils {

    public static void setToStartOfDay(Calendar c) {
        c.set(Calendar.HOUR_OF_DAY, 0);
        c.set(Calendar.MINUTE, 0);
        c.set(Calendar.SECOND, 0);
        c.set(Calendar.MILLISECOND, 0);
    }

    public static void setToEndOfDay(Calendar c) {
        c.set(Calendar.HOUR_OF_DAY, 23);
        c.set(Calendar.MINUTE, 59);
        c.set(Calendar.SECOND, 59);
        c.set(Calendar.MILLISECOND, 999);
    }

    public static void setToStartOfWeek(Calendar c) {
        setToStartOfDay(c);
        // TODO 国际化，美国的星期一是第一天，或者改为可设置
//        c.setFirstDayOfWeek(Calendar.SUNDAY);
        c.setFirstDayOfWeek(Calendar.MONDAY);
        c.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
    }

    public static void setToEndOfWeek(Calendar c) {
        setToEndOfDay(c);
        // TODO 国际化，美国的星期一是第一天，或者改为可设置
        c.setFirstDayOfWeek(Calendar.MONDAY);
        c.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
    }

    public static void setToStartOfMonth(Calendar c) {
        setToStartOfDay(c);
        c.set(Calendar.DAY_OF_MONTH, 1);
    }
    public static void setToEndOfMonth(Calendar c) {
        setToEndOfDay(c);
        c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
    }

    public static void setToStartOfQuarter(Calendar c) {
        setToStartOfDay(c);
        c.set(Calendar.DAY_OF_MONTH, 1);
        c.set(Calendar.MONTH, c.get(Calendar.MONTH)/3 * 3);
    }
    public static void setToEndOfQuarter(Calendar c) {
        setToEndOfDay(c);
        c.set(Calendar.DAY_OF_MONTH, 1);
        c.set(Calendar.MONTH, c.get(Calendar.MONTH)/3 * 3 + 2);
        c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
    }

    public static void setToStartOfYear(Calendar c) {
        setToStartOfDay(c);
        c.set(Calendar.DAY_OF_YEAR, 1);
    }

    public static void setToEndOfYear(Calendar c) {
        setToEndOfDay(c);
        c.set(Calendar.DAY_OF_YEAR, c.getActualMaximum(Calendar.DAY_OF_YEAR));
    }

    public static Long getStartOfDay(Long time) {
        Calendar c = Calendar.getInstance();
        c.setTimeInMillis(time);
        setToStartOfDay(c);
        return c.getTimeInMillis();
    }

    public static Long getEndOfDay(Long time) {
        Calendar c = Calendar.getInstance();
        c.setTimeInMillis(time);
        setToEndOfDay(c);
        return c.getTimeInMillis();
    }

    public static Long[] getThisWeek() {
        Calendar start = Calendar.getInstance();
        start.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
        setToStartOfDay(start);
        Calendar end = Calendar.getInstance();
        end.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
        setToEndOfDay(end);
        return new Long[]{ start.getTimeInMillis(), end.getTimeInMillis() };
    }

    public static Long[] getThisMonth() {
        Calendar start = Calendar.getInstance();
        start.set(Calendar.DAY_OF_MONTH, 1);
        setToStartOfDay(start);
        Calendar end = Calendar.getInstance();
        end.set(Calendar.DAY_OF_MONTH, end.getActualMaximum(Calendar.DAY_OF_MONTH));
        setToEndOfDay(end);
        return new Long[]{ start.getTimeInMillis(), end.getTimeInMillis() };
    }

    public static Long[] getThisYear() {
        Calendar start = Calendar.getInstance();
        start.set(Calendar.DAY_OF_YEAR, 1);
        setToStartOfDay(start);
        Calendar end = Calendar.getInstance();
        end.set(Calendar.DAY_OF_YEAR, end.getActualMaximum(Calendar.DAY_OF_YEAR));
        setToEndOfDay(end);
        return new Long[]{ start.getTimeInMillis(), end.getTimeInMillis() };
    }

    public static Long[] getLastYear() {
        Calendar start = Calendar.getInstance();
        start.set(Calendar.DAY_OF_YEAR, 1);
        setToStartOfDay(start);
        Calendar end = Calendar.getInstance();
        end.set(Calendar.DAY_OF_YEAR, end.getActualMaximum(Calendar.DAY_OF_YEAR));
        setToEndOfDay(end);
        start.add(Calendar.YEAR, -1);
        end.add(Calendar.YEAR, -1);
        return new Long[]{ start.getTimeInMillis(), end.getTimeInMillis() };
    }

    public static Long[] getIn7Days() {
        Calendar start = Calendar.getInstance();
        start.add(Calendar.DATE, -7);
        setToStartOfDay(start);
        Calendar end = Calendar.getInstance();
        setToEndOfDay(end);
        return new Long[]{ start.getTimeInMillis(), end.getTimeInMillis() };
    }

    public static Long[] getIn30Days() {
        Calendar start = Calendar.getInstance();
        start.add(Calendar.DATE, -30);
        setToStartOfDay(start);
        Calendar end = Calendar.getInstance();
        setToEndOfDay(end);
        return new Long[]{ start.getTimeInMillis(), end.getTimeInMillis() };
    }

    public static Long[] getIn1Year() {
        Calendar start = Calendar.getInstance();
        start.add(Calendar.YEAR, -1);
        setToStartOfDay(start);
        Calendar end = Calendar.getInstance();
        setToEndOfDay(end);
        return new Long[]{ start.getTimeInMillis(), end.getTimeInMillis() };
    }

    public static List<Calendar[]> getMonths(Integer year) {
        List<Calendar[]> result = new ArrayList<>();
        Calendar calendar = Calendar.getInstance();
        if (year < 1970 || year > calendar.get(Calendar.YEAR)) {
            return result;
        }
        if (year == calendar.get(Calendar.YEAR)) {
            calendar.add(Calendar.MONTH, -11);
        } else {
            calendar.set(Calendar.YEAR, year);
            calendar.set(Calendar.MONTH, 0);
        }
        for (int i = 0; i < 12; i++) {
            Calendar start = (Calendar) calendar.clone();
            start.set(Calendar.DAY_OF_MONTH, 1);
            setToStartOfDay(start);
            Calendar end = (Calendar) calendar.clone();
            end.set(Calendar.DAY_OF_MONTH, end.getActualMaximum(Calendar.DAY_OF_MONTH));
            setToEndOfDay(end);
            result.add(new Calendar[]{ start, end });
            calendar.add(Calendar.MONTH, 1);
        }
        return result;
    }

    public static List<Calendar[]> getBreaks(Long start, Long end, String type) {
        List<Calendar[]> result = new ArrayList<>();
        Calendar startCalendar = Calendar.getInstance();
        startCalendar.setTimeInMillis(start);
        setToStartOfDay(startCalendar);
        Calendar endCalendar = Calendar.getInstance();
        endCalendar.setTimeInMillis(end);
        setToEndOfDay(endCalendar);
        switch (type) {
            case "day":
                while (startCalendar.getTimeInMillis() < endCalendar.getTimeInMillis()) {
                    Calendar c1 = (Calendar) startCalendar.clone();
                    Calendar c2 = (Calendar) startCalendar.clone();
                    setToEndOfDay(c2);
                    result.add(new Calendar[]{ c1, c2 });
                    startCalendar.add(Calendar.DATE, 1);
                }
                break;
            case "week":
                setToStartOfWeek(startCalendar);
                while (startCalendar.getTimeInMillis() < endCalendar.getTimeInMillis()) {
                    Calendar c1 = (Calendar) startCalendar.clone();
                    Calendar c2 = (Calendar) startCalendar.clone();
                    setToEndOfWeek(c2);
                    result.add(new Calendar[]{ c1, c2 });
                    startCalendar.add(Calendar.WEEK_OF_YEAR, 1);
                }
                break;
            case "month":
                setToStartOfMonth(startCalendar);
                while (startCalendar.getTimeInMillis() < endCalendar.getTimeInMillis()) {
                    Calendar c1 = (Calendar) startCalendar.clone();
                    Calendar c2 = (Calendar) startCalendar.clone();
                    setToEndOfMonth(c2);
                    result.add(new Calendar[]{ c1, c2 });
                    startCalendar.add(Calendar.MONTH, 1);
                }
                break;
            case "quarter":
                setToStartOfQuarter(startCalendar);
                while (startCalendar.getTimeInMillis() < endCalendar.getTimeInMillis()) {
                    Calendar c1 = (Calendar) startCalendar.clone();
                    Calendar c2 = (Calendar) startCalendar.clone();
                    setToEndOfQuarter(c2);
                    result.add(new Calendar[]{ c1, c2 });
                    startCalendar.add(Calendar.MONTH, 3);
                }
                break;
            case "year":
                setToStartOfYear(startCalendar);
                while (startCalendar.getTimeInMillis() < endCalendar.getTimeInMillis()) {
                    Calendar c1 = (Calendar) startCalendar.clone();
                    Calendar c2 = (Calendar) startCalendar.clone();
                    setToEndOfYear(c2);
                    result.add(new Calendar[]{ c1, c2 });
                    startCalendar.add(Calendar.YEAR, 1);
                }
                break;
        }
        return result;
    }


}
