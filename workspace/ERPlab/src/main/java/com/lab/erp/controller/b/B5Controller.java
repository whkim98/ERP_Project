package com.lab.erp.controller.b;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lab.erp.service.b.B5Service;
import com.lab.erp.vo.login.Erp_Employee1VO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class B5Controller {
	private B5Service b5;
	
	@Autowired
	public B5Controller(B5Service b5) {
		this.b5 = b5;
	}
	
	@GetMapping("/greeting")
	public String greeting(HttpSession session, HttpServletRequest request, Model model) {
		
		Integer no = (Integer)session.getAttribute("login");
		
		System.out.println(no);
		
		List<Erp_Employee1VO> list = b5.selectEmployee();
		
		System.out.println(list);
		
		String msg = null;
		String url = null;
		
		if(no != 8) {
			msg = "정보를 불러올 수 없습니다.";
			url = "/index";
		} else {
			url = "/greeting/list";
		}
		
		System.out.println(msg);
		System.out.println(url);
		
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		request.setAttribute("list", list);
		
		return url;
		
	}
	
	@RequestMapping("/greeting/attendance")
	public String attendance() {
		return "/b/b5/b53/attendancelist";
	}
	
}

