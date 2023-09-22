package com.lab.erp.controller.b;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lab.erp.service.b.B6Service;
import com.lab.erp.service.login.LoginService;
import com.lab.erp.vo.b.b1.Erp_Bs1VO;
import com.lab.erp.vo.b.b1.Erp_Bs2VO;
import com.lab.erp.vo.b.b1.Erp_Bs3VO;
import com.lab.erp.vo.b.b1.Erp_ClosingVO;
import com.lab.erp.vo.b.b6.Erp_ResignVO;
import com.lab.erp.vo.b.b6.Erp_SalaryVO;
import com.lab.erp.vo.login.Erp_EmphistoryVO;
import com.lab.erp.vo.login.Erp_Employee1VO;

@Controller
public class B6Controller {
	private B6Service b6;
	private LoginService ls;
	
	@Autowired
	public B6Controller(B6Service b6, LoginService ls) {
		this.b6 = b6;
		this.ls = ls;
	}
	
	
	//추가근무수당 정산
	@RequestMapping("/greeting/privacy")
	public String privacy() {
		return "/b/b6/b61/privacy";
	}
	
	@RequestMapping("/greeting/list")
	public String list(String employee1_code, Model model, String comcode_code, String type, String word) {
		int comcode_no = ls.comNo(comcode_code);
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		List<Erp_Bs1VO> blist = b6.selectBs();
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("employee1_code", employee1_code);
		map.put("comcode_no", comcode_no);
		map.put("type", type);
		map.put("word", word);
		
		List<Map<String, Object>> list = b6.privacy(map);
		model.addAttribute("list", list);
		model.addAttribute("employee1_code", employee1_code);
		model.addAttribute("blist", blist);
		return "/b/b6/b61/list";
	}
	
	@RequestMapping(value="/imcode", produces = "application/text;charset=utf8")
	@ResponseBody
	public String imcode(String salary_code){
		try {
			int imcode = b6.getSalarycode(salary_code);
			
			return "이미 존재하는 코드입니다.";
		}catch(NullPointerException e) {
			return "사용 가능한 코드입니다.";
		}
	}
	
	@RequestMapping("/greeting/salary/ajax")
	@ResponseBody
	public List<Map<String, Object>> ajax(String employee1_code, String type, String word, String comcode_code) {
		Map<String, Object> map = new HashMap<>();
	      if(type == null || word == null) {
	         type = null;
	         word = null;
	      }
	      
	      int comcode_no = ls.comNo(comcode_code);
	      
	      map.put("employee1_code", employee1_code);
	      map.put("comcode_no", comcode_no);
	      map.put("word", word);
	      map.put("type", type);

	      List<Map<String, Object>> list = b6.privacy(map);
	      if(list.isEmpty()) {
	         list = null;
	      }
	      System.out.println(list);
	      return list;
	      
	}
	
	@RequestMapping("/greeting/salary/insertForm")
	public String insertForm() {
		return "/b/b6/b61/insertForm";
	}
	
