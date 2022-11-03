package com.jiukuaitech.bookkeeping.user.item;

import com.jiukuaitech.bookkeeping.user.exception.ItemNotFoundException;
import com.jiukuaitech.bookkeeping.user.exception.NameExistsException;
import com.jiukuaitech.bookkeeping.user.user.User;
import com.jiukuaitech.bookkeeping.user.user.UserService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.Calendar;

@Service
public class ItemService {

    @Resource
    private ItemRepository itemRepository;

    @Resource
    private UserService userService;

    public boolean add(ItemAddRequest request, Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        if (itemRepository.findOneByUserAndTitle(user, request.getTitle()).isPresent()) {
            throw new NameExistsException();
        }
        Item po = new Item();
        po.setUser(user);
        po.setTitle(request.getTitle());
        po.setNotes(request.getNotes());
        po.setStartDate(request.getStartDate());
        po.setNextDate(request.getStartDate());
        po.setRunCount(0);
        if (request.getType() == 1) {
            po.setRepeatType(0);
            po.setTotalCount(1);
            po.setEndDate(request.getStartDate());
        } else {
            po.setRepeatType(request.getRepeatType());
            po.setEndDate(request.getEndDate());
            po.setInterval(request.getInterval());
            //计算总执行次数
            LocalDate startDate = Instant.ofEpochMilli(po.getStartDate()).atZone(ZoneId.systemDefault()).toLocalDate();
            LocalDate endDate = Instant.ofEpochMilli(po.getEndDate()).atZone(ZoneId.systemDefault()).toLocalDate();
            int totalCount = 0;
            switch (request.getRepeatType()) {
                case 1:
                    Long days = ChronoUnit.DAYS.between(
                            LocalDate.of(startDate.getYear(), startDate.getMonth(), startDate.getDayOfMonth()),
                            LocalDate.of(endDate.getYear(), endDate.getMonth(), endDate.getDayOfMonth())
                    );
                    totalCount = (int)(days / po.getInterval());
                    break;
                case 2:
                    Long months = ChronoUnit.MONTHS.between(
                            LocalDate.of(startDate.getYear(), startDate.getMonth(), startDate.getDayOfMonth()),
                            LocalDate.of(endDate.getYear(), endDate.getMonth(), endDate.getDayOfMonth())
                    );
                    totalCount = (int)(months / po.getInterval());
                    break;
                case 3:
                    Long years = ChronoUnit.YEARS.between(
                            LocalDate.of(startDate.getYear(), startDate.getMonth(), startDate.getDayOfMonth()),
                            LocalDate.of(endDate.getYear(), endDate.getMonth(), endDate.getDayOfMonth())
                    );
                    totalCount = (int)(years / po.getInterval());
                    break;
            }
            po.setTotalCount(totalCount + 1);
            po.setRunCount(0);
        }
        itemRepository.save(po);
        return true;
    }

    public boolean run(Integer id, Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        Item po = itemRepository.findOneByUserAndId(user, id).orElseThrow(ItemNotFoundException::new);
        if (po.getRunCount() >= po.getTotalCount()) {
            throw new ItemCountException();
        }
        Calendar nextDate = Calendar.getInstance();
        nextDate.setTimeInMillis(po.getNextDate());
        switch (po.getRepeatType()) {
            case 1:
                nextDate.add(Calendar.DATE, po.getInterval());
                break;
            case 2:
                nextDate.add(Calendar.MONTH, po.getInterval());
                break;
            case 3:
                nextDate.add(Calendar.YEAR, po.getInterval());
                break;
        }
        po.setNextDate(nextDate.getTimeInMillis());
        po.setRunCount(po.getRunCount() + 1);
        itemRepository.save(po);
        return true;
    }

    public boolean recall(Integer id, Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        Item po = itemRepository.findOneByUserAndId(user, id).orElseThrow(ItemNotFoundException::new);
        if (po.getRunCount() <= 0) {
            throw new ItemCountException();
        }
        Calendar nextDate = Calendar.getInstance();
        nextDate.setTimeInMillis(po.getNextDate());
        switch (po.getRepeatType()) {
            case 1:
                nextDate.add(Calendar.DATE, po.getInterval()*(-1));
                break;
            case 2:
                nextDate.add(Calendar.MONTH, po.getInterval()*(-1));
                break;
            case 3:
                nextDate.add(Calendar.YEAR, po.getInterval()*(-1));
                break;
        }
        po.setNextDate(nextDate.getTimeInMillis());
        po.setRunCount(po.getRunCount() - 1);
        itemRepository.save(po);
        return true;
    }

    public boolean remove(Integer id, Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        Item po = itemRepository.findOneByUserAndId(user, id).orElseThrow(ItemNotFoundException::new);
        itemRepository.delete(po);
        return true;
    }

    public boolean update(Integer id, ItemUpdateRequest request, Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        Item po = itemRepository.findOneByUserAndId(user, id).orElseThrow(ItemNotFoundException::new);
        if (StringUtils.hasText(request.getTitle())) {
            if (!po.getTitle().equals(request.getTitle())) {
                if (itemRepository.findOneByUserAndTitle(user, request.getTitle()).isPresent()) {
                    throw new NameExistsException();
                }
            }
        }
        if (request.getNotes() != null) po.setNotes(request.getNotes());
        if (request.getEndDate() != null) po.setEndDate(request.getEndDate());
        //计算总执行次数
        LocalDate startDate = Instant.ofEpochMilli(po.getStartDate()).atZone(ZoneId.systemDefault()).toLocalDate();
        LocalDate endDate = Instant.ofEpochMilli(po.getEndDate()).atZone(ZoneId.systemDefault()).toLocalDate();
        switch (po.getRepeatType()) {
            case 1:
                Long days = ChronoUnit.DAYS.between(
                        LocalDate.of(startDate.getYear(), startDate.getMonth(), startDate.getDayOfMonth()),
                        LocalDate.of(endDate.getYear(), endDate.getMonth(), endDate.getDayOfMonth())
                );
                po.setTotalCount((int)(days / po.getInterval()));
                break;
            case 2:
                Long months = ChronoUnit.MONTHS.between(
                        LocalDate.of(startDate.getYear(), startDate.getMonth(), startDate.getDayOfMonth()),
                        LocalDate.of(endDate.getYear(), endDate.getMonth(), endDate.getDayOfMonth())
                );
                po.setTotalCount((int)(months / po.getInterval()));
                break;
            case 3:
                Long years = ChronoUnit.YEARS.between(
                        LocalDate.of(startDate.getYear(), startDate.getMonth(), startDate.getDayOfMonth()),
                        LocalDate.of(endDate.getYear(), endDate.getMonth(), endDate.getDayOfMonth())
                );
                po.setTotalCount((int)(years / po.getInterval()));
                break;
        }
        itemRepository.save(po);
        return true;
    }

    public Page<ItemVOForList> query(ItemQueryRequest request, Pageable page, Integer userSignInId) {
        Specification<Item> specification = ItemSpec.buildSpecification(request, userService.getUser(userSignInId));
        Page<Item> poPage = itemRepository.findAll(specification, page);
        return poPage.map(ItemVOForList::fromEntity);
    }

}
