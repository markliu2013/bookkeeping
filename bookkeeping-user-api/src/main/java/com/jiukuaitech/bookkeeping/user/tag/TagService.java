package com.jiukuaitech.bookkeeping.user.tag;

import com.jiukuaitech.bookkeeping.user.base.BookNameNotesEnableSpec;
import com.jiukuaitech.bookkeeping.user.book.Book;
import com.jiukuaitech.bookkeeping.user.category.CategoryLevelException;
import com.jiukuaitech.bookkeeping.user.category.ParentCategoryNotEnableException;
import com.jiukuaitech.bookkeeping.user.exception.ItemNotFoundException;
import com.jiukuaitech.bookkeeping.user.exception.NameExistsException;
import com.jiukuaitech.bookkeeping.user.tag_relation.TagRelationRepository;
import com.jiukuaitech.bookkeeping.user.user.User;
import com.jiukuaitech.bookkeeping.user.user.UserService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class TagService {

    @Resource
    private UserService userService;

    @Resource
    private TagRepository tagRepository;

    @Resource
    private TagRelationRepository tagRelationRepository;

    @Value("${category.max.level}")
    private Integer maxLevel;

    @Value("${tag.max.count}")
    private Integer maxCount;

    public List<TagTreeVO> getAllTree(TagQueryRequest request, Integer userSignInId) {
        Book book = userService.getUser(userSignInId).getDefaultBook();
        Specification<Tag> specification = TagSpec.buildSpecification(request, book);
        List<Tag> entityList = tagRepository.findAll(specification);
        return TagTreeVO.valueOfList(entityList);
    }

    public TagTreeVO get(Integer id, Integer userSignInId) {
        Book book = userService.getUser(userSignInId).getDefaultBook();
        Tag tag = tagRepository.findOneByBookAndId(book, id).orElseThrow(ItemNotFoundException::new);
        return TagTreeVO.valueOf(tag);
    }

    public List<TagVOForList> getAllEnable(Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        List<Tag> entityList = tagRepository.findByBookAndEnable(user.getDefaultBook(), true);
        return entityList.stream().map(TagVOForList::fromEntity).collect(Collectors.toList());
    }

    public List<TagVOForList> getExpenseable(Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        List<Tag> entityList = tagRepository.findByBookAndEnableAndExpenseable(user.getDefaultBook(), true, true);
        return entityList.stream().map(TagVOForList::fromEntity).collect(Collectors.toList());
    }

    public List<TagVOForList> getIncomeable(Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        List<Tag> entityList = tagRepository.findByBookAndEnableAndIncomeable(user.getDefaultBook(), true, true);
        return entityList.stream().map(TagVOForList::fromEntity).collect(Collectors.toList());
    }

    public List<TagVOForList> getTransferable(Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        List<Tag> entityList = tagRepository.findByBookAndEnableAndTransferable(user.getDefaultBook(), true, true);
        return entityList.stream().map(TagVOForList::fromEntity).collect(Collectors.toList());
    }

    public TagVOForList add(TagAddRequest request, Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        Book book = user.getDefaultBook();
        Tag parent = null;
        if (request.getParentId() != null) {
            parent = tagRepository.findOneByBookAndId(book, request.getParentId()).orElseThrow(ItemNotFoundException::new);
            if (!parent.getEnable()) {
                throw new ParentCategoryNotEnableException();
            }
            if (parent.getLevel().equals(maxLevel-1)) {
                throw new CategoryLevelException();
            }
        }
        if (tagRepository.countByBook(book) >= maxCount) {
            throw new TagMaxCountException();
        }
        // 不能重复
        if (tagRepository.findByBookAndName(book, request.getName()).isPresent()) {
            throw new NameExistsException();
        }
        Tag po = new Tag();
        po.setName(request.getName());
        po.setNotes(request.getNotes());
        if (parent == null) {
            po.setExpenseable(request.getExpenseable());
            po.setIncomeable(request.getIncomeable());
            po.setTransferable(request.getTransferable());
        } else {
            po.setExpenseable(parent.getExpenseable());
            po.setIncomeable(parent.getIncomeable());
            po.setTransferable(parent.getTransferable());
        }
        po.setBook(book);
        po.setParent(parent);
        if (parent == null) po.setLevel(0);
        else po.setLevel(parent.getLevel()+1);
        return TagVOForList.fromEntity(tagRepository.save(po));
    }

    public TagVOForList remove(Integer id, Integer userSignInId) {
        Book book = userService.getUser(userSignInId).getDefaultBook();
        Tag po = tagRepository.findOneByBookAndId(book, id).orElseThrow(ItemNotFoundException::new);
        // 检查关联性，有账单关联的不能删除
        if (tagRelationRepository.countByTag_id(id) > 0) throw new TagHasTransactionException();
        tagRepository.delete(po);
        return TagVOForList.fromEntity(po);
    }

    public TagVOForList update(Integer id, TagUpdateRequest request, Integer userSignInId) {
        Book book = userService.getUser(userSignInId).getDefaultBook();
        Tag po = tagRepository.findOneByBookAndId(book, id).orElseThrow(ItemNotFoundException::new);
        if (!po.getName().equals(request.getName())) {
            if (tagRepository.findByBookAndName(po.getBook(), request.getName()).isPresent()) {
                throw new NameExistsException();
            }
        }
        if (request.getName() != null) po.setName(request.getName());
        if (request.getNotes() != null) po.setNotes(request.getNotes());

        Tag parent = null;
        if (request.getParentId() != null) {
            parent = tagRepository.findOneByBookAndId(book, request.getParentId()).orElseThrow(ItemNotFoundException::new);
            if (!parent.getEnable()) {
                throw new ParentCategoryNotEnableException();
            }
            if (parent.getLevel().equals(maxLevel-1)) {
                throw new CategoryLevelException();
            }
        }
        po.setParent(parent);
        if (parent == null) po.setLevel(0);
        else po.setLevel(parent.getLevel()+1);

        if (request.getExpenseable() != null) po.setExpenseable(request.getExpenseable());
        if (request.getIncomeable() != null) po.setIncomeable(request.getIncomeable());
        if (request.getTransferable() != null) po.setTransferable(request.getTransferable());

//        List<Tag> entityList = tagRepository.findAll(BookNameNotesEnableSpec.inBook(po.getBook()));
//        List<Tag> offSpring = po.getOffspring(entityList);
//        offSpring.add(po);
//        for (Tag item : offSpring) {
//            if (request.getExpenseable() != null) item.setExpenseable(request.getExpenseable());
//            if (request.getIncomeable() != null) item.setIncomeable(request.getIncomeable());
//            if (request.getTransferable() != null) item.setTransferable(request.getTransferable());
//        }

        return TagVOForList.fromEntity(tagRepository.save(po));
    }

    public boolean toggle(Integer id, Integer userSignInId) {
        Book book = userService.getUser(userSignInId).getDefaultBook();
        Tag po = tagRepository.findOneByBookAndId(book, id).orElseThrow(ItemNotFoundException::new);
        List<Tag> entityList = tagRepository.findAll(BookNameNotesEnableSpec.isBook(po.getBook()));
        List<Tag> offSpring = po.getOffspring(entityList);
        offSpring.add(po);
        for (Tag item : offSpring) {
            item.setEnable(!po.getEnable());
        }
        tagRepository.saveAll(offSpring);
        return true;
    }

}