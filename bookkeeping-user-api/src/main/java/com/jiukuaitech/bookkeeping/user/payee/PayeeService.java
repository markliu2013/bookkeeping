package com.jiukuaitech.bookkeeping.user.payee;

import com.jiukuaitech.bookkeeping.user.book.Book;
import com.jiukuaitech.bookkeeping.user.deal.DealRepository;
import com.jiukuaitech.bookkeeping.user.exception.ItemNotFoundException;
import com.jiukuaitech.bookkeeping.user.exception.NameExistsException;
import com.jiukuaitech.bookkeeping.user.user.User;
import com.jiukuaitech.bookkeeping.user.user.UserService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class PayeeService {

    @Resource
    private UserService userService;

    @Resource
    private PayeeRepository payeeRepository;

    @Resource
    private DealRepository dealRepository;

    public Page<PayeeVOForList> query(PayeeQueryRequest request, Pageable page, Integer userSignInId) {
        Book book = userService.getUser(userSignInId).getDefaultBook();
        Specification<Payee> specification = PayeeSpec.buildSpecification(request, book);
        Page<Payee> poPage = payeeRepository.findAll(specification, page);
        return poPage.map(PayeeVOForList::fromEntity);
    }

    public PayeeVOForList get(Integer id, Integer userSignInId) {
        Book book = userService.getUser(userSignInId).getDefaultBook();
        Payee po = payeeRepository.findOneByBookAndId(book, id).orElseThrow(ItemNotFoundException::new);
        return PayeeVOForList.fromEntity(po);
    }

    public List<PayeeVOForList> getEnable(Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        List<Payee> entityList = payeeRepository.findByBookAndEnable(user.getDefaultBook(), true);
        return entityList.stream().map(PayeeVOForList::fromEntity).collect(Collectors.toList());
    }

    public List<PayeeVOForList> getExpenseable(Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        List<Payee> entityList = payeeRepository.findByBookAndEnableAndExpenseable(user.getDefaultBook(), true, true);
        return entityList.stream().map(PayeeVOForList::fromEntity).collect(Collectors.toList());
    }

    public List<PayeeVOForList> getIncomeable(Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        List<Payee> entityList = payeeRepository.findByBookAndEnableAndIncomeable(user.getDefaultBook(), true, true);
        return entityList.stream().map(PayeeVOForList::fromEntity).collect(Collectors.toList());
    }

    public PayeeVOForList add(PayeeAddRequest request, Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        Book book = user.getDefaultBook();
        // 不能重复
        if (payeeRepository.findByBookAndName(book, request.getName()).isPresent()) {
            throw new NameExistsException();
        }
        Payee po = new Payee();
        po.setName(request.getName());
        po.setNotes(request.getNotes());
        po.setExpenseable(request.getExpenseable());
        po.setIncomeable(request.getIncomeable());
        po.setBook(book);
        return PayeeVOForList.fromEntity(payeeRepository.save(po));
    }

    public PayeeVOForList remove(Integer id, Integer userSignInId) {
        Book book = userService.getUser(userSignInId).getDefaultBook();
        Payee po = payeeRepository.findOneByBookAndId(book, id).orElseThrow(ItemNotFoundException::new);
        if (dealRepository.countByPayee_id(id) > 0) throw new PayeeHasDealException();
        payeeRepository.delete(po);
        return PayeeVOForList.fromEntity(po);
    }

    public PayeeVOForList update(Integer id, PayeeUpdateRequest request, Integer userSignInId) {
        Book book = userService.getUser(userSignInId).getDefaultBook();
        Payee po = payeeRepository.findOneByBookAndId(book, id).orElseThrow(ItemNotFoundException::new);
        if (!po.getName().equals(request.getName())) {
            if (payeeRepository.findByBookAndName(po.getBook(), request.getName()).isPresent()) {
                throw new NameExistsException();
            }
        }
        if (request.getName() != null) po.setName(request.getName());
        if (request.getNotes() != null) po.setNotes(request.getNotes());
        if (request.getExpenseable() != null) po.setExpenseable(request.getExpenseable());
        if (request.getIncomeable() != null) po.setIncomeable(request.getIncomeable());
        return PayeeVOForList.fromEntity(payeeRepository.save(po));
    }

    public PayeeVOForList toggle(Integer id, Integer userSignInId) {
        Book book = userService.getUser(userSignInId).getDefaultBook();
        Payee po = payeeRepository.findOneByBookAndId(book, id).orElseThrow(ItemNotFoundException::new);
        po.setEnable(!po.getEnable());
        return PayeeVOForList.fromEntity(payeeRepository.save(po));
    }

}