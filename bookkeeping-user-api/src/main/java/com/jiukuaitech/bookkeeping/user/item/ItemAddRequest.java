package com.jiukuaitech.bookkeeping.user.item;

import com.jiukuaitech.bookkeeping.user.validation.NameValidator;
import com.jiukuaitech.bookkeeping.user.validation.TimeValidator;
import lombok.Getter;
import lombok.Setter;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@Getter
@Setter
public class ItemAddRequest {

    @NotNull
    private Integer type;

    @NotBlank(message="name must not be blank")
    @NameValidator
    private String title;

    private String notes;

    @TimeValidator
    private Long startDate;

    @TimeValidator
    private Long endDate;

    private Integer repeatType;

    private Integer interval;

}
