package com.jiukuaitech.bookkeeping.user.permission;

import com.jiukuaitech.bookkeeping.user.book.Book;
import com.jiukuaitech.bookkeeping.user.exception.PermissionException;
import com.jiukuaitech.bookkeeping.user.user.User;
import com.jiukuaitech.bookkeeping.user.user.UserGroupRelation;
import com.jiukuaitech.bookkeeping.user.user.UserGroupRelationRepository;
import com.jiukuaitech.bookkeeping.user.user.UserRepository;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

@Aspect
@Component
public class PermissionCheckAspect {

    @Resource
    private HttpServletRequest request;

    @Resource
    private UserGroupRelationRepository userGroupRelationRepository;

    @Resource
    private UserRepository userRepository;

    @Pointcut("@annotation(com.jiukuaitech.bookkeeping.user.permission.PermissionCheck)")
    private void permissionCheckCut() { };

    @Before("permissionCheckCut()")
    public void before(JoinPoint joinPoint) {
        Integer userId = (Integer) request.getAttribute("userSignInId");
        User user = userRepository.findById(userId).get();
        Book book = user.getDefaultBook();
        UserGroupRelation userGroupRelation = userGroupRelationRepository.findOneByUserAndGroup(user, book.getGroup());
        if (userGroupRelation == null || userGroupRelation.getRole() == 3) {
            throw new PermissionException("No Permission");
        }
    }

}
