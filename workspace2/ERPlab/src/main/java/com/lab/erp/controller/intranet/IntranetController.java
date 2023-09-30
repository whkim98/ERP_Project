package com.lab.erp.controller.intranet;


import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lab.erp.common.ViewPath;
import com.lab.erp.service.intranet.IntranetService;
import com.lab.erp.service.login.LoginService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.log4j.Log4j2;
import com.lab.erp.service.intranet.IntranetPageService;
import com.lab.erp.service.intranet.IntranetService;
import com.lab.erp.vo.d.d5.Erp_ClaimVO;
import com.lab.erp.vo.intranet.Erp_CalendarVO;
import com.lab.erp.vo.intranet.Erp_EmailVO;
import com.lab.erp.vo.login.Erp_DeptVO;
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
	
	// ---------조직도---------
	@GetMapping("/organization")
	public String organization(Model model) {
		List<Erp_TeamVO> list_res = intranetPageService.list_team();
		List<Erp_Employee1VO> list_employee1 = intranetPageService.list_employee1();
		List<Erp_Employee2VO> list_employee2 = intranetPageService.list_employee2();
		model.addAttribute("team_list", list_res);
		model.addAttribute("employee1_list", list_employee1);
		model.addAttribute("employee2_list", list_employee2);
		return "thymeleaf/intranet/organization";
	}

	// ---------일정---------
	@GetMapping("/calendar")
	public String calendar(Model model) {
		Erp_CalendarVO calendarVO = intranetPageService.find_calendar();
		System.out.println("calendarVO : " + calendarVO);
		model.addAttribute("calendarVO", calendarVO);
		return "thymeleaf/intranet/calendar";
	}
	
	@PostMapping("/calendar")
	public String calendar_update(Erp_CalendarVO erp_CalendarVO) {
		int res = intranetPageService.update_calendar(erp_CalendarVO);
		return "redirect:/intranet/calendar";
	}
	
	// ---------주소록---------
	@GetMapping("/address_book")
	public String address_book(Model model) {
		List<Erp_Employee1VO> list_res = intranetPageService.list_employee1();
		List<Erp_TeamVO> list_team = intranetPageService.list_team();
		List<Erp_Employee2VO> list_employee2 = intranetPageService.list_employee2();
		List<Erp_DeptVO> list_dept = intranetPageService.list_dept();
		model.addAttribute("employee1_list", list_res);
		model.addAttribute("employee2_list", list_employee2);
		model.addAttribute("team_list", list_team);
		model.addAttribute("dept_list", list_dept);
		return "thymeleaf/intranet/address_book";
	}
	
	// ---------이메일---------
	@GetMapping("/email")
	public String email(Model model, HttpSession session) {
		List<Erp_Employee1VO> list_res = intranetPageService.list_employee1();
		int intranetLoginInfo = Integer.parseInt( (String) session.getAttribute("Intranetlogin"));
		String email = "";
		for(Erp_Employee1VO employee : list_res) {
			if(intranetLoginInfo == employee.getEmployee1_no()) email = employee.getEmployee1_email();
		}
		model.addAttribute("email", email);
//		model.addAttribute("email", "erplab2023@gmail.com"); //testing
		
		return "thymeleaf/intranet/email";
	}
	
	@PostMapping("/email")
	public String email(Model model, HttpSession session, Erp_EmailVO erp_EmailVO) {
		List<Erp_Employee1VO> list_res = intranetPageService.list_employee1();
		int intranetLoginInfo = Integer.parseInt( (String) session.getAttribute("Intranetlogin"));
		String email = "";
		for(Erp_Employee1VO employee : list_res) {
			if(intranetLoginInfo == employee.getEmployee1_no()) email = employee.getEmployee1_email();
		}

		intranetPageService.emailSend(erp_EmailVO, email);
//		intranetPageService.emailSend(erp_EmailVO, "erplab2023@gmail.com"); //testing
		return "redirect:/intranet/email";
	}
	// ---------연차---------
	@GetMapping("/annual_leave")
	public String annual_leave(Model model, HttpSession session) {
		List<Erp_Employee2VO> list_employee2 = intranetPageService.list_employee2();
		List<Erp_Employee1VO> list_employee1 = intranetPageService.list_employee1();
		List<Erp_TeamVO> list_team = intranetPageService.list_team();
		List<Erp_DeptVO> list_dept = intranetPageService.list_dept();
		int intranetLoginInfo = Integer.parseInt( (String) session.getAttribute("Intranetlogin"));

		model.addAttribute("employee1_list", list_employee1);
		model.addAttribute("employee2_list", list_employee2);
		model.addAttribute("team_list", list_team);
		model.addAttribute("dept_list", list_dept);
		model.addAttribute("employee_no", intranetLoginInfo);
		return "thymeleaf/intranet/annual_leave";
	}


}
