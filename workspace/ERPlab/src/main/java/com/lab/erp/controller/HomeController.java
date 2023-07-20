package com.lab.erp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class HomeController {
	public HomeController() {
		System.out.println("### LOG : " + getClass().getName() + "() 생성");
	}
	
	@RequestMapping("/home")
	public void home() {}
}
