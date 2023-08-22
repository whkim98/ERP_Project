package com.lab.erp.controller.b;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lab.erp.service.b.B7Service;

@Controller
public class B7Controller {

	private B7Service b7;
	
	@Autowired
	public B7Controller(B7Service b7) {
		this.b7 = b7;
	}
	
	@RequestMapping("/gunradish")
	public String gunradish() {
		return "";
	}
	
}
