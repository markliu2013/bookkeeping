package com.jiukuaitech.bookkeeping.user.interceptor;

import com.jiukuaitech.bookkeeping.user.exception.TokenEmptyException;
import com.jiukuaitech.bookkeeping.user.exception.TokenNotValidException;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class AuthInterceptor implements HandlerInterceptor {
    
    private final RedisTemplate<String, Integer> redisTemplate;
    
    public AuthInterceptor(RedisTemplate<String, Integer> redisTemplate) {
        this.redisTemplate = redisTemplate;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        String userToken = request.getHeader("User-Token");
        if (!StringUtils.hasText(userToken)) throw new TokenEmptyException();
        Integer userSignInId = redisTemplate.boundValueOps(userToken).get();
        if (userSignInId == null) throw new TokenNotValidException();
        request.setAttribute("userSignInId", userSignInId);
        return true;
    }

}
