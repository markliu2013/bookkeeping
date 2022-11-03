package com.jiukuaitech.bookkeeping.user.category;

import com.jiukuaitech.bookkeeping.user.base.BookNameNotesEnableEntity;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.util.CollectionUtils;
import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name="t_category", uniqueConstraints = {@UniqueConstraint(columnNames = {"parent_id", "name"})})
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "type", discriminatorType = DiscriminatorType.INTEGER, columnDefinition = "TINYINT(1)")
@Getter
@Setter
@NoArgsConstructor
public class Category extends BookNameNotesEnableEntity {

    @Column(insertable = false, updatable = false)
    private Integer type; //1支出分类，2收入分类

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "parent_id")
    private Category parent;
    
    @Column(nullable = false)
    @NotNull
    private Integer level;

    @OneToMany(mappedBy = "parent", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<Category> children = new ArrayList<>();

    public Category(Integer id) {
        super.setId(id);
    }

    public List<Category> getChildren(List<Category> categories) {
        List<Category> result = new ArrayList<>();
        for (Category item : categories) {
            if (item.getParent() != null && this.getId().equals(item.getParent().getId())) {
                result.add(item);
            }
        }
        return result;
    }

    public List<Category> getOffspring(List<Category> categories) {
        List<Category> result = new ArrayList<>();
        List<Category> children = this.getChildren(categories);
        if (!CollectionUtils.isEmpty(children)) {
            result.addAll(children);
            for (Category item : children) {
                result.addAll(item.getOffspring(categories));
            }
        }
        return result;
    }

}
