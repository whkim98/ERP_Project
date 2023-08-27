package com.lab.erp.util;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.lab.erp.vo.c.c3.Erp_EventVO;

public class EventValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		return Erp_EventVO.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		Erp_EventVO erp_EventVO = (Erp_EventVO) target;
		
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "company_name", "company_name error");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "company_registeredno", "company_registeredno error");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "company_corporatedno", "company_corporatedno error");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "company_businesstype", "company_businesstype error");
        
	}

}