	@RequestMapping("/greeting/salary/insert")
	public String insert(Erp_Bs1VO b1vo, Erp_Bs2VO b2vo, Erp_Bs3VO b3vo, Erp_ClosingVO cvo, String salarytype_name, String salary_code, String salary_date, String salary_start, String salary_end, String employee1_code, Erp_SalaryVO vo, String comcode_code, int bs3_no, int dbs3_no, Model model) {
		int employee2_no = b6.selectEmployee(employee1_code);
		
		int comcode_no = ls.comNo(comcode_code);
		
		System.out.println(employee2_no);
		
		int salarytype_no = b6.salaryType(salarytype_name);
		
		double salarytype_magnification = b6.magnification(salarytype_no);
		
		vo.setComcode_no(comcode_no);
		vo.setSalary_code(salary_code);
		vo.setSalary_date(salary_date);
		vo.setSalary_start(salary_start + ":00");
		vo.setSalary_end(salary_end + ":00");
		vo.setEmployee2_no(employee2_no);
		vo.setSalarytype_no(salarytype_no);
		
		cvo.setClosing_date(salary_date);
		
		System.out.println(vo.getSalary_end());
		
		System.out.println(vo.getSalary_date());
		
		int month = b6.selectMonth(salary_date);
		
		System.out.println(month);
		
		int employee2_salary = b6.selectSalary(employee2_no);
		
		System.out.println(employee2_salary);
		
		int year = b6.selectYear(salary_date);
		
		System.out.println(year);
		
		int totalDays = YearMonth.of(year, month).lengthOfMonth();
		
		int weekdays = 0;
		
	       for (int day = 1; day <= totalDays; day++) {
	           LocalDate date = LocalDate.of(year, month, day);
	           if (date.getDayOfWeek() != DayOfWeek.SATURDAY && date.getDayOfWeek() != DayOfWeek.SUNDAY) {
	               weekdays++;
	           }
	       }
	        
	       
	    System.out.println(weekdays);
	    System.out.println(salarytype_magnification);
	    
	    String[] startTokens = salary_start.split(":");
        String[] endTokens = salary_end.split(":");
        
        System.out.println("슷타트시간" + salary_start);
        System.out.println("엔드시간" + salary_end);
        
	    System.out.println("스타트"+startTokens);
	    System.out.println("엔드"+endTokens);
	    
	    int startHours = Integer.parseInt(startTokens[0]);
        int startMinutes = Integer.parseInt(startTokens[1]);
        int endHours = Integer.parseInt(endTokens[0]);
        int endMinutes = Integer.parseInt(endTokens[1]);

        int totalStartMinutes = startHours * 60 + startMinutes;
        int totalEndMinutes = endHours * 60 + endMinutes;

        int minutesDifference = totalEndMinutes - totalStartMinutes;
        double hoursDifference = (double) minutesDifference / 60;
        
        System.out.println(hoursDifference);
	    
	    double salary_cash = (employee2_salary / 12.0 / weekdays / 8 * hoursDifference) * salarytype_magnification;
	    
	    
	    
	    vo.setSalary_cash(salary_cash);
	    
	    System.out.println(salary_cash);
	    
	    cvo.setClosing_debtor((int) salary_cash);
	    cvo.setClosing_creditor((int) -salary_cash);
	    System.out.println(cvo.getClosing_creditor());
	    System.out.println(cvo.getClosing_debtor());
	    cvo.setComcode_no(comcode_no);
	    cvo.setClosing_code(salary_code);
		b6.insertSalary(vo);
		b6.insertClosing(cvo);
	
		int bs_no = b6.selectBsno(bs3_no);
		int bs2_no = b6.selectBsno2(bs3_no);
		
		b1vo.setBs1_amount((int) salary_cash);
		b2vo.setBs2_amount((int) salary_cash);
		b3vo.setBs3_amount((int) salary_cash);
		b3vo.setBs3_no(bs3_no);
		b1vo.setBs1_no(bs_no);
		b2vo.setBs2_no(bs2_no);

		System.out.println(b1vo.getBs1_no());
		System.out.println(b2vo.getBs2_no());
		System.out.println(b3vo.getBs3_no());
		
		b6.updateBs(b1vo);
		b6.updateBs2(b2vo);
		b6.updateBs3(b3vo);
		
		bs2_no = b6.selectBsno2(dbs3_no);
		bs_no = b6.selectBsno(dbs3_no);
		
		b1vo.setBs1_amount((int) -salary_cash);
		b2vo.setBs2_amount((int) -salary_cash);
		b3vo.setBs3_amount((int) -salary_cash);
		b3vo.setBs3_no(dbs3_no);
		b1vo.setBs1_no(bs_no);
		b2vo.setBs2_no(bs2_no);
		
		System.out.println(b1vo.getBs1_no());
		System.out.println(b2vo.getBs2_no());
		System.out.println(b3vo.getBs3_no());
		
		b6.updateBs(b1vo);
		b6.updateBs2(b2vo);
		b6.updateBs3(b3vo);
		
		return "redirect:/greeting/list";
		
	}
	
	
	
