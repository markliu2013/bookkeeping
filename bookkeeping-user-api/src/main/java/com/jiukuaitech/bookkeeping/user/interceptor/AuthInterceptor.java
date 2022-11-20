package com.jiukuaitech.bookkeeping.user.interceptor;

import com.jiukuaitech.bookkeeping.user.exception.TokenEmptyException;
import com.jiukuaitech.bookkeeping.user.exception.TokenNotValidException;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.util.WebUtils;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class AuthInterceptor implements HandlerInterceptor {

    @Resource
    private ServletContext servletContext;
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        String userToken = request.getHeader("User-Token");
        // try session
        if (!StringUtils.hasText(userToken)) {
            userToken = (String) request.getSession().getAttribute("User-Token");
        }
        // try cookie
        if (!StringUtils.hasText(userToken)) {
            if (WebUtils.getCookie(request, "User-Token") != null) {
                userToken = WebUtils.getCookie(request, "User-Token").getValue();
            }
        }
        if (!StringUtils.hasText(userToken)) {
            throw new TokenEmptyException();
        }
        Integer userSignInId = (Integer) servletContext.getAttribute(userToken);
        if (userSignInId == null) throw new TokenNotValidException();
        request.setAttribute("userSignInId", userSignInId);
        return true;
    }

}
