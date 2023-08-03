package com.lab.erp.controller.a;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lab.erp.service.a.A1Service;
import com.lab.erp.vo.a.a1.Erp_CompanyVO;

@Controller
@RequestMapping("/a")
public class A1Controller {
	
	private A1Service a1Service;
	
	@Autowired
	public void setA1Service(A1Service a1Service) {
		this.a1Service = a1Service;
	}
	
	public A1Controller() {
		System.out.println("### LOG: "+ getClass().getName() + "() 생성");
	}
	
	@GetMapping("/company")
	public String a_company(Model model) {
		List<Erp_CompanyVO> list_res = a1Service.list();
		model.addAttribute("list", list_res);
		return "thymeleaf/a_company";
	}
}
