package com.jiukuaitech.bookkeeping.user.base;

import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.data.web.config.EnableSpringDataWebSupport;

@Configuration
@EnableJpaRepositories(basePackages = "com.jiukuaitech.bookkeeping.user",
        repositoryFactoryBeanClass = BaseRepositoryFactoryBean.class)
@EnableSpringDataWebSupport
public class JpaDataConfig {
}
