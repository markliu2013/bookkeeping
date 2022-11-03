package com.jiukuaitech.bookkeeping.user.category;

import com.jiukuaitech.bookkeeping.user.book.Book;
import com.jiukuaitech.bookkeeping.user.expense_category.ExpenseCategory;
import com.jiukuaitech.bookkeeping.user.income_category.IncomeCategory;
import com.jiukuaitech.bookkeeping.user.user.User;
import com.jiukuaitech.bookkeeping.user.base.BookNameNotesEnableSpec;
import com.jiukuaitech.bookkeeping.user.category_relation.CategoryRelationRepository;
import com.jiukuaitech.bookkeeping.user.exception.ItemNotFoundException;
import com.jiukuaitech.bookkeeping.user.user.UserService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class CategoryService {

    @Resource
    private CategoryRepository categoryRepository;

    @Resource
    private CategoryRelationRepository categoryRelationRepository;

    @Resource
    private UserService userService;

    @Value("${category.max.level}")
    private Integer maxLevel;

    /*
    删除分类需要检查：1. 有无支出；2. 有无账本的默认; 3. 有无子类
     */
    public boolean remove(Integer id, Integer userSignInId) {
        Book book = userService.getUser(userSignInId).getDefaultBook();
        Category po = categoryRepository.findOneByBookAndId(book, id).orElseThrow(ItemNotFoundException::new);
        // 检查关联性，有账单关联的不能删除
        if (categoryRelationRepository.countByCategory_id(id) > 0) {
            throw new CategoryHasDealException();
        }
        if (po.equals(book.getDefaultExpenseCategory())) throw new CategoryIsDefaultExpenseException();
        if (po.equals(book.getDefaultIncomeCategory())) throw new CategoryIsDefaultIncomeException();
        categoryRepository.delete(po);
        return true;
    }

    @Transactional
    public boolean toggle(Integer id, Integer userSignInId) {
        Book book = userService.getUser(userSignInId).getDefaultBook();
        Category po = categoryRepository.findOneByBookAndId(book, id).orElseThrow(ItemNotFoundException::new);
        List<Category> entityList = categoryRepository.findAll(BookNameNotesEnableSpec.isBook(po.getBook()));
        List<Category> offSpring = po.getOffspring(entityList);
        offSpring.add(po);
        for (Category item : offSpring) {
            if (item.equals(book.getDefaultExpenseCategory())) throw new CategoryIsDefaultExpenseException();
            if (item.equals(book.getDefaultIncomeCategory())) throw new CategoryIsDefaultIncomeException();
            item.setEnable(!po.getEnable());
        }
        categoryRepository.saveAll(offSpring);
        return true;
    }

    public boolean add(Integer type, CategoryAddRequest request, Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        Book book = user.getDefaultBook();
        Category parent = null;
        if (request.getParentId() != null) {
            parent = categoryRepository.findOneByBookAndId(book, request.getParentId()).orElseThrow(ItemNotFoundException::new);
            if (!parent.getEnable()) {
                throw new ParentCategoryNotEnableException();
            }
            if (parent.getLevel().equals(maxLevel-1)) {
                throw new CategoryLevelException();
            }
        }
        if (categoryRepository.findOneByBookAndNameAndParentAndType(book, request.getName(), parent, type).isPresent()) {
            throw new CategoryNameExistsException();
        }
        Category po = null;
        if (type == 1) {
            po = new ExpenseCategory();
        } else {
            po = new IncomeCategory();
        }
        po.setName(request.getName());
        po.setNotes(request.getNotes());
        po.setBook(book);
        po.setParent(parent);
        if (parent == null) po.setLevel(0);
        else po.setLevel(parent.getLevel()+1);
        categoryRepository.save(po);
        return true;
    }

    public boolean update(Integer type, Integer id, CategoryUpdateRequest request, Integer userSignInId) {
        Book book = userService.getUser(userSignInId).getDefaultBook();
        Category po = categoryRepository.findOneByBookAndId(book, id).orElseThrow(ItemNotFoundException::new);
        Category parent = null;
        if (request.getParentId() != null) {
            parent = categoryRepository.findOneByBookAndId(book, request.getParentId()).orElseThrow(ItemNotFoundException::new);
            if (!parent.getEnable()) {
                throw new ParentCategoryNotEnableException();
            }
            if (parent.getLevel().equals(maxLevel-1)) {
                throw new CategoryLevelException();
            }
        }
        po.setParent(parent);
        if (StringUtils.hasText(request.getName())) {
            if(!request.getName().equals(po.getName())) {
                if (categoryRepository.findOneByBookAndNameAndParentAndType(book, request.getName(), parent, type).isPresent()) {
                    throw new CategoryNameExistsException();
                }
                po.setName(request.getName());
            }
        }
        if (request.getNotes() != null) po.setNotes(request.getNotes());
        if (parent == null) po.setLevel(0);
        else po.setLevel(parent.getLevel()+1);
        categoryRepository.save(po);
        return true;
    }

    public List<CategorySimpleVO> getAllEnable(Integer type, Integer userSignInId) {
        Book book = userService.getUser(userSignInId).getDefaultBook();
        List<Category> entityList = categoryRepository.findAllByBookAndTypeAndEnable(book, type, true);
        return entityList.stream().map(CategorySimpleVO::fromEntity).collect(Collectors.toList());
    }

    public List<CategoryTreeVO> getAllTree(CategoryQueryRequest request, Integer type, Integer userSignInId) {
        Book book = userService.getUser(userSignInId).getDefaultBook();
        Specification<Category> specification = CategorySpec.buildSpecification(request, type, book);
        List<Category> entityList = categoryRepository.findAll(specification);
        return CategoryTreeVO.valueOfList(entityList);
    }

    public Page<CategorySimpleVO> query(Integer type, Pageable page, Integer userSignInId) {
        Book book = userService.getUser(userSignInId).getDefaultBook();
        Specification<Category> specification = CategorySpec.buildSpecification(null, type, book);
        Page<Category> poPage = categoryRepository.findAll(specification, page);
        return poPage.map(CategorySimpleVO::fromEntity);
    }

    public CategoryTreeVO get(Integer id, Integer userSignInId) {
        Book book = userService.getUser(userSignInId).getDefaultBook();
        Category category = categoryRepository.findOneByBookAndId(book, id).orElseThrow(ItemNotFoundException::new);
        return CategoryTreeVO.valueOf(category);
    }

}
