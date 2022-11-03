package com.jiukuaitech.bookkeeping.user.currency;

import com.jiukuaitech.bookkeeping.user.base.BaseRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface CurrencyRepository extends BaseRepository<Currency, Integer> {

    Optional<Currency> findOneByCode(String code);

}
