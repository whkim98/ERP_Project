package com.lab.erp.util;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.lab.erp.vo.a.a1.Erp_CompanyVO;

public class CompanyValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		return Erp_CompanyVO.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		Erp_CompanyVO erp_CompanyVO = (Erp_CompanyVO)target;
		
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "company_name", "company_name error");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "company_registeredno", "company_registeredno error");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "company_corporatedno", "company_corporatedno error");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "company_businesstype", "company_businesstype error");
        
	}

}
