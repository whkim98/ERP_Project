package com.lab.erp.controller.intranet;


import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lab.erp.common.ViewPath;
import com.lab.erp.service.intranet.IntranetService;
import com.lab.erp.service.login.LoginService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.log4j.Log4j2;
import com.lab.erp.service.intranet.IntranetPageService;
import com.lab.erp.service.intranet.IntranetService;
import com.lab.erp.vo.login.Erp_Employee1VO;
import com.lab.erp.vo.login.Erp_Employee2VO;
import com.lab.erp.vo.login.Erp_TeamVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/intranet")
public class IntranetController {
	private IntranetPageService intranetPageService;
	private LoginService ls;
	private IntranetService is;

	@Autowired
	public IntranetController(LoginService ls, IntranetService is) {
		this.ls = ls;
		this.is = is;
	}
	
	@Autowired
	public void setIntranetService(IntranetPageService intranetPageService) {
		this.intranetPageService = intranetPageService;
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
	
	// ---------조직도+메인화면---------
	@GetMapping("/organization")
	public String organization(Model model) {
		List<Erp_TeamVO> list_res = intranetPageService.list_team();
		model.addAttribute("team_list", list_res);
		return "thymeleaf/intranet/organization";
	}

	// ---------일정---------
	@GetMapping("/calendar")
	public String calendar(Model model) {
		// TODO
		return "thymeleaf/intranet/organization";
	}
	
	// ---------주소록---------
	@GetMapping("/address_book")
	public String address_book(Model model) {
		List<Erp_Employee1VO> list_res = intranetPageService.list_employee1();
		model.addAttribute("employee1_list", list_res);
		return "thymeleaf/intranet/organization";
	}
	
	// ---------이메일---------
	@GetMapping("/email")
	public String email(Model model, HttpSession session) {
		List<Erp_Employee1VO> list_res = intranetPageService.list_employee1();
		String intranetLoginInfo = (String) session.getAttribute("Intranetlogin");
		String email = "";
		for(Erp_Employee1VO employee : list_res) {
			if(intranetLoginInfo == employee.getEmployee1_id()) email = employee.getEmployee1_email();
		}
		model.addAttribute("email", email);
		
		return "thymeleaf/intranet/email";
	}
	
	// ---------연차---------
	@GetMapping("/annual_leave")
	public String annual_leave(Model model) {
		List<Erp_Employee2VO> list_res = intranetPageService.list_employee2();
		model.addAttribute("employee2_list", list_res);
		return "thymeleaf/intranet/annual_leave";
	}


}
