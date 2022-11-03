package com.jiukuaitech.bookkeeping.user.base;

import com.jiukuaitech.bookkeeping.user.validation.NameValidator;
import com.jiukuaitech.bookkeeping.user.validation.NotesValidator;
import lombok.Getter;
import lombok.Setter;
import javax.persistence.*;
import javax.validation.constraints.NotNull;

@MappedSuperclass
@Getter
@Setter
public abstract class BookNameNotesEnableEntity extends HasBookEntity {

    @Column(length = 16, nullable = false)
    @NotNull
    @NameValidator
    private String name;

    @Column(length = 128)
    @NotesValidator
    private String notes;

    @Column(nullable = false)
    @NotNull
    private Boolean enable = true;

}
