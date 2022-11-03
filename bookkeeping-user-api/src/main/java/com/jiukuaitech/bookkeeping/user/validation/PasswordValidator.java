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


@NotBlank(message = "password must not be blank")
@Size(min = 6, max = 32, message = "password size must be between 6 and 32")
@Pattern(regexp = "^[A-Za-z0-9~`!@#\\$%\\^&\\*\\(\\)-_=\\+\\[\\]\\{\\}\\|]*$") //数字，字母，特殊字符(不包括空格)

@Target({ FIELD })
@Retention(RUNTIME)
@Constraint(validatedBy = { })
@Documented
public @interface PasswordValidator {
    
    String message() default "{javax.validation.constraints.Pattern.message}";

    Class<?>[] groups() default { };

    Class<? extends Payload>[] payload() default { };
    
}