	//퇴직
	@RequestMapping("/greeting/resignList")
	public String resignList(Model model) {
		List<Erp_Employee1VO> list = new ArrayList<>();
		list = b6.resignList();
		model.addAttribute("list", list);

		return "/b/b6/b62/resignList";
	}
	
	@RequestMapping("/greeting/resign/insertForm")
	public String resigninsertForm(Model model, int employee1_no, int employee2_no) {
		System.out.println(employee2_no);
		model.addAttribute("employee2_no", employee2_no);
		model.addAttribute("employee1_no", employee1_no);
		return "/b/b6/b62/resigninsertForm";
	}
	
	@RequestMapping("/greeting/resign/insert")
	public String resigninsert(String comcode_code, int employee1_no, int employee2_no, String resign_code, String resign_date, Erp_ResignVO vo) {
		
		int comcode_no = ls.comNo(comcode_code);
		
		vo.setEmployee2_no(employee2_no);
		vo.setResign_code(resign_code);
		vo.setResign_date(resign_date);
		vo.setComcode_no(comcode_no);
		int employee2_salary = b6.selectSalary(employee2_no);
		int employee2_exp = b6.selectExp(employee2_no);
		int resign_cost = (employee2_salary / 12) * employee2_exp;
		vo.setResign_cost(resign_cost);
		
		b6.resignInsert(vo);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("emphistory_resign", resign_date);
		map.put("employee1_no", employee1_no);
		
		b6.updateResign(map);
		
		return "redirect:/greeting/resignList";
	}
	
	@RequestMapping("/greeting/salary/updateForm")
	public String updateForm(String type, String word, Model model, String employee1_code, String comcode_code, int salary_no) {
		
		System.out.println(employee1_code);
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		map.put("comcode_no", comcode_no);
		map.put("employee1_code", employee1_code);
		map.put("salary_no", salary_no);
		
		map = b6.selectSalaryUpdate1(map);
		
		Map<String, Object> map2 = new HashMap<>();
		map2.put("comcode_no", comcode_no);
		map2.put("employee1_code", employee1_code);
		map2.put("salary_no", salary_no);
		
		map2 = b6.selectSalaryUpdate2(map);
		
		Map<String, Object> map3 = new HashMap<String, Object>();
		
		map3.put("employee1_code", employee1_code);
		map3.put("comcode_no", comcode_no);
		map3.put("type", type);
		map3.put("word", word);
		
		List<Map<String, Object>> list = b6.privacy(map3);
		
		List<Erp_Bs1VO> blist = b6.selectBs();
		
		System.out.println("업데이트폼: " + list);
		
		model.addAttribute("list", list);

		model.addAttribute("map", map);
		
		model.addAttribute("map2", map2);
		
		model.addAttribute("blist", blist);
		
		return "/b/b6/b61/list";
		
	}
	
