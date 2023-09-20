package com.lab.erp.controller.home;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lab.erp.common.ViewPath;
import com.lab.erp.service.login.LoginService;
import com.lab.erp.vo.all.Erp_ComcodeVO;

import jakarta.servlet.http.HttpServletResponse;

@Controller
public class HomeController {
	private LoginService ls;
	
	@Autowired
	public HomeController(LoginService ls) {
		this.ls = ls;
	}
	
	@RequestMapping("/")
	public String home(Model model, @RequestParam(value = "comcode_code", required = false) String comcode_code) {
		if(comcode_code == null) {
			comcode_code = "";
		}
		System.out.print(comcode_code);
		model.addAttribute("comcode_code", comcode_code);
		return "home";
	}
	
	@GetMapping("/test")
	public String test() {
		return "thymeleaf/test";
	}
	
	@GetMapping("/index")
	public String index() {
		return "index";
	}
	
	@GetMapping("/footer")
	public String footer() {
		return "thymeleaf/footer";
	}
	
	@GetMapping("/test/managementplanning")
	public String managementplanning() {
		return "index/managementplanning";
	}
	
	@GetMapping("/test/strategicplanning")
	public String strategicplanning() {
		return "index/strategicplanning";
	}
	
	@GetMapping("test/account")
	public String account() {
		return "index/account";
	}
	
	@GetMapping("/test/finance")
	public String finance() {
		return "index/finance";
	}
	
	@GetMapping("/test/greeting")
	public String greeting() {
		return "index/greeting";
	}
	
	@GetMapping("/test/gunradish")
	public String gunradish() {
		return "index/gunradish";
	}
	
	@GetMapping("/test/internationalsales")
	public String internationalsales() {
		return "index/internationalsales";
	}
	
	@GetMapping("/test/domesticsales")
	public String domesticsales() {
		return "index/domesticsales";
	}
	
	@GetMapping("/test/storesales")
	public String storesales() {
		return "index/storesales";
	}
	
	@GetMapping("/test/businessmanagement")
	public String businessmanagement() {
		return "index/businessmanagement";
	}
	
	@GetMapping("/test/production")
	public String production() {
		return "index/production";
	}
	
	@GetMapping("/test/purchase")
	public String purchase() {
		return "index/purchase";
	}
	
	@GetMapping("/test/quality")
	public String quality() {
		return "index/quality";
	}
	
	@GetMapping("/test/distribution")
	public String distribution() {
		return "index/distribution";
	}
	
	@GetMapping("/error")
	public void error(HttpServletResponse response) throws Exception {
		PrintWriter out = response.getWriter();
		out.println("<script>alert('알 수 없는 에러가 발생했습니다. 이전 페이지로 이동합니다.'); history.go(-1);</script>");
		out.flush();
	}
	
	
	// 개인정보처리방침
	@RequestMapping("/privacyPolicy")
	public String privacyPolicy() {

		return "/layout/privacyPolicy";
	}

}
