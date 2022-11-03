package com.jiukuaitech.bookkeeping.user.tag;

import com.jiukuaitech.bookkeeping.user.base.BookNameNotesEnableEntity;
import lombok.Getter;
import lombok.Setter;
import org.springframework.util.CollectionUtils;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "t_tag", uniqueConstraints = {@UniqueConstraint(columnNames = {"book_id", "name"})})
@Getter
@Setter
/**
 * 账单标签
 */
public class Tag extends BookNameNotesEnableEntity {

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "parent_id")
    private Tag parent;

    @Column(nullable = false)
    @NotNull
    private Integer level;
    
    @Column(nullable = false)
    @NotNull
    private Boolean expenseable = true; //是否可支出

    @Column(nullable = false)
    @NotNull
    private Boolean incomeable = true; //是否可收入

    @Column(nullable = false)
    @NotNull
    private Boolean transferable = true; //是否可转账

    @OneToMany(mappedBy = "parent", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<Tag> children = new ArrayList<>();

    public Tag() { }

    public Tag(Integer id) {
        super.setId(id);
    }

    public List<Tag> getChildren(List<Tag> tags) {
        List<Tag> result = new ArrayList<>();
        for (Tag item : tags) {
            if (item.getParent() != null && this.getId().equals(item.getParent().getId())) {
                result.add(item);
            }
        }
        return result;
    }

    public List<Tag> getOffspring(List<Tag> tags) {
        List<Tag> result = new ArrayList<>();
        List<Tag> children = this.getChildren(tags);
        if (!CollectionUtils.isEmpty(children)) {
            result.addAll(children);
            for (Tag item : children) {
                result.addAll(item.getOffspring(tags));
            }
        }
        return result;
    }

}
