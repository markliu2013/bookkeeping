package com.jiukuaitech.bookkeeping.user.balance_flow;

import com.jiukuaitech.bookkeeping.user.book.Book;
import com.jiukuaitech.bookkeeping.user.expense.Expense;
import com.jiukuaitech.bookkeeping.user.flow_images.FlowImageRepository;
import com.jiukuaitech.bookkeeping.user.flow_images.FlowImageVOForList;
import com.jiukuaitech.bookkeeping.user.group.Group;
import com.jiukuaitech.bookkeeping.user.income.Income;
import com.jiukuaitech.bookkeeping.user.transfer.Transfer;
import com.jiukuaitech.bookkeeping.user.user.User;
import com.jiukuaitech.bookkeeping.user.user.UserService;
import com.jiukuaitech.bookkeeping.user.adjust_balance.AdjustBalanceService;
import com.jiukuaitech.bookkeeping.user.deal.DealService;
import com.jiukuaitech.bookkeeping.user.deal.DealSpec;
import com.jiukuaitech.bookkeeping.user.exception.ItemNotFoundException;
import com.jiukuaitech.bookkeeping.user.expense.Expense_;
import com.jiukuaitech.bookkeeping.user.flow_images.FlowImage;
import com.jiukuaitech.bookkeeping.user.income.Income_;
import com.jiukuaitech.bookkeeping.user.transfer.TransferService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class BalanceFlowService {

    @Resource
    private UserService userService;

    @Resource
    private BalanceFlowRepository balanceFlowRepository;

    @Resource
    private DealService dealService;

    @Resource
    private TransferService transferService;

    @Resource
    private AdjustBalanceService adjustBalanceService;

    @Resource
    private FlowImageRepository flowImageRepository;

    public BalanceFlowQueryResultVO queryWithDefaultBook(BalanceFlowQueryRequest request, Pageable page, Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        request.setBookId(user.getDefaultBook().getId());
        return query(request, page, userSignInId);
    }

    public BalanceFlowQueryResultVO query(BalanceFlowQueryRequest request, Pageable page, Integer userSignInId) {
        BalanceFlowQueryResultVO result = new BalanceFlowQueryResultVO();
        User user = userService.getUser(userSignInId);
        Group group = user.getDefaultGroup();
        String defaultCurrencyCode = group.getDefaultCurrencyCode();
        Specification<BalanceFlow> specification = BalanceFlowSpec.buildFlowSpecification(request, group);
        Page<BalanceFlow> poPage = balanceFlowRepository.findAll(specification, page);
        Page<BalanceFlowVOForList> voPage = poPage.map(flow-> {
            BalanceFlowVOForList vo = BalanceFlowVOForList.fromEntity(flow);
            vo.setCurrencyCode(flow.getAccount().getCurrencyCode());
            if (flow.getType() == 1 || flow.getType() == 2) {
                if (defaultCurrencyCode.equals(flow.getAccount().getCurrencyCode())) {
                    vo.setNeedConvert(false);
                } else {
                    vo.setNeedConvert(true);
                    vo.setToCurrencyCode(defaultCurrencyCode);
                }
            } else if (flow.getType() == 3) {
                String toCurrencyCode = ((Transfer) flow).getTo().getCurrencyCode();
                if (flow.getAccount().getCurrencyCode().equals(toCurrencyCode)) {
                    vo.setNeedConvert(false);
                } else {
                    vo.setNeedConvert(true);
                    vo.setToCurrencyCode(toCurrencyCode);
                }
            } else {
                vo.setNeedConvert(false);
            }
            return vo;
        });
        result.setResult(voPage);

        Specification<Expense> specification1 = DealSpec.buildSpecification(request, group);
        if (request.getType() == null || request.getType() == 1) { //只有支出类型才需要计算总额
            result.setExpense(balanceFlowRepository.calcAggregate(specification1, Expense_.convertedAmount, Expense.class));
        } else { //不是查询的支出类型，则支出总额肯定为空
            result.setExpense(BigDecimal.ZERO);
        }
        Specification<Income> specification2 = DealSpec.buildSpecification(request, group);
        if (request.getType() == null || request.getType() == 2) {
            result.setIncome(balanceFlowRepository.calcAggregate(specification2, Income_.convertedAmount, Income.class));
        } else {
            result.setIncome(BigDecimal.ZERO);
        }
        return result;
    }

    public BalanceFlowVOForList get(Integer id, Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        Book book = user.getDefaultBook();
        Group group = user.getDefaultGroup();
        String defaultCurrencyCode = group.getDefaultCurrencyCode();
        BalanceFlow flow = balanceFlowRepository.findOneByBookAndId(book, id).orElseThrow(ItemNotFoundException::new);
        BalanceFlowVOForList vo = BalanceFlowVOForList.fromEntity(flow);
        vo.setCurrencyCode(flow.getAccount().getCurrencyCode());
        if (flow.getType() == 1 || flow.getType() == 2) {
            if (defaultCurrencyCode.equals(flow.getAccount().getCurrencyCode())) {
                vo.setNeedConvert(false);
            } else {
                vo.setNeedConvert(true);
                vo.setToCurrencyCode(defaultCurrencyCode);
            }
        } else if (flow.getType() == 3) {
            String toCurrencyCode = ((Transfer) flow).getTo().getCurrencyCode();
            if (flow.getAccount().getCurrencyCode().equals(toCurrencyCode)) {
                vo.setNeedConvert(false);
            } else {
                vo.setNeedConvert(true);
                vo.setToCurrencyCode(toCurrencyCode);
            }
        } else {
            vo.setNeedConvert(false);
        }
        return vo;
    }

    public boolean remove(Integer id, Integer userSignInId) {
        Book book = userService.getUser(userSignInId).getDefaultBook();
        BalanceFlow flow = balanceFlowRepository.findOneByBookAndId(book, id).orElseThrow(ItemNotFoundException::new);
        switch (flow.getType()) {
            case 1:
                return dealService.remove(1, id, userSignInId);
            case 2:
                return dealService.remove(2, id, userSignInId);
            case 3:
                return transferService.remove(id, userSignInId);
            case 4:
                adjustBalanceService.remove(id, userSignInId);
                return true;
            default:
                throw new ItemNotFoundException();
        }
    }

    public boolean confirm(Integer id, Integer userSignInId) {
        Book book = userService.getUser(userSignInId).getDefaultBook();
        BalanceFlow flow = balanceFlowRepository.findOneByBookAndId(book, id).orElseThrow(ItemNotFoundException::new);
        switch (flow.getType()) {
            case 1:
                return dealService.confirm(1, id, userSignInId);
            case 2:
                return dealService.confirm(2, id, userSignInId);
            case 3:
                return transferService.confirm(id, userSignInId);
            default:
                throw new ItemNotFoundException();
        }
    }

    public boolean updateImages(Integer id, Set<Integer> images, Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        Book book = user.getDefaultBook();
        BalanceFlow po = balanceFlowRepository.findOneByBookAndId(book, id).orElseThrow(ItemNotFoundException::new);
        po.getImages().forEach(i -> {
            i.setFlow(null);
            flowImageRepository.save(i);
        });
        images.forEach(i -> {
            FlowImage image = flowImageRepository.getById(i);
            image.setFlow(po); //必须加上这个才能关联上
            po.getImages().add(image);
        });
        balanceFlowRepository.save(po);
        return true;
    }

    public List<FlowImageVOForList> getImages(Integer id, Integer userSignInId) {
        Book book = userService.getUser(userSignInId).getDefaultBook();
        BalanceFlow po = balanceFlowRepository.findOneByBookAndId(book, id).orElseThrow(ItemNotFoundException::new);
        List<FlowImage> images = flowImageRepository.findByFlow(po);
        return images.stream().map(FlowImageVOForList::fromEntity).collect(Collectors.toList());
    }

    public boolean addImage(Integer id, Integer imageId, Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        Book book = user.getDefaultBook();
        BalanceFlow po = balanceFlowRepository.findOneByBookAndId(book, id).orElseThrow(ItemNotFoundException::new);
        FlowImage image = flowImageRepository.getById(imageId);
        image.setFlow(po);
        flowImageRepository.save(image);
        return true;
    }

}
