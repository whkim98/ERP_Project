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
		System.out.println(target);
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "event_code", "event_code error");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "event_name", "event_name error");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "goods_no", "goods_no error");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "event_price", "event_price error");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "event_qty", "event_qty error");
        
	}

}
