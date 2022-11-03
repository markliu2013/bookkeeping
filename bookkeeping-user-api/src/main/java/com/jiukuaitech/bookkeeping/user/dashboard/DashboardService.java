package com.jiukuaitech.bookkeeping.user.dashboard;

import com.jiukuaitech.bookkeeping.user.account.Account;
import com.jiukuaitech.bookkeeping.user.account.AccountRepository;
import com.jiukuaitech.bookkeeping.user.account.AccountSpec;
import com.jiukuaitech.bookkeeping.user.asset_account.AssetAccount;
import com.jiukuaitech.bookkeeping.user.asset_account.AssetAccountRepository;
import com.jiukuaitech.bookkeeping.user.base.BaseEntity;
import com.jiukuaitech.bookkeeping.user.book.Book;
import com.jiukuaitech.bookkeeping.user.category.Category;
import com.jiukuaitech.bookkeeping.user.category.CategoryRepository;
import com.jiukuaitech.bookkeeping.user.category_relation.CategoryRelation;
import com.jiukuaitech.bookkeeping.user.category_relation.CategoryRelationRepository;
import com.jiukuaitech.bookkeeping.user.checking_account.CheckingAccount;
import com.jiukuaitech.bookkeeping.user.checking_account.CheckingAccountRepository;
import com.jiukuaitech.bookkeeping.user.credit_account.CreditAccount;
import com.jiukuaitech.bookkeeping.user.credit_account.CreditAccountRepository;
import com.jiukuaitech.bookkeeping.user.currency.CurrencyService;
import com.jiukuaitech.bookkeeping.user.debt_account.DebtAccount;
import com.jiukuaitech.bookkeeping.user.debt_account.DebtAccountRepository;
import com.jiukuaitech.bookkeeping.user.expense.ExpenseRepository;
import com.jiukuaitech.bookkeeping.user.group.Group;
import com.jiukuaitech.bookkeeping.user.income.IncomeRepository;
import com.jiukuaitech.bookkeeping.user.user.UserService;
import com.jiukuaitech.bookkeeping.user.reports.ChartVO;
import com.jiukuaitech.bookkeeping.user.utils.CalendarUtils;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class DashboardService {

    @Resource
    private UserService userService;

    @Resource
    private AccountRepository accountRepository;

    @Resource
    private CheckingAccountRepository checkingAccountRepository;

    @Resource
    private CreditAccountRepository creditAccountRepository;

    @Resource
    private DebtAccountRepository debtAccountRepository;

    @Resource
    private AssetAccountRepository assetAccountRepository;

    @Resource
    private ExpenseRepository expenseRepository;

    @Resource
    private IncomeRepository incomeRepository;

    @Resource
    private CategoryRepository categoryRepository;

    @Resource
    private CategoryRelationRepository categoryRelationRepository;

    @Resource
    private CurrencyService currencyService;

    public AssetOverviewVO assetOverview(Integer userSignInId) {
        AssetOverviewVO vo = new AssetOverviewVO();
        Group group = userService.getUser(userSignInId).getDefaultGroup();
        List<CheckingAccount> checkingAccounts = checkingAccountRepository.findAll(AccountSpec.inGroupAndInclude(group));
        List<AssetAccount> assetAccounts = assetAccountRepository.findAll(AccountSpec.inGroupAndInclude(group));
        BigDecimal assetBalance = BigDecimal.ZERO;
        for (int i = 0; i < checkingAccounts.size(); i++) {
            Account account = checkingAccounts.get(i);
            assetBalance = assetBalance.add(currencyService.convert(account.getBalance(), account.getCurrencyCode(), group.getDefaultCurrencyCode()));
        }
        for (int i = 0; i < assetAccounts.size(); i++) {
            Account account = assetAccounts.get(i);
            assetBalance = assetBalance.add(currencyService.convert(account.getBalance(), account.getCurrencyCode(), group.getDefaultCurrencyCode()));
        }
        vo.setAsset(assetBalance);
        List<CreditAccount> creditAccounts = creditAccountRepository.findAll(AccountSpec.inGroupAndInclude(group));
        List<DebtAccount> debtAccounts = debtAccountRepository.findAll(AccountSpec.inGroupAndInclude(group));
        BigDecimal debtBalance = BigDecimal.ZERO;
        for (int i = 0; i < creditAccounts.size(); i++) {
            Account account = creditAccounts.get(i);
            debtBalance = debtBalance.add(currencyService.convert(account.getBalance(), account.getCurrencyCode(), group.getDefaultCurrencyCode()));
        }
        for (int i = 0; i < debtAccounts.size(); i++) {
            Account account = debtAccounts.get(i);
            debtBalance = debtBalance.add(currencyService.convert(account.getBalance(), account.getCurrencyCode(), group.getDefaultCurrencyCode()));
        }
        vo.setDebt(debtBalance.negate());
        return vo;
    }

    public List<List<BigDecimal>> expenseIncomeTable(Integer userSignInId) {
        List<List<BigDecimal>> result = new ArrayList<>();
        Book book = userService.getUser(userSignInId).getDefaultBook();

        Long[] thisWeek = CalendarUtils.getThisWeek();
        Long[] thisMonth = CalendarUtils.getThisMonth();
        Long[] thisYear = CalendarUtils.getThisYear();
        Long[] lastYear = CalendarUtils.getLastYear();
        Long[] in7Days = CalendarUtils.getIn7Days();
        Long[] in30Days = CalendarUtils.getIn30Days();
        Long[] in1Year = CalendarUtils.getIn1Year();

        {
            List<BigDecimal> list = new ArrayList<>();
            list.add(expenseRepository.findSumAmount(book, thisWeek[0], thisWeek[1]));
            list.add(expenseRepository.findSumAmount(book, thisMonth[0], thisMonth[1]));
            list.add(expenseRepository.findSumAmount(book, thisYear[0], thisYear[1]));
            list.add(expenseRepository.findSumAmount(book, lastYear[0], lastYear[1]));
            list.add(expenseRepository.findSumAmount(book, in7Days[0], in7Days[1]));
            list.add(expenseRepository.findSumAmount(book, in30Days[0], in30Days[1]));
            list.add(expenseRepository.findSumAmount(book, in1Year[0], in1Year[1]));
            result.add(list);
        }

        {
            List<BigDecimal> list = new ArrayList<>();
            list.add(incomeRepository.findSumAmount(book, thisWeek[0], thisWeek[1]));
            list.add(incomeRepository.findSumAmount(book, thisMonth[0], thisMonth[1]));
            list.add(incomeRepository.findSumAmount(book, thisYear[0], thisYear[1]));
            list.add(incomeRepository.findSumAmount(book, lastYear[0], lastYear[1]));
            list.add(incomeRepository.findSumAmount(book, in7Days[0], in7Days[1]));
            list.add(incomeRepository.findSumAmount(book, in30Days[0], in30Days[1]));
            list.add(incomeRepository.findSumAmount(book, in1Year[0], in1Year[1]));
            result.add(list);
        }

        {
            List<BigDecimal> list = new ArrayList<>();
            list.add(BigDecimal.valueOf(expenseRepository.findCount(book, thisWeek[0], thisWeek[1])));
            list.add(BigDecimal.valueOf(expenseRepository.findCount(book, thisMonth[0], thisMonth[1])));
            list.add(BigDecimal.valueOf(expenseRepository.findCount(book, thisYear[0], thisYear[1])));
            list.add(BigDecimal.valueOf(expenseRepository.findCount(book, lastYear[0], lastYear[1])));
            list.add(BigDecimal.valueOf(expenseRepository.findCount(book, in7Days[0], in7Days[1])));
            list.add(BigDecimal.valueOf(expenseRepository.findCount(book, in30Days[0], in30Days[1])));
            list.add(BigDecimal.valueOf(expenseRepository.findCount(book, in1Year[0], in1Year[1])));
            result.add(list);
        }

        {
            List<BigDecimal> list = new ArrayList<>();
            list.add(BigDecimal.valueOf(incomeRepository.findCount(book, thisWeek[0], thisWeek[1])));
            list.add(BigDecimal.valueOf(incomeRepository.findCount(book, thisMonth[0], thisMonth[1])));
            list.add(BigDecimal.valueOf(incomeRepository.findCount(book, thisYear[0], thisYear[1])));
            list.add(BigDecimal.valueOf(incomeRepository.findCount(book, lastYear[0], lastYear[1])));
            list.add(BigDecimal.valueOf(incomeRepository.findCount(book, in7Days[0], in7Days[1])));
            list.add(BigDecimal.valueOf(incomeRepository.findCount(book, in30Days[0], in30Days[1])));
            list.add(BigDecimal.valueOf(incomeRepository.findCount(book, in1Year[0], in1Year[1])));
            result.add(list);
        }

        return result;
    }

    public List<ChartVO> expenseTrend(Integer userSignInId) {
        List<ChartVO> result = new ArrayList<>();
        Book book = userService.getUser(userSignInId).getDefaultBook();
        List<Calendar[]> months = CalendarUtils.getMonths(Calendar.getInstance().get(Calendar.YEAR));
        months.forEach(i -> {
            ChartVO vo = new ChartVO();
            vo.setX(new SimpleDateFormat("yyyy.MM").format(i[0].getTime()));
            vo.setY(expenseRepository.findSumAmount(book, i[0].getTimeInMillis(), i[1].getTimeInMillis()));
            result.add(vo);
        });
        return result;
    }

    public List<ChartVO> incomeTrend(Integer userSignInId) {
        List<ChartVO> result = new ArrayList<>();
        Book book = userService.getUser(userSignInId).getDefaultBook();
        List<Calendar[]> months = CalendarUtils.getMonths(Calendar.getInstance().get(Calendar.YEAR));
        months.forEach(i -> {
            ChartVO vo = new ChartVO();
            vo.setX(new SimpleDateFormat("yyyy.MM").format(i[0].getTime()));
            vo.setY(incomeRepository.findSumAmount(book, i[0].getTimeInMillis(), i[1].getTimeInMillis()));
            result.add(vo);
        });
        return result;
    }

    public List<ChartVO> expenseCategory(Long start, Long end, Integer userSignInId) {
        List<ChartVO> result = new ArrayList<>();
        Book book = userService.getUser(userSignInId).getDefaultBook();
        List<Category> categories = categoryRepository.findAllByBookAndType(book, 1);
        List<Category> rootCategories = categories.stream().filter(i->i.getLevel() == 0).collect(Collectors.toList());
        List<CategoryRelation> relations = categoryRelationRepository.findByBookAndCreateTimeBetween(book, start, end);
        rootCategories.forEach(i -> {
            ChartVO vo = new ChartVO();
            vo.setX(i.getName());
            List<Integer> offSpringCategoryIds = i.getOffspring(categories).stream().map(BaseEntity::getId).collect(Collectors.toList());
            offSpringCategoryIds.add(i.getId());
            vo.setY(relations.stream().filter(j -> offSpringCategoryIds.contains(j.getCategory().getId())).map(CategoryRelation::getConvertedAmount).reduce(BigDecimal.ZERO, BigDecimal::add));
            if (vo.getY().compareTo(BigDecimal.ZERO) > 0) {
                result.add(vo);
            }
        });
        return result;
    }

    public List<ChartVO> incomeCategory(Long start, Long end, Integer userSignInId) {
        List<ChartVO> result = new ArrayList<>();
        Book book = userService.getUser(userSignInId).getDefaultBook();
        List<Category> categories = categoryRepository.findAllByBookAndType(book, 2);
        List<Category> rootCategories = categories.stream().filter(i->i.getLevel() == 0).collect(Collectors.toList());
        List<CategoryRelation> incomeFroms = categoryRelationRepository.findByBookAndCreateTimeBetween(book, start, end);
        rootCategories.forEach(i -> {
            ChartVO vo = new ChartVO();
            vo.setX(i.getName());
            List<Integer> offSpringCategoryIds = i.getOffspring(categories).stream().map(BaseEntity::getId).collect(Collectors.toList());
            offSpringCategoryIds.add(i.getId());
            vo.setY(incomeFroms.stream().filter(j -> offSpringCategoryIds.contains(j.getCategory().getId())).map(CategoryRelation::getConvertedAmount).reduce(BigDecimal.ZERO, BigDecimal::add));
            if (vo.getY().compareTo(BigDecimal.ZERO) > 0) {
                result.add(vo);
            }
        });
        return result;
    }

}
