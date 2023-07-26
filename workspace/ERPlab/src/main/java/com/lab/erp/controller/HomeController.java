package com.lab.erp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class HomeController {
	public HomeController() {
		System.out.println("### LOG : " + getClass().getName() + "() 생성");
	}
	
	@RequestMapping("/home")
	public String home() {
		return "thymeleaf/home";
	}
	
	@GetMapping("/test")
	public String test() {
		return "thymeleaf/test";
	}
	
	@GetMapping("/testjsp")
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

}
