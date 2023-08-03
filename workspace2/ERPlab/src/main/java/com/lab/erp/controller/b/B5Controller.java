package com.lab.erp.controller.b;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lab.erp.service.b.B5Service;
import com.lab.erp.vo.login.Erp_Employee1VO;
import com.lab.erp.vo.login.Erp_Employee2VO;

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
			url = "/b/b5/b51/list";
		}
		
		System.out.println(msg);
		System.out.println(url);
		
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		request.setAttribute("list", list);
		
		return url;
		
	}
	
	@RequestMapping("/greeting/employee/insertForm")
	public String insertForm() {
		return "/b/b5/b51/insertForm";
	}
	
	@RequestMapping("/greeting/employee/insert")
	public String insert(Erp_Employee1VO vo1, Erp_Employee2VO vo2, String employee1_code, String employee1_name, String employee1_addr1, String employee1_addr2, String employee1_postal, String employee1_residentno, String employee1_phone, String employee1_email, String employee1_id, String employee1_pw, int employee1_disability, int employee1_merit, int team_no, String employee2_extension, String employee2_position, int employee2_salary, Double employee2_holiday, int employee2_four, String employee2_worktype) {
		vo1.setEmployee1_code(employee1_code);
		vo1.setEmployee1_name(employee1_name);
		vo1.setEmployee1_addr1(employee1_addr1);
		vo1.setEmployee1_addr2(employee1_addr2);
		vo1.setEmployee1_postal(employee1_postal);
		vo1.setEmployee1_residentno(employee1_residentno);
		vo1.setEmployee1_phone(employee1_phone);
		vo1.setEmployee1_email(employee1_email);
		vo1.setEmployee1_id(employee1_id);
		vo1.setEmployee1_pw(employee1_pw);
		vo1.setEmployee1_disability(employee1_disability);
		vo1.setEmployee1_merit(employee1_merit);
		
		int su = b5.insertEmployee1(vo1);
		
		int employee1_no = b5.selectEmployeeno(vo1.getEmployee1_code());
		
		vo2.setEmployee1_no(employee1_no);
		vo2.setTeam_no(team_no);
		vo2.setEmployee2_extension(employee2_extension);
		vo2.setEmployee2_position(employee2_position);
		vo2.setEmployee2_salary(employee2_salary);
		vo2.setEmployee2_holiday(employee2_holiday);
		vo2.setEmployee2_four(employee2_four);
		vo2.setEmployee2_worktype(employee2_worktype);
		
		int su2 = b5.insertEmployee2(vo2);
	
		return "redirect:/greeting";
	}
	
	@RequestMapping("/greeting/attendance")
	public String attendance() {
		return "/b/b5/b53/attendancelist";
	}
	
}

