package com.jiukuaitech.bookkeeping.user.balance_flow;

import com.jiukuaitech.bookkeeping.user.adjust_balance.AdjustBalance;
import com.jiukuaitech.bookkeeping.user.category_relation.CategoryRelationVOForList;
import com.jiukuaitech.bookkeeping.user.deal.DealVOForList;
import com.jiukuaitech.bookkeeping.user.expense.Expense;
import com.jiukuaitech.bookkeeping.user.income.Income;
import com.jiukuaitech.bookkeeping.user.tag_relation.TagRelationVOForList;
import com.jiukuaitech.bookkeeping.user.transfer.Transfer;
import com.jiukuaitech.bookkeeping.user.utils.EnumUtils;
import com.jiukuaitech.bookkeeping.user.adjust_balance.AdjustBalanceVOForList;
import com.jiukuaitech.bookkeeping.user.response.HasNameVO;
import com.jiukuaitech.bookkeeping.user.transfer.TransferVOForList;
import lombok.Getter;
import lombok.Setter;
import org.springframework.util.StringUtils;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

@Getter
@Setter
public class BalanceFlowVOForList {

    private Integer id;
    private Integer type; // 1是expense，2是income，3是transfer，4是调整余额
    private DealVOForList expense;
    private DealVOForList income;
    private TransferVOForList transfer;
    private AdjustBalanceVOForList adjustBalance;

    private BigDecimal amount;
    private BigDecimal convertedAmount;
    private String currencyCode;
    private Boolean needConvert;
    private String toCurrencyCode;
    private Long createTime;
    private Integer status;
    private String description;

    private Integer accountId;
    private Integer toId;
    private String accountName;
    private String fromAccountName;
    private String toAccountName;
    private String categoryName;
    private Set<CategoryRelationVOForList> categories = new HashSet<>();
    private String bookName;
    private Set<TagRelationVOForList> tags = new HashSet<>();
    private HasNameVO payee;
    private String notes;

    public static BalanceFlowVOForList fromEntity(BalanceFlow po) {
        if (po == null) return null;
        BalanceFlowVOForList vo = new BalanceFlowVOForList();
        vo.setId(po.getId());
        vo.setBookName(po.getBook().getName());
        vo.setType(po.getType());
        vo.setStatus(po.getStatus());
        vo.setDescription(po.getDescription());
        vo.setAmount(po.getAmount());
        vo.setConvertedAmount(po.getConvertedAmount());
        vo.setCreateTime(po.getCreateTime());
        vo.setNotes(po.getNotes());
        if (po instanceof Expense) {
            vo.setExpense(DealVOForList.fromEntity((Expense) po));
            vo.setAccountId(vo.getExpense().getAccount().getId());
            vo.setAccountName(vo.getExpense().getAccountName());
            vo.setCategoryName(vo.getExpense().getCategoryName());
            vo.setCategories(vo.getExpense().getCategories());
            vo.setTags(vo.getExpense().getTags());
            vo.setPayee(vo.getExpense().getPayee());
        } else if (po instanceof Income) {
            vo.setIncome(DealVOForList.fromEntity((Income) po));
            vo.setAccountId(vo.getIncome().getAccount().getId());
            vo.setAccountName(vo.getIncome().getAccountName());
            vo.setCategoryName(vo.getIncome().getCategoryName());
            vo.setCategories(vo.getIncome().getCategories());
            vo.setTags(vo.getIncome().getTags());
            vo.setPayee(vo.getIncome().getPayee());
        } else if (po instanceof Transfer) {
            vo.setTransfer(TransferVOForList.fromEntity((Transfer) po));
            vo.setAccountId(vo.getTransfer().getFromId());
            vo.setToId(vo.getTransfer().getToId());
            vo.setAccountName(vo.getTransfer().getAccountName());
            vo.setFromAccountName(vo.getTransfer().getFrom().getName());
            vo.setToAccountName(vo.getTransfer().getTo().getName());
            vo.setTags(vo.getTransfer().getTags());
        } else if (po instanceof AdjustBalance) {
            vo.setAdjustBalance(AdjustBalanceVOForList.fromEntity((AdjustBalance) po));
            vo.setAccountName(vo.getAdjustBalance().getAccountName());
        }
        return vo;
    }

    public String getCreateTimeFormatted() {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        return simpleDateFormat.format(new Date(createTime));
    }

    private String getCreateDateFormatted() {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        return simpleDateFormat.format(new Date(createTime));
    }

    public String getAmountFormatted() {
        return String.format("%.2f", amount);
    }

    public String getTitle() {
        StringBuilder result = new StringBuilder();
        if (StringUtils.hasText(description)) {
            result.append(description);
        } else {
            if (type == 1) {
                result.append(expense.getCategories().stream().map(CategoryRelationVOForList::getCategoryName).collect(Collectors.joining(", ")));
            } else if (type == 2) {
                result.append(income.getCategories().stream().map(CategoryRelationVOForList::getCategoryName).collect(Collectors.joining(", ")));
            } else if (type == 3) {
                result.append(accountName);
            } else {
                result.append("调整余额");
            }
        }
        if (getPayee() != null) {
            result.append(" - ").append(getPayee().getName());
        }
        return result.toString();
    }

    public String getSubTitle() {
        return getTypeName() + " " + getCreateDateFormatted() + " " + getTagsName();
    }

    public String getTagsName() {
        if (type == 1) {
            return expense.getTags().stream().map(TagRelationVOForList::getTagName).collect(Collectors.joining(", "));
        }
        if (type == 2) {
            return income.getTags().stream().map(TagRelationVOForList::getTagName).collect(Collectors.joining(", "));
        }
        if (type == 3) {
            return transfer.getTags().stream().map(TagRelationVOForList::getTagName).collect(Collectors.joining(", "));
        }
        return "";
    }

    public String getTypeName() {
        return EnumUtils.translateFlowType(type);
    }

    public String getStatusName() {
        return EnumUtils.translateFlowStatus(status);
    }

}
