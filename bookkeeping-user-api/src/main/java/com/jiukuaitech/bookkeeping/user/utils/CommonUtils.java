package com.jiukuaitech.bookkeeping.user.utils;

import com.jiukuaitech.bookkeeping.user.tag.Tag;
import com.jiukuaitech.bookkeeping.user.tag_relation.TagRelation;
import com.jiukuaitech.bookkeeping.user.transaction.Transaction;
import org.springframework.util.DigestUtils;

import javax.servlet.http.HttpServletRequest;
import javax.xml.bind.DatatypeConverter;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

public class CommonUtils {

    public static List<BigDecimal> coalesce(BigDecimal... items) {
        return Arrays.stream(items).map(i -> i == null ? BigDecimal.valueOf(0) :i ).collect(Collectors.toList());
    }

    public static void cleanTagRelation(Set<TagRelation> tagRelations, Set<Integer> requestTagIds) {
        Set<Integer> entityTagIds = tagRelations.stream().map(i->i.getTag().getId()).collect(Collectors.toSet());
        List<Integer> existsIds = new ArrayList<>();
        List<TagRelation> toBeRemoved = new ArrayList<>();
        requestTagIds.forEach(i -> {
            if (entityTagIds.contains(i)) {
                existsIds.add(i);
            }
        });
        tagRelations.forEach(j -> {
            if (!requestTagIds.contains(j.getTag().getId())) {
                toBeRemoved.add(j);
            }
        });
        tagRelations.removeAll(toBeRemoved);
        requestTagIds.removeAll(existsIds);
    }

    public static TagRelation getTagRelation(Integer tagId, Transaction transaction) {
        TagRelation po = new TagRelation();
        po.setAmount(transaction.getAmount());
        po.setConvertedAmount(transaction.getConvertedAmount());
        po.setTransaction(transaction);
        po.setTag(new Tag(tagId));
        return po;
    }

    /**
     * 获取用户真实IP地址，不使用request.getRemoteAddr()的原因是有可能用户使用了代理软件方式避免真实IP地址,
     * 可是，如果通过了多级反向代理的话，X-Forwarded-For的值并不止一个，而是一串IP值
     *
     * @return ip
     */
    public static String getRealIP(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        if (ip != null && ip.length() != 0 && !"unknown".equalsIgnoreCase(ip)) {
            // 多次反向代理后会有多个ip值，第一个ip才是真实ip
            if( ip.indexOf(",")!=-1 ){
                ip = ip.split(",")[0];
            }
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
            System.out.println("Proxy-Client-IP ip: " + ip);
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
            System.out.println("WL-Proxy-Client-IP ip: " + ip);
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_CLIENT_IP");
            System.out.println("HTTP_CLIENT_IP ip: " + ip);
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
            System.out.println("HTTP_X_FORWARDED_FOR ip: " + ip);
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("X-Real-IP");
            System.out.println("X-Real-IP ip: " + ip);
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
            System.out.println("getRemoteAddr ip: " + ip);
        }
        return ip;
    }

    public static String encodePassword(String str) {
        byte[] digest = DigestUtils.md5Digest(str.getBytes());
        return DatatypeConverter.printHexBinary(digest);
    }

    public static String formatDate(Long date) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(new Date(date));
    }

}
