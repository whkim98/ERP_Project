package com.erplab.domain;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

public class WriteValidator implements Validator {


    @Override
    public boolean supports(Class<?> clazz) {
        System.out.println("supports(" + clazz.getName() +")");

        boolean result = Write.class.isAssignableFrom(clazz);
        System.out.println("result : " + result);

        return result;
    }


    @Override
    public void validate(Object target, Errors errors) {
        Write write = (Write)target;
        System.out.println("### LOG : validate() 호출, " + write + " ###");

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "subject" ,"subject 글제목은 필수입니다.");
    }
}
