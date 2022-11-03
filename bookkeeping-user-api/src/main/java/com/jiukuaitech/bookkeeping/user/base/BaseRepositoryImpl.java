package com.jiukuaitech.bookkeeping.user.base;

import com.jiukuaitech.bookkeeping.user.utils.CommonUtils;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.support.JpaEntityInformation;
import org.springframework.data.jpa.repository.support.SimpleJpaRepository;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import javax.persistence.criteria.Selection;
import javax.persistence.metamodel.SingularAttribute;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/*
https://stackoverflow.com/questions/38934549/spring-specification-with-sum-function
 */
public class BaseRepositoryImpl<T, ID extends Serializable> extends SimpleJpaRepository<T, ID> implements BaseRepository<T, ID> {

    private final EntityManager entityManager;

    public BaseRepositoryImpl(Class<T> domainClass, EntityManager entityManager) {
        super(domainClass, entityManager);
        this.entityManager = entityManager;
    }

    public BaseRepositoryImpl(JpaEntityInformation<T, ?> entityInformation, EntityManager entityManager) {
        super(entityInformation, entityManager);
        this.entityManager = entityManager;
    }

    @Override
    public <E> BigDecimal calcAggregate(Specification<E> spec, SingularAttribute<?, BigDecimal> column, Class<E> clazz) {
        CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
        CriteriaQuery<BigDecimal> query = criteriaBuilder.createQuery(column.getJavaType());
        Root<E> root = query.from(clazz);
        if (spec != null) {
            query.where(spec.toPredicate(root, query, criteriaBuilder));
        }
        query.select(criteriaBuilder.sum(root.get(column.getName())));
        TypedQuery<BigDecimal> typedQuery = entityManager.createQuery(query);
        BigDecimal result = typedQuery.getSingleResult();
        if (result == null) return BigDecimal.valueOf(0);
        return result;
    }

    @Override
    public <E> List<BigDecimal> calcAggregate(Specification<E> spec, List<SingularAttribute<?, BigDecimal>> columns, Class<E> clazz) {
        CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
        CriteriaQuery<BigDecimal[]> query = criteriaBuilder.createQuery(BigDecimal[].class);
        Root<E> root = query.from(clazz);
        if (spec != null) {
            query.where(spec.toPredicate(root, query, criteriaBuilder));
        }
        List<Selection<?>> selectionList = new ArrayList<>();
        columns.forEach(i -> selectionList.add(criteriaBuilder.sum(root.get(i.getName()))));
        query.multiselect(selectionList);
        Object[] result = entityManager.createQuery(query).getSingleResult();
        return CommonUtils.coalesce(Arrays.copyOf(result, result.length, BigDecimal[].class));
    }

}
