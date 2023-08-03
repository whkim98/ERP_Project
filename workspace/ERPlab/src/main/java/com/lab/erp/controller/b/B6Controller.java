package com.lab.erp.controller.b;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lab.erp.service.b.B6Service;
import com.lab.erp.vo.b.b6.Erp_SalaryVO;
import com.lab.erp.vo.login.Erp_Employee1VO;

@Controller
public class B6Controller {
	private B6Service b6;
	
	@Autowired
	public B6Controller(B6Service b6) {
		this.b6 = b6;
	}
	
	
	//추가근무수당 정산
	@GetMapping("/greeting/privacy")
	public String privacy() {
		return "/b/b6/b61/privacy";
	}
	
	@RequestMapping("/greeting/list")
	public String list(String employee1_code, Model model) {
		List<Erp_SalaryVO> list = b6.privacy(employee1_code);
		model.addAttribute("list", list);
		return "/b/b6/b61/list";
	}
	
	@RequestMapping("/greeting/salary/insertForm")
	public String insertForm() {
		return "/b/b6/b61/insertForm";
	}
	
	@RequestMapping("/greeting/salary/insert")
	public String insert(String salarytype_name, String salary_code, String salary_date, String salary_start, String salary_end, String employee1_code, Erp_SalaryVO vo, Model model) {
		int employee2_no = b6.selectEmployee(employee1_code);
		
		int salarytype_no = b6.salaryType(salarytype_name);
		
		double salarytype_magnification = b6.magnification(salarytype_no);
		
		vo.setSalary_code(salary_code);
		vo.setSalary_date(salary_date);
		vo.setSalary_start(salary_start);
		vo.setSalary_end(salary_end);
		vo.setEmployee2_no(employee2_no);
		vo.setSalarytype_no(salarytype_no);
		
		System.out.println(vo.getSalary_end());
		
		Map<String, Object> mapM = new HashMap<>();
		mapM.put("employee2_no", employee2_no);
		mapM.put("salary_date", vo.getSalary_date());
		
		int month = b6.selectMonth(mapM);
		
		int employee2_salary = b6.selectSalary(employee2_no);
		
		Map<String, Object> mapY = new HashMap<>();
		mapY.put("employee2_no", employee2_no);
		mapY.put("salary_date", vo.getSalary_date());
		
		int year = b6.selectYear(mapY);
		
		int totalDays = YearMonth.of(year, month).lengthOfMonth();
		
		int weekdays = 0;
		
	       for (int day = 1; day <= totalDays; day++) {
	           LocalDate date = LocalDate.of(year, month, day);
	           if (date.getDayOfWeek() != DayOfWeek.SATURDAY && date.getDayOfWeek() != DayOfWeek.SUNDAY) {
	               weekdays++;
	           }
	       }
	        
	    double salary_cash = (employee2_salary / 12.0 / weekdays / 8) * salarytype_magnification;
	    
	    vo.setSalary_cash(salary_cash);
	    
		int su = b6.insertSalary(vo);
		
		String msg = "";
		
		if(su != 0) {
			msg = "입력되었습니다";
		}
		
		model.addAttribute("msg", msg);
		
		return "/b/b6/b61/insertresult";
		
	}
	
	//퇴직
	@RequestMapping("/greeting/resignList")
	public String resignList(Model model) {
		List<Erp_Employee1VO> list = b6.resignList();
		model.addAttribute("list", list);
		return "/b/b6/b62/resignList";
	}
	
}
