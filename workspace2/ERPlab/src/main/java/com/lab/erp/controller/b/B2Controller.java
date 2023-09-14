package com.lab.erp.controller.b;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lab.erp.service.c.C2Service;
import com.lab.erp.service.login.LoginService;

@Controller
public class B2Controller {

	private C2Service c2;
	private LoginService ls;
	
	@Autowired
	public B2Controller(C2Service c2, LoginService ls) {
		this.c2 = c2;
		this.ls = ls;
	}
	
	@RequestMapping("/account")
	public String account() {
		return "";
	}
	
	
	
}
