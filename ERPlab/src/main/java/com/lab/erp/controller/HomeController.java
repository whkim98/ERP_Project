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
<<<<<<< HEAD
		return "home";
	}
	
	@RequestMapping("/index")
	public String index() {
		return "index";
=======
		return "thymeleaf/home";
>>>>>>> 1de0200e861394bcdda39aaa186f30682f2abea1
	}
	
	@GetMapping("/test")
	public String test() {
		return "thymeleaf/test";
	}
	
	@GetMapping("/testjsp")
<<<<<<< HEAD
	public String sidebar() {
		return "sidebar";
	}
=======
	public String index() {
		return "index";
	}
	
	@GetMapping("/footer")
	public String footer() {
		return "thymeleaf/footer";
	}
	
	@GetMapping("/test/ruddud")
	public String ruddud() {
		return "ruddud";
	}
	
	@GetMapping("/test/wjsfir")
	public String wjsfir() {
		return "wjsfir";
	}
	
	@GetMapping("test/ghlrP")
	public String ghlrP() {
		return "ghlrP";
	}
	
	@GetMapping("/test/woan")
	public String woan() {
		return "woan";
	}
	
	@GetMapping("/test/dlstk")
	public String dlstk() {
		return "dlstk";
	}
	
	@GetMapping("/test/chdan")
	public String chdan() {
		return "chdan";
	}
	
	@GetMapping("/test/godhl")
	public String godhl() {
		return "godhl";
	}
	
	@GetMapping("/test/rnrso")
	public String rnrso() {
		return "rnrso";
	}
	
	@GetMapping("/test/aowkd")
	public String aowkd() {
		return "aowkd";
	}
	
	@GetMapping("/test/duddjq")
	public String duddjq() {
		return "duddjq";
	}
	
	@GetMapping("/test/todtks")
	public String todtks() {
		return "todtks";
	}
	
	@GetMapping("/test/rnao")
	public String rnao() {
		return "rnao";
	}
	
	@GetMapping("/test/vnawlf")
	public String vnawlf() {
		return "vnawlf";
	}
	
	@GetMapping("/test/anffb")
	public String anffb() {
		return "anffb";
	}

>>>>>>> 1de0200e861394bcdda39aaa186f30682f2abea1
}