	@RequestMapping("/greeting/salary/update")
	public String update(int salary_no, Erp_SalaryVO svo, Erp_Bs1VO b1vo, Erp_Bs2VO b2vo, Erp_Bs3VO b3vo, Erp_ClosingVO cvo, String salarytype_name, String salary_code, String salary_date, String salary_start, String salary_end, String employee1_code, Erp_SalaryVO vo, String comcode_code, int bs3_no, int dbs3_no, Model model) {
		
		int comcode_no = ls.comNo(comcode_code);
		
		int employee2_no = b6.selectEmployee(employee1_code);
		
		int salarytype_no = b6.salaryType(salarytype_name);
		
		double salarytype_magnification = b6.magnification(salarytype_no);
		
		int month = b6.selectMonth(salary_date);
		
		System.out.println(month);
		
		int employee2_salary = b6.selectSalary(employee2_no);
		
		System.out.println(employee2_salary);
		
		int year = b6.selectYear(salary_date);
		
		System.out.println(year);
		
		int totalDays = YearMonth.of(year, month).lengthOfMonth();
		
		int weekdays = 0;
		
	       for (int day = 1; day <= totalDays; day++) {
	           LocalDate date = LocalDate.of(year, month, day);
	           if (date.getDayOfWeek() != DayOfWeek.SATURDAY && date.getDayOfWeek() != DayOfWeek.SUNDAY) {
	               weekdays++;
	           }
	       }
	        
	       
	    System.out.println(weekdays);
	    System.out.println(salarytype_magnification);
	    
	    String[] startTokens = salary_start.split(":");
        String[] endTokens = salary_end.split(":");
        
        System.out.println("슷타트시간" + salary_start);
        System.out.println("엔드시간" + salary_end);
        
	    System.out.println("스타트"+startTokens);
	    System.out.println("엔드"+endTokens);
	    
	    int startHours = Integer.parseInt(startTokens[0]);
        int startMinutes = Integer.parseInt(startTokens[1]);
        int endHours = Integer.parseInt(endTokens[0]);
        int endMinutes = Integer.parseInt(endTokens[1]);

        int totalStartMinutes = startHours * 60 + startMinutes;
        int totalEndMinutes = endHours * 60 + endMinutes;

        int minutesDifference = totalEndMinutes - totalStartMinutes;
        double hoursDifference = (double) minutesDifference / 60;
        
        System.out.println(hoursDifference);
	    
	    double salary_cash = (employee2_salary / 12.0 / weekdays / 8 * hoursDifference) * salarytype_magnification;
	    
	    
	    
		
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("salary_date", salary_date);
		map.put("salarytype_no", salarytype_no);
		map.put("salary_start", salary_start);
		map.put("salary_end", salary_end);
		map.put("salary_no", salary_no);
		map.put("salary_cash", salary_cash);
		
		b6.salaryUpdate(map);
		
		cvo.setClosing_debtor((int) salary_cash);
	    cvo.setClosing_creditor((int) -salary_cash);
	    System.out.println(cvo.getClosing_creditor());
	    System.out.println(cvo.getClosing_debtor());
	    cvo.setComcode_no(comcode_no);
	    cvo.setClosing_code(salary_code);
		int su = b6.insertSalary(vo);
		b6.insertClosing(cvo);
	
		int bs_no = b6.selectBsno(bs3_no);
		int bs2_no = b6.selectBsno2(bs3_no);
		
		b1vo.setBs1_amount((int) salary_cash);
		b2vo.setBs2_amount((int) salary_cash);
		b3vo.setBs3_amount((int) salary_cash);
		b3vo.setBs3_no(bs3_no);
		b1vo.setBs1_no(bs_no);
		b2vo.setBs2_no(bs2_no);

		System.out.println(b1vo.getBs1_no());
		System.out.println(b2vo.getBs2_no());
		System.out.println(b3vo.getBs3_no());
		
		b6.updateBs(b1vo);
		b6.updateBs2(b2vo);
		b6.updateBs3(b3vo);
		
		bs2_no = b6.selectBsno2(dbs3_no);
		bs_no = b6.selectBsno(dbs3_no);
		
		b1vo.setBs1_amount((int) -salary_cash);
		b2vo.setBs2_amount((int) -salary_cash);
		b3vo.setBs3_amount((int) -salary_cash);
		b3vo.setBs3_no(dbs3_no);
		b1vo.setBs1_no(bs_no);
		b2vo.setBs2_no(bs2_no);
		
		System.out.println(b1vo.getBs1_no());
		System.out.println(b2vo.getBs2_no());
		System.out.println(b3vo.getBs3_no());
		
		b6.updateBs(b1vo);
		b6.updateBs2(b2vo);
		b6.updateBs3(b3vo);
		
		return "";
	}
	
}
