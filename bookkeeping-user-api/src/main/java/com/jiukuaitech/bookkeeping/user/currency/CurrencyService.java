package com.jiukuaitech.bookkeeping.user.currency;

import com.jiukuaitech.bookkeeping.user.exception.InputNotValidException;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class CurrencyService {

    @Resource
    private CurrencyRepository currencyRepository;

    public List<Currency> getAll() {
        return currencyRepository.findAll();
    }

    public void checkCode(String code) {
        if (code == null) return;;
        List<Currency> currencyList = getAll();
        List<String> currencyCodeList = currencyList.stream().map(Currency::getCode).collect(Collectors.toList());
        if (!currencyCodeList.contains(code)) {
            throw new InputNotValidException();
        }
    }

    // TODO 定时任务，数据存入缓存
    public BigDecimal convert(String fromCode, String toCode) {
        Currency fromCurrency = currencyRepository.findOneByCode(fromCode).orElseThrow();
        Currency toCurrency = currencyRepository.findOneByCode(toCode).orElseThrow();
        BigDecimal fromRate = fromCurrency.getRate();
        BigDecimal toRate = toCurrency.getRate();
        return toRate.divide(fromRate, 2, RoundingMode.CEILING);
    }

    public BigDecimal convert(BigDecimal amount, String fromCode, String toCode) {
        if (fromCode.equals(toCode)) {
            return amount;
        }
        return amount.multiply(convert(fromCode, toCode)).setScale(2, RoundingMode.CEILING);
    }

}
