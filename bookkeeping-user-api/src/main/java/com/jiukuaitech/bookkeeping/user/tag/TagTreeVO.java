package com.jiukuaitech.bookkeeping.user.tag;

import lombok.Getter;
import lombok.Setter;
import org.springframework.util.CollectionUtils;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class TagTreeVO {

    private Integer id;
    private String name;
    private String notes;
    private Boolean enable;
    private Boolean expenseable;
    private Boolean incomeable;
    private Boolean transferable;
    private List<TagTreeVO> children;
    private Integer parentId;
    private String parentName;

    public static List<TagTreeVO> valueOfList(List<Tag> tags) {
        List<TagTreeVO> treeVOList = new ArrayList<>();
        for (Tag item : tags) {
            if (item.getParent() == null) {
                treeVOList.add(TagTreeVO.valueOf(item, tags));
            }
        }
        return treeVOList;
    }

    public static TagTreeVO valueOf(Tag tag, List<Tag> tags) {
        TagTreeVO treeVO = new TagTreeVO();
        treeVO.setId(tag.getId());
        treeVO.setName(tag.getName());
        treeVO.setNotes(tag.getNotes());
        treeVO.setEnable(tag.getEnable());
        treeVO.setExpenseable(tag.getExpenseable());
        treeVO.setIncomeable(tag.getIncomeable());
        treeVO.setTransferable(tag.getTransferable());
        treeVO.setParentId(tag.getParent() == null ? null : tag.getParent().getId());
        treeVO.setParentName(tag.getParent() == null ? null : tag.getParent().getName());
        if (!CollectionUtils.isEmpty(tag.getChildren(tags))) {
            for (Tag item : tag.getChildren(tags)) {
                if (treeVO.getChildren() == null) {
                    treeVO.setChildren(new ArrayList<>());
                }
                treeVO.getChildren().add(valueOf(item, tags));
            }
        }
        return treeVO;
    }

    public static TagTreeVO valueOf(Tag tag) {
        TagTreeVO tagTreeVO = new TagTreeVO();
        tagTreeVO.setId(tag.getId());
        tagTreeVO.setName(tag.getName());
        tagTreeVO.setNotes(tag.getNotes());
        tagTreeVO.setEnable(tag.getEnable());
        tagTreeVO.setExpenseable(tag.getExpenseable());
        tagTreeVO.setIncomeable(tag.getIncomeable());
        tagTreeVO.setTransferable(tag.getTransferable());
        if (tag.getParent() != null) tagTreeVO.setParentId(tag.getParent().getId());
        if (tag.getParent() != null) tagTreeVO.setParentName(tag.getParent().getName());
        return tagTreeVO;
    }

}
