package com.jiukuaitech.bookkeeping.user.validation;

import javax.validation.Constraint;
import javax.validation.Payload;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.FIELD;
import static java.lang.annotation.RetentionPolicy.RUNTIME;


@NotBlank(message = "username must not be blank")
@Size(min = 3, max = 20, message = "username size must be between 3 and 20")
@Pattern(regexp = "^[A-Za-z0-9]*$") //用户名只允许数字加字母

@Target({ FIELD })
@Retention(RUNTIME)
@Constraint(validatedBy = { })
@Documented
public @interface UserNameValidator {
    
    String message() default "{javax.validation.constraints.Size.message}";

    Class<?>[] groups() default { };

    Class<? extends Payload>[] payload() default { };
    
}
