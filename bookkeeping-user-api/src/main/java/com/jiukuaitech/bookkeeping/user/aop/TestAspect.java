package com.jiukuaitech.bookkeeping.user.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Configuration;

import java.util.Arrays;

@Aspect
@Configuration
public class TestAspect {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Before("execution(* com.jiukuaitech.bookkeeping.user.service.*.*(..))")
    public void before(JoinPoint joinPoint) {
        logger.info(" Check before-------------------------------------------------------- ");
        logger.info(" Allowed execution for {}", "");
        logger.info(Arrays.toString(joinPoint.getArgs()));
    }

}
