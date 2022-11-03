package com.jiukuaitech.bookkeeping.user.tag_relation;

import com.jiukuaitech.bookkeeping.user.balance_flow.AmountInvalidateException;
import com.jiukuaitech.bookkeeping.user.book.Book;
import com.jiukuaitech.bookkeeping.user.user.UserService;
import com.jiukuaitech.bookkeeping.user.exception.ItemNotFoundException;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.math.BigDecimal;

@Service
public class TagRelationService {

    @Resource
    private TagRelationRepository tagRelationRepository;

    @Resource
    private UserService userService;

    public TagRelationVOForList update(Integer id, TagRelationUpdateRequest request, Integer userSignInId) {
        Book book = userService.getUser(userSignInId).getDefaultBook();
        TagRelation po = tagRelationRepository.findById(id).orElseThrow(ItemNotFoundException::new);
        if (!po.getTransaction().getBook().equals(book)) throw new ItemNotFoundException();
        if (request.getAmount().compareTo(BigDecimal.ZERO) == 0) throw new AmountInvalidateException();
        if (request.getConvertedAmount() != null && request.getConvertedAmount().compareTo(BigDecimal.ZERO) == 0) throw new AmountInvalidateException();
        po.setAmount(request.getAmount());
        if (request.getConvertedAmount() != null) {
            po.setConvertedAmount(request.getConvertedAmount());
        } else {
            po.setConvertedAmount(request.getAmount());
        }
        return TagRelationVOForList.fromEntity(tagRelationRepository.save(po));
    }

}
