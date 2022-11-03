package com.jiukuaitech.bookkeeping.user.reports;

import com.jiukuaitech.bookkeeping.user.account.Account;
import com.jiukuaitech.bookkeeping.user.asset_account.AssetAccountRepository;
import com.jiukuaitech.bookkeeping.user.balance_flow.BalanceFlowQueryRequest;
import com.jiukuaitech.bookkeeping.user.book.Book;
import com.jiukuaitech.bookkeeping.user.category.Category;
import com.jiukuaitech.bookkeeping.user.category.CategoryRepository;
import com.jiukuaitech.bookkeeping.user.category_relation.CategoryRelation;
import com.jiukuaitech.bookkeeping.user.checking_account.CheckingAccountRepository;
import com.jiukuaitech.bookkeeping.user.credit_account.CreditAccountRepository;
import com.jiukuaitech.bookkeeping.user.debt_account.DebtAccountRepository;
import com.jiukuaitech.bookkeeping.user.expense.Expense;
import com.jiukuaitech.bookkeeping.user.expense.ExpenseRepository;
import com.jiukuaitech.bookkeeping.user.expense.Expense_;
import com.jiukuaitech.bookkeeping.user.group.Group;
import com.jiukuaitech.bookkeeping.user.income.Income;
import com.jiukuaitech.bookkeeping.user.income.IncomeRepository;
import com.jiukuaitech.bookkeeping.user.income.Income_;
import com.jiukuaitech.bookkeeping.user.tag.Tag;
import com.jiukuaitech.bookkeeping.user.tag.TagRepository;
import com.jiukuaitech.bookkeeping.user.tag_relation.TagRelation;
import com.jiukuaitech.bookkeeping.user.user.User;
import com.jiukuaitech.bookkeeping.user.user.UserService;
import com.jiukuaitech.bookkeeping.user.account.AccountSpec;
import com.jiukuaitech.bookkeeping.user.balance_flow.BalanceFlowSpec;
import com.jiukuaitech.bookkeeping.user.balance_log.BalanceLog;
import com.jiukuaitech.bookkeeping.user.balance_log.BalanceLogRepository;
import com.jiukuaitech.bookkeeping.user.currency.CurrencyService;
import com.jiukuaitech.bookkeeping.user.deal.DealSpec;
import com.jiukuaitech.bookkeeping.user.utils.CalendarUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import javax.annotation.Resource;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class ReportService {

    @Resource
    private UserService userService;

    @Resource
    private ExpenseRepository expenseRepository;

    @Resource
    private IncomeRepository incomeRepository;

    @Resource
    private TagRepository tagRepository;

    @Resource
    private CheckingAccountRepository checkingAccountRepository;

    @Resource
    private CreditAccountRepository creditAccountRepository;

    @Resource
    private DebtAccountRepository debtAccountRepository;

    @Resource
    private AssetAccountRepository assetAccountRepository;

    @Resource
    private BalanceLogRepository balanceLogRepository;

    @Resource
    private CategoryRepository categoryRepository;

    @Resource
    private CurrencyService currencyService;

    @Resource
    private MessageSource messageSource;

    @Value("${trend.time.max.break}")
    private Integer maxBreak;

    public List<ChartVO> reportExpenseCategory(BalanceFlowQueryRequest request, Integer userSignInId) {
        List<ChartVO> result = new ArrayList<>();
        User user = userService.getUser(userSignInId);
        Group group = user.getDefaultGroup();
        Book book = user.getDefaultBook();
        List<Category> categories = categoryRepository.findAllByBookAndType(book, 1);
        Category requestCategory = null;
        List<Category> rootCategories;
        if (request.getCategoryId() == null) {
            rootCategories = categories.stream().filter(i->i.getLevel() == 0).collect(Collectors.toList());
        } else {
            requestCategory = categories.stream().filter(i-> i.getId().equals(request.getCategoryId())).collect(Collectors.toList()).get(0);
            rootCategories = requestCategory.getOffspring(categories);
        }
        request.setBookId(book.getId());
        Specification<Expense> specification = DealSpec.buildSpecification(request, group);
        // 不统计待确认的状态
        specification = specification.and(BalanceFlowSpec.statusConfirmed());
        List<Expense> expenses = expenseRepository.findAll(specification);
        List<CategoryRelation> expenseTos = new ArrayList<>();
        expenses.forEach(i -> expenseTos.addAll(i.getCategories()));
        rootCategories.forEach(i -> {
            ChartVO vo = new ChartVO();
            vo.setX(i.getName());
            List<Integer> offSpringCategoryIds = i.getOffspring(categories).stream().map(j->j.getId()).collect(Collectors.toList());
            offSpringCategoryIds.add(i.getId());
            vo.setY(expenseTos.stream().filter(j -> offSpringCategoryIds.contains(j.getCategory().getId())).map(CategoryRelation::getConvertedAmount).reduce(BigDecimal.ZERO, BigDecimal::add));
            if (vo.getY().compareTo(BigDecimal.ZERO) > 0) {
                result.add(vo);
            }
        });
        if (request.getCategoryId() != null) {
            ChartVO vo = new ChartVO();
            if (rootCategories.size() > 0) {
                vo.setX(messageSource.getMessage("categoryOther", null, Locale.CHINA));
            } else { //只有一个分类，不用其他名字
                vo.setX(requestCategory.getName());
            }
            vo.setY(expenseTos.stream().filter(i -> i.getCategory().getId().equals(request.getCategoryId())).map(CategoryRelation::getConvertedAmount).reduce(BigDecimal.ZERO, BigDecimal::add));
            if (vo.getY().signum() > 0) {
                result.add(vo);
            }
        }
        result.sort(Comparator.comparing(ChartVO::getY).reversed());
        BigDecimal total = result.stream().map(ChartVO::getY).reduce(BigDecimal.ZERO, BigDecimal::add);
        result.forEach(vo -> vo.setPercent(vo.getY().multiply(new BigDecimal(100)).divide(total, 2, RoundingMode.HALF_UP)));
        return result;
    }

    public List<ChartVO> reportExpenseTag(BalanceFlowQueryRequest request, Integer userSignInId) {
        List<ChartVO> result = new ArrayList<>();
        User user = userService.getUser(userSignInId);
        Group group = user.getDefaultGroup();
        Book book = user.getDefaultBook();
        List<Tag> tags = tagRepository.findByBookAndEnableAndExpenseable(book, true, true);
        List<Tag> rootTags = new ArrayList<>();
        List<Integer> requestTags = new ArrayList<>();
        Tag requestTag = null;
        if (CollectionUtils.isEmpty(request.getTags())) {
            rootTags = tags.stream().filter(i->i.getLevel() == 0).collect(Collectors.toList());
        } else {
            requestTags.addAll(request.getTags());
            if (requestTags.size() == 1) {
                requestTag = tags.stream().filter(i-> i.getId().equals(requestTags.iterator().next())).collect(Collectors.toList()).get(0);
                rootTags = requestTag.getOffspring(tags);
                request.getTags().addAll(rootTags.stream().map(j->j.getId()).collect(Collectors.toList()));
            } else {
//                for (Integer id : request.getTags()) {
//                    rootTags.add(tagRepository.findById(id).orElseThrow(ItemNotFoundException::new));
//                }
                for (Integer i : requestTags) {
                    Tag tag = tags.stream().filter(j -> j.getId().equals(i)).collect(Collectors.toList()).get(0);
                    rootTags.add(tag);
                    request.getTags().addAll(tag.getOffspring(tags).stream().map(j->j.getId()).collect(Collectors.toList()));
                }
            }
        }
        request.setBookId(book.getId());
        Specification<Expense> specification = DealSpec.buildSpecification(request, group);
        // 不统计待确认的状态
        specification = specification.and(BalanceFlowSpec.statusConfirmed());
        List<Expense> expenses = expenseRepository.findAll(specification);
        List<TagRelation> tagRelations = new ArrayList<>();
        expenses.forEach(i->tagRelations.addAll(i.getTags()));
        rootTags.forEach(i -> {
            ChartVO vo = new ChartVO();
            vo.setX(i.getName());
            List<Integer> offSpringIds = i.getOffspring(tags).stream().map(j->j.getId()).collect(Collectors.toList());
            offSpringIds.add(i.getId());
            vo.setY(tagRelations.stream().filter(j -> offSpringIds.contains(j.getTag().getId())).map(TagRelation::getConvertedAmount).reduce(BigDecimal.ZERO, BigDecimal::add));
            result.add(vo);
        });
        if (!CollectionUtils.isEmpty(requestTags) && requestTags.size() == 1) {
            ChartVO vo = new ChartVO();
            if (rootTags.size() > 0) {
                vo.setX(messageSource.getMessage("categoryOther", null, Locale.CHINA));
            } else { //只有一个分类，不用其他名字
                vo.setX(requestTag.getName());
            }
            Tag finalRequestTag = requestTag;
            vo.setY(tagRelations.stream().filter(i -> i.getTag().getId().equals(finalRequestTag.getId())).map(TagRelation::getConvertedAmount).reduce(BigDecimal.ZERO, BigDecimal::add));
            if (vo.getY().signum() > 0) {
                result.add(vo);
            }
        }
        return result;
    }

    public List<ChartVO> reportIncomeCategory(BalanceFlowQueryRequest request, Integer userSignInId) {
        List<ChartVO> result = new ArrayList<>();
        User user = userService.getUser(userSignInId);
        Group group = user.getDefaultGroup();
        Book book = user.getDefaultBook();
        List<Category> categories = categoryRepository.findAllByBookAndType(book, 2);
        Category requestCategory = null;
        List<Category> rootCategories;
        if (request.getCategoryId() == null) {
            rootCategories = categories.stream().filter(i->i.getLevel() == 0).collect(Collectors.toList());
        } else {
            requestCategory = categories.stream().filter(i-> i.getId().equals(request.getCategoryId())).collect(Collectors.toList()).get(0);
            rootCategories = requestCategory.getOffspring(categories);
        }
        request.setBookId(book.getId());
        Specification<Income> specification = DealSpec.buildSpecification(request, group);
        // 不统计待确认的状态
        specification = specification.and(BalanceFlowSpec.statusConfirmed());
        List<Income> incomes = incomeRepository.findAll(specification);
        List<CategoryRelation> incomeFroms = new ArrayList<>();
        incomes.forEach(i -> incomeFroms.addAll(i.getCategories()));
        rootCategories.forEach(i -> {
            ChartVO vo = new ChartVO();
            vo.setX(i.getName());
            List<Integer> offSpringCategoryIds = i.getOffspring(categories).stream().map(j->j.getId()).collect(Collectors.toList());
            offSpringCategoryIds.add(i.getId());
            vo.setY(incomeFroms.stream().filter(j -> offSpringCategoryIds.contains(j.getCategory().getId())).map(CategoryRelation::getConvertedAmount).reduce(BigDecimal.ZERO, BigDecimal::add));
            if (vo.getY().compareTo(BigDecimal.ZERO) > 0) {
                result.add(vo);
            }
        });
        if (request.getCategoryId() != null) {
            ChartVO vo = new ChartVO();
            if (result.size() > 0) {
                vo.setX(messageSource.getMessage("categoryOther", null, Locale.CHINA));
            } else { //只有一个分类，不用其他名字
                vo.setX(requestCategory.getName());
            }
            vo.setY(incomeFroms.stream().filter(i -> i.getCategory().getId().equals(request.getCategoryId())).map(CategoryRelation::getConvertedAmount).reduce(BigDecimal.ZERO, BigDecimal::add));
            if (vo.getY().compareTo(BigDecimal.valueOf(0)) > 0) {
                result.add(vo);
            }
        }
        result.sort(Comparator.comparing(ChartVO::getY).reversed());
        BigDecimal total = result.stream().map(ChartVO::getY).reduce(BigDecimal.ZERO, BigDecimal::add);
        result.forEach(vo -> vo.setPercent(vo.getY().multiply(new BigDecimal(100)).divide(total, 2, RoundingMode.HALF_UP)));
        return result;
    }

    public List<ChartVO> reportIncomeTag(BalanceFlowQueryRequest request, Integer userSignInId) {
        List<ChartVO> result = new ArrayList<>();
        User user = userService.getUser(userSignInId);
        Group group = user.getDefaultGroup();
        Book book = user.getDefaultBook();
        List<Tag> tags = tagRepository.findByBookAndEnableAndIncomeable(book, true, true);
        List<Tag> rootTags = new ArrayList<>();
        List<Integer> requestTags = new ArrayList<>();
        Tag requestTag = null;
        if (CollectionUtils.isEmpty(request.getTags())) {
            rootTags = tags.stream().filter(i->i.getLevel() == 0).collect(Collectors.toList());
        } else {
            requestTags.addAll(request.getTags());
            if (requestTags.size() == 1) {
                requestTag = tags.stream().filter(i-> i.getId().equals(requestTags.iterator().next())).collect(Collectors.toList()).get(0);
                rootTags = requestTag.getOffspring(tags);
                request.getTags().addAll(rootTags.stream().map(j->j.getId()).collect(Collectors.toList()));
            } else {
                for (Integer i : requestTags) {
                    Tag tag = tags.stream().filter(j -> j.getId().equals(i)).collect(Collectors.toList()).get(0);
                    rootTags.add(tag);
                    request.getTags().addAll(tag.getOffspring(tags).stream().map(j->j.getId()).collect(Collectors.toList()));
                }
            }
        }
        request.setBookId(book.getId());
        Specification<Income> specification = DealSpec.buildSpecification(request, group);
        // 不统计待确认的状态
        specification = specification.and(BalanceFlowSpec.statusConfirmed());
        List<Income> incomes = incomeRepository.findAll(specification);
        List<TagRelation> tagRelations = new ArrayList<>();
        incomes.forEach(i->tagRelations.addAll(i.getTags()));
        rootTags.forEach(i -> {
            ChartVO vo = new ChartVO();
            vo.setX(i.getName());
            List<Integer> offSpringIds = i.getOffspring(tags).stream().map(j->j.getId()).collect(Collectors.toList());
            offSpringIds.add(i.getId());
            vo.setY(tagRelations.stream().filter(j -> offSpringIds.contains(j.getTag().getId())).map(TagRelation::getConvertedAmount).reduce(BigDecimal.ZERO, BigDecimal::add));
            result.add(vo);
        });
        if (!CollectionUtils.isEmpty(requestTags) && requestTags.size() == 1) {
            ChartVO vo = new ChartVO();
            if (rootTags.size() > 0) {
                vo.setX(messageSource.getMessage("categoryOther", null, Locale.CHINA));
            } else { //只有一个分类，不用其他名字
                vo.setX(requestTag.getName());
            }
            Tag finalRequestTag = requestTag;
            vo.setY(tagRelations.stream().filter(i -> i.getTag().getId().equals(finalRequestTag.getId())).map(TagRelation::getConvertedAmount).reduce(BigDecimal.ZERO, BigDecimal::add));
            if (vo.getY().signum() > 0) {
                result.add(vo);
            }
        }
        return result;
    }

    private String breakTypeToKey(String type, Calendar calendar) {
        switch (type) {
            case "day":
                return new SimpleDateFormat("yy/MM/dd").format(calendar.getTime());
            case "week":
                // TODO 国际化 美国的周日是第一天
                calendar.setFirstDayOfWeek(Calendar.MONDAY);
                return calendar.get(Calendar.YEAR) + "W" + calendar.get(Calendar.WEEK_OF_YEAR);
            case "month":
                return new SimpleDateFormat("yy/MM").format(calendar.getTime());
            case "quarter":
                return calendar.get(Calendar.YEAR) + "Q" + ((calendar.get(Calendar.MONTH) / 3) + 1);
            case "year":
                return String.valueOf(calendar.get(Calendar.YEAR));
            default:
                return "";
        }
    }

    public List<ChartVO2> reportExpenseIncomeTrend(ExpenseIncomeTrendQueryRequest request, Integer userSignInId) {
        List<ChartVO2> result = new ArrayList<>();
        User user = userService.getUser(userSignInId);
        Group group = user.getDefaultGroup();
        Book book = user.getDefaultBook();
        if (request.getMinTime() == null) {
            request.setMinTime(CalendarUtils.getIn1Year()[0]);
        }
        List<Calendar[]> breaks = CalendarUtils.getBreaks(request.getMinTime(), request.getMaxTime(), request.getBreakType());
        if (breaks.size() > maxBreak) throw new BreakOutOfMaxException();
        List<ChartVO> expenseMap = new ArrayList<>();
        BalanceFlowQueryRequest expenseQueryRequest = new BalanceFlowQueryRequest();
        expenseQueryRequest.setAccounts(request.getExpenseAccounts());
        expenseQueryRequest.setPayees(request.getExpensePayees());
        expenseQueryRequest.setCategories(request.getExpenseCategories());
        expenseQueryRequest.setTags(request.getExpenseTags());
        expenseQueryRequest.setBookId(book.getId());
        breaks.forEach(i -> {
            expenseQueryRequest.setMinTime(i[0].getTimeInMillis());
            expenseQueryRequest.setMaxTime(i[1].getTimeInMillis());
            Specification<Expense> specification = DealSpec.buildSpecification(expenseQueryRequest, group);
            // 不统计待确认的状态
            specification = specification.and(BalanceFlowSpec.statusConfirmed());
            BigDecimal amount = expenseRepository.calcAggregate(specification, Expense_.convertedAmount, Expense.class);
            ChartVO vo = new ChartVO(breakTypeToKey(request.getBreakType(), i[0]), amount);
            expenseMap.add(vo);
        });
        List<ChartVO> incomeMap = new ArrayList<>();
        BalanceFlowQueryRequest incomeQueryRequest = new BalanceFlowQueryRequest();
        incomeQueryRequest.setAccounts(request.getIncomeAccounts());
        incomeQueryRequest.setPayees(request.getIncomePayees());
        incomeQueryRequest.setCategories(request.getIncomeCategories());
        incomeQueryRequest.setTags(request.getIncomeTags());
        incomeQueryRequest.setBookId(book.getId());
        breaks.forEach(i -> {
            incomeQueryRequest.setMinTime(i[0].getTimeInMillis());
            incomeQueryRequest.setMaxTime(i[1].getTimeInMillis());
            Specification<Income> specification = DealSpec.buildSpecification(incomeQueryRequest, group);
            // 不统计待确认的状态
            specification = specification.and(BalanceFlowSpec.statusConfirmed());
            BigDecimal amount = incomeRepository.calcAggregate(specification, Income_.convertedAmount, Income.class);
            ChartVO vo = new ChartVO(breakTypeToKey(request.getBreakType(), i[0]), amount);
            incomeMap.add(vo);
        });
        for (int i = 0; i < breaks.size(); i++) {
            ChartVO2 vo1 = new ChartVO2();
            vo1.setX1(expenseMap.get(i).getX());
            vo1.setX2(messageSource.getMessage("expense", null, Locale.CHINA));
            vo1.setY(expenseMap.get(i).getY());
            result.add(vo1);

            ChartVO2 vo2 = new ChartVO2();
            vo2.setX1(incomeMap.get(i).getX());
            vo2.setX2(messageSource.getMessage("income", null, Locale.CHINA));
            vo2.setY(incomeMap.get(i).getY());
            result.add(vo2);

            ChartVO2 vo3 = new ChartVO2();
            vo3.setX1(incomeMap.get(i).getX());
            vo3.setX2(messageSource.getMessage("remain", null, Locale.CHINA));
            vo3.setY(incomeMap.get(i).getY().subtract(expenseMap.get(i).getY()));
            result.add(vo3);
        }
        return result;
    }

    public List<ChartVO> reportAsset(Integer userSignInId) {
        List<ChartVO> result = new ArrayList<>();
        Group group = userService.getUser(userSignInId).getDefaultGroup();
        List<Account> accounts = new ArrayList<>();
        accounts.addAll(checkingAccountRepository.findAll(AccountSpec.inGroupAndInclude(group)));
        accounts.addAll(assetAccountRepository.findAll(AccountSpec.inGroupAndInclude(group)));
        accounts.forEach(i -> {
            if (i.getBalance().compareTo(BigDecimal.ZERO) > 0) {
                ChartVO vo = new ChartVO();
                vo.setX(i.getName());
                vo.setY(currencyService.convert(i.getBalance(), i.getCurrencyCode(), group.getDefaultCurrencyCode()));
                result.add(vo);
            }
        });
        result.sort(Comparator.comparing(ChartVO::getY).reversed());
        BigDecimal total = result.stream().map(ChartVO::getY).reduce(BigDecimal.ZERO, BigDecimal::add);
        result.forEach(vo -> vo.setPercent(vo.getY().multiply(new BigDecimal(100)).divide(total, 2, RoundingMode.HALF_UP)));
        return result;
    }

    public List<ChartVO> reportDebt(Integer userSignInId) {
        List<ChartVO> result = new ArrayList<>();
        Group group = userService.getUser(userSignInId).getDefaultGroup();
        List<Account> accounts = new ArrayList<>();
        accounts.addAll(creditAccountRepository.findAll(AccountSpec.inGroupAndInclude(group)));
        accounts.addAll(debtAccountRepository.findAll(AccountSpec.inGroupAndInclude(group)));
        accounts.forEach(i -> {
            if (i.getBalance().compareTo(BigDecimal.ZERO) < 0) {
                ChartVO vo = new ChartVO();
                vo.setX(i.getName());
                vo.setY(currencyService.convert(i.getBalance(), i.getCurrencyCode(), group.getDefaultCurrencyCode()).negate());
                result.add(vo);
            }
        });
        result.sort(Comparator.comparing(ChartVO::getY).reversed());
        BigDecimal total = result.stream().map(ChartVO::getY).reduce(BigDecimal.ZERO, BigDecimal::add);
        result.forEach(vo -> vo.setPercent(vo.getY().multiply(new BigDecimal(100)).divide(total, 2, RoundingMode.HALF_UP)));
        return result;
    }

    public List<ChartVO2> reportAssetDebtTrend(TrendTimeQueryRequest request, Integer userSignInId) {
        List<ChartVO2> result = new ArrayList<>();
        Group group = userService.getUser(userSignInId).getDefaultGroup();
        if (request.getMinTime() == null) {
            request.setMinTime(CalendarUtils.getIn1Year()[0]);
        }
        List<BalanceLog> logs = balanceLogRepository.findByGroupAndCreateTimeBetweenOrderByCreateTime(group, request.getMinTime(), request.getMaxTime());
        List<ChartVO> assetMap = new ArrayList<>();
        List<ChartVO> debtMap = new ArrayList<>();
        logs.forEach(i -> {
            ChartVO vo1 = new ChartVO();
            vo1.setX(new SimpleDateFormat("yy/MM/dd").format(i.getCreateTime()));
            vo1.setY(i.getAsset());
            assetMap.add(vo1);

            ChartVO vo2 = new ChartVO();
            vo2.setX(new SimpleDateFormat("yy/MM/dd").format(i.getCreateTime()));
            vo2.setY(i.getDebt());
            debtMap.add(vo2);
        });

        for (int i = 0; i < logs.size(); i++) {
            ChartVO2 vo1 = new ChartVO2();
            vo1.setX1(assetMap.get(i).getX());
            vo1.setX2(messageSource.getMessage("asset", null, Locale.CHINA));
            vo1.setY(assetMap.get(i).getY());
            result.add(vo1);

            ChartVO2 vo2 = new ChartVO2();
            vo2.setX1(debtMap.get(i).getX());
            vo2.setX2(messageSource.getMessage("debt", null, Locale.CHINA));
            vo2.setY(debtMap.get(i).getY());
            result.add(vo2);

            ChartVO2 vo3 = new ChartVO2();
            vo3.setX1(assetMap.get(i).getX());
            vo3.setX2(messageSource.getMessage("netWorth", null, Locale.CHINA));
            vo3.setY(assetMap.get(i).getY().subtract(debtMap.get(i).getY()));
            result.add(vo3);
        }

        return result;
    }

}
