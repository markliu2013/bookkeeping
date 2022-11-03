package com.jiukuaitech.bookkeeping.user.user;

import lombok.Getter;
import lombok.Setter;
import java.util.Date;

@Getter
@Setter
public class UserSessionVO {
    
    private Integer id;
    private String userName;
    private String nickName;
    private String telephone;
    private String email;
    private String avatar;
    private Date lastActiveTime; //上次操作的时间，利用AOP，在每次用户执行操作后更新。可实现用户在操作时，redis的token过期问题。
    private Long vipTime;

    public static UserSessionVO fromEntity(User user) {
        UserSessionVO userSessionVO = new UserSessionVO();
        userSessionVO.setId(user.getId());
        userSessionVO.setUserName(user.getUserName());
        userSessionVO.setNickName(user.getNickName());
        userSessionVO.setTelephone(user.getTelephone());
        userSessionVO.setEmail(user.getEmail());
        userSessionVO.setAvatar(user.getAvatar());
        userSessionVO.setVipTime(user.getVipTime());
        return userSessionVO;
    }

}
