package com.lab.erp.controller.intranet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lab.erp.common.ViewPath;
import com.lab.erp.service.intranet.IntranetService;
import com.lab.erp.service.login.LoginService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.log4j.Log4j2;

@Controller
public class IntranetController {
	
	private LoginService ls;
	private IntranetService is;

	@Autowired
	public IntranetController(LoginService ls, IntranetService is) {
		this.ls = ls;
		this.is = is;
	}
	
	
	@GetMapping("/intranetMain")
	public String intranetMain() {
		return ViewPath.INTRANET + "main";
	}
	
	// 마이페이지
	@RequestMapping("/mypage")
	public String intranetMypage() {
		
		return ViewPath.INTRANET + "mypage/mypage";
	}
	
}
