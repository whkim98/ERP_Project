package com.lab.erp.controller.c;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lab.erp.service.c.C3Service;
import com.lab.erp.vo.c.c3.Erp_EventVO;

@Controller
@RequestMapping("/c")
public class C3Controller {
	private C3Service c3Service;
	
	@Autowired
	public void setC3Service(C3Service c3Service) {
		this.c3Service = c3Service;
	}
	
	@GetMapping("/event")
	public String c_event (Model model) {
		List<Erp_EventVO> list_res = c3Service.list();
		model.addAttribute("list", list_res);
		return "thymeleaf/c/c_event";
	}
	
	
}
