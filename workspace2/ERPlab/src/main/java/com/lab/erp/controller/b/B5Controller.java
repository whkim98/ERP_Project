package com.lab.erp.controller.b;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lab.erp.service.b.B5Service;
import com.lab.erp.service.login.LoginService;
import com.lab.erp.vo.b.b5.Erp_AttendanceVO;
import com.lab.erp.vo.login.Erp_EmphistoryVO;
import com.lab.erp.vo.login.Erp_Employee1VO;
import com.lab.erp.vo.login.Erp_Employee2VO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class B5Controller {
	private B5Service b5;
	private LoginService ls;
	
	@Autowired
	public B5Controller(B5Service b5, LoginService ls) {
		this.b5 = b5;
		this.ls = ls;
	}
	
	@RequestMapping("/greeting")
	public String greeting(String comcode_code, String type, String word, HttpSession session, HttpServletRequest request, Model model) {
		System.out.println("zhem" + comcode_code);
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		map.put("comcode_no", comcode_no);
		map.put("type", type);
		map.put("word", word);
		
		List<Map<String, Object>> list = b5.selectEmployee(map);
		model.addAttribute("list", list);

		return "/b/b5/b51/list";
		
	}
	
	@RequestMapping("/greeting/ajax")
	@ResponseBody
	public List<Map<String, Object>> greetingAjax(Model model, String comcode_code, String type, String word){
		Map<String, Object> map = new HashMap<>();
	      if(type == null || word == null) {
	         type = null;
	         word = null;
	      }
	      
	      int comcode_no = ls.comNo(comcode_code);
	      
	      map.put("comcode_no", comcode_no);
	      map.put("word", word);
	      map.put("type", type);
	      
	      List<Map<String, Object>> list = b5.selectEmployee(map);
	      if(list.isEmpty()) {
		         list = null;
		      }
		      System.out.println(list);
		  return list;
	}
	
	@RequestMapping("/greeting/employee/insert")
	public String insert(Erp_EmphistoryVO vo, String comcode_code, Erp_Employee1VO vo1, Erp_Employee2VO vo2, String employee1_code, String employee1_name, String employee1_addr1, String employee1_addr2, String employee1_postal, String employee1_residentno, String employee1_phone, String employee1_email, String employee1_id, String employee1_pw, int employee1_disability, int employee1_merit, int team_no, String employee2_extension, String employee2_position, int employee2_salary, Double employee2_holiday, int employee2_four, String employee2_worktype) {
		
		int comcode_no = ls.comNo(comcode_code);
		
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
		
		b5.insertEmployee1(vo1);
		
		int employee1_no = b5.selectEmployeeno(vo1.getEmployee1_code());
		
		vo2.setEmployee1_no(employee1_no);
		vo2.setTeam_no(team_no);
		vo2.setEmployee2_extension(employee2_extension);
		vo2.setEmployee2_position(employee2_position);
		vo2.setEmployee2_salary(employee2_salary);
		vo2.setEmployee2_holiday(employee2_holiday);
		vo2.setEmployee2_four(employee2_four);
		vo2.setEmployee2_worktype(employee2_worktype);
		vo2.setComcode_no(comcode_no);
		
		b5.insertEmployee2(vo2);
		
		vo.setComcode_no(comcode_no);
		vo.setEmployee1_no(employee1_no);
		vo.setTeam_no(team_no);
		
		b5.insertEmphistory(vo);
		
		return "redirect:/greeting?comcode_code=" + comcode_code;
	}
	
	@RequestMapping("/greeting/updateForm")
	public String greetingUpdateform(String type, String word, Model model, String comcode_code, int employee1_no) {
		int comcode_no = ls.comNo(comcode_code);
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("comcode_no", comcode_no);
		map.put("employee1_no", employee1_no);
		map.put("type", type);
		map.put("word", word);
		
		map = b5.selectEmployee2(map);
		
		List<Map<String, Object>> list = b5.selectEmployee(map);
		
		model.addAttribute("map", map);
		model.addAttribute("list", list);
		
		return "/b/b5/b51/list";
		
	}
	
	@RequestMapping("/greeting/update")
	public String greetingUpdate(String comcode_code, int employee1_no, 
			int employee2_no, String employee1_code, String employee1_name,
			String employee1_postal, String employee1_addr1,
			String employee1_addr2, String employee1_residentno,
			String employee1_phone, String employee1_email,
			String employee1_id, String employee1_pw,
			int employee1_disability, int employee1_merit,
			int team_no, String employee2_position, int employee2_exp,
			int employee2_salary, double employee2_holiday,
			String employee2_extension, int employee2_four
			, String employee2_worktype) {
		
		Map<String, Object> map = new HashMap<>();
		map.put("employee1_code", employee1_code);
		map.put("employee1_name", employee1_name);
		map.put("employee1_postal", employee1_postal);
		map.put("employee1_addr1", employee1_addr1);
		map.put("employee1_addr2", employee1_addr2);
		map.put("employee1_residentno", employee1_residentno);
		map.put("employee1_phone", employee1_phone);
		map.put("employee1_email", employee1_email);
		map.put("employee1_id", employee1_id);
		map.put("employee1_pw", employee1_pw);
		map.put("employee1_disability", employee1_disability);
		map.put("employee1_merit", employee1_merit);
		map.put("employee1_no", employee1_no);
		
		b5.updateEmployee1(map);
		
		Map<String, Object> map2 = new HashMap<>();
		map2.put("team_no", team_no);
		map2.put("employee2_position", employee2_position);
		map2.put("employee2_exp", employee2_exp);
		map2.put("employee2_salary", employee2_salary);
		map2.put("employee2_holiday", employee2_holiday);
		map2.put("employee2_extension", employee2_extension);
		map2.put("employee2_four", employee2_four);
		map2.put("employee2_worktype", employee2_worktype);
		map2.put("employee2_no", employee2_no);
		
		b5.updateEmployee2(map2);
		
		return "redirect:/greeting?comcode_code=" + comcode_code;
	}
	
	@RequestMapping("/greeting/attendance")
	public String attendance(Model model, String comcode_code, String type, String word) {
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		map.put("comcode_no", comcode_no);
		map.put("type", type);
		map.put("word", word);
		
		List<Map<String, Object>> list = b5.selectEmployee(map);
		model.addAttribute("list", list);
		return "/b/b5/b53/attendancelist";
	}
	
	@RequestMapping("/greeting/attendance/insertForm")
	public String insertForm(Model model, int employee2_no) {
		List<Erp_Employee1VO> list = b5.selectAttendance(employee2_no);
		model.addAttribute("employee2_no", employee2_no);
		model.addAttribute("list", list);
		return "/b/b5/b53/attendanceInsertForm";
	}
	
	@RequestMapping("/greeting/attendance/insert")
	public String insert(String comcode_code, int employee2_no, int hdkind_no, String attendance_start, String attendance_end, Erp_AttendanceVO vo, Erp_Employee2VO evo) {
		
		
		vo.setEmployee2_no(employee2_no);
		vo.setHdkind_no(hdkind_no);
		vo.setAttendance_start(attendance_start);
		vo.setAttendance_end(attendance_end);
		
		int su = b5.insertAttendance(vo);
		
		System.out.println(vo.getAttendance_end());
		System.out.println(vo.getAttendance_start());
		
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		
		Date start = null;
		Date end = null;
		
		try {
			start = format.parse(attendance_start);
			end = format.parse(attendance_end);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		int SATURDAY = Calendar.SATURDAY;
		int SUNDAY = Calendar.SUNDAY;
		
		Calendar calendar = Calendar.getInstance();
		
		calendar.setTime(start);
		
		int weekendDays = 0;
		
		while (!calendar.getTime().after(end)) {
            int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
            if (dayOfWeek == SATURDAY || dayOfWeek == SUNDAY) {
                weekendDays++;
            }
            calendar.add(Calendar.DAY_OF_MONTH, 1);
        }

        System.out.println(weekendDays);
    
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("attendance_start", attendance_start);
		map.put("attendance_end", attendance_end);
		map.put("employee2_no", employee2_no);
		map.put("hdkind_no", hdkind_no);
		
		double employee2_holiday = b5.selectLocal(map) - weekendDays;
		
		System.out.println(employee2_holiday);
		
		evo.setEmployee2_no(employee2_no);
		evo.setEmployee2_holiday(employee2_holiday);
		
		b5.updateHoliday(evo);
		
		return "redirect:/greeting/attendance?comcode_code=" + comcode_code;
		
	}
	
}

