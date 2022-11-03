package com.jiukuaitech.bookkeeping.user.category;

import lombok.Getter;
import lombok.Setter;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class CategoryTreeVO {

    private Integer id;
    private String name;
    private String notes;
    private Boolean enable;
    private List<CategoryTreeVO> children;
    private Integer parentId;
    private String parentName;

    public static List<CategoryTreeVO> valueOfList(List<Category> categories) {
        List<CategoryTreeVO> categoryTreeVOList = new ArrayList<>();
        for (Category item : categories) {
            if (item.getParent() == null) {
                categoryTreeVOList.add(CategoryTreeVO.valueOf(item, categories));
            }
        }
        return categoryTreeVOList;
    }

    public static CategoryTreeVO valueOf(Category category, List<Category> categories) {
        CategoryTreeVO categoryTreeVO = new CategoryTreeVO();
        categoryTreeVO.setId(category.getId());
        categoryTreeVO.setName(category.getName());
        categoryTreeVO.setNotes(category.getNotes());
        categoryTreeVO.setEnable(category.getEnable());
        categoryTreeVO.setParentId(category.getParent() == null ? null : category.getParent().getId());
        categoryTreeVO.setParentName(category.getParent() == null ? null : category.getParent().getName());
        if (!CollectionUtils.isEmpty(category.getChildren(categories))) {
            for (Category item : category.getChildren(categories)) {
                if (categoryTreeVO.getChildren() == null) {
                    categoryTreeVO.setChildren(new ArrayList<>());
                }
                categoryTreeVO.getChildren().add(valueOf(item, categories));
            }
        }
        return categoryTreeVO;
    }

    public static CategoryTreeVO valueOf(Category category) {
        CategoryTreeVO categoryTreeVO = new CategoryTreeVO();
        categoryTreeVO.setId(category.getId());
        categoryTreeVO.setName(category.getName());
        categoryTreeVO.setNotes(category.getNotes());
        categoryTreeVO.setEnable(category.getEnable());
        if (category.getParent() != null) categoryTreeVO.setParentId(category.getParent().getId());
        if (category.getParent() != null) categoryTreeVO.setParentName(category.getParent().getName());
        return categoryTreeVO;
    }

}
