package com.lab.erp.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lab.erp.common.ViewPath;
import com.lab.erp.service.login.AdminService;
import com.lab.erp.service.login.LoginService;
import com.lab.erp.vo.login.Erp_AdminVO;
import com.lab.erp.vo.login.Erp_Employee1VO;
import com.lab.erp.vo.login.Erp_Employee2VO;
import com.lab.erp.vo.login.Erp_TeamVO;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	private AdminService as;
	private LoginService ls;
	private HttpServletRequest request;
	
	public AdminController(AdminService as, LoginService ls, HttpServletRequest request) {
		this.as = as;
		this.ls = ls;
		this.request = request;
	}
	
	
	@RequestMapping("/main")
	public String adminMain() {
		return ViewPath.ADMIN + "main";
	}
	
	
//	admin
	@RequestMapping("/inputAdmin")
	public String inputUser(Model model, String type, String word, String comcode_code) {
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		List<Erp_TeamVO> teamList = as.teamList(map);
		List<Map<String, Object>> list = as.adminList(map);
		
		if(list.isEmpty()) {
			list = null;
		}
		
		if(teamList.isEmpty()) {
			teamList = null;
		}
		
		model.addAttribute("list", list);
		model.addAttribute("teamList", teamList);
		
		return ViewPath.ADMIN + "inputAdmin";
	}
	
	@RequestMapping("/adminAjax")
	@ResponseBody
	public List<Map<String, Object>> adminAjax(String type, String word, String comcode_code){
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> list = as.adminList(map);
		
		if(list.isEmpty()) {
			list = null;
		}
		
		return list;
	}
	
	@RequestMapping("/teamAjax")
	@ResponseBody
	public List<Erp_TeamVO> teamAjax(String type, String word, String comcode_code){
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		List<Erp_TeamVO> teamList = as.teamList(map);
		
		if(teamList.isEmpty()) {
			teamList = null;
		}
		
		return teamList;
	}
	
	@RequestMapping("/updateFormAdmin")
	public String updateFormAdmin(Erp_AdminVO vo, String comcode_code, Model model, String type, String word) {
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		List<Erp_TeamVO> teamList = as.teamList(map);
		
		if(teamList.isEmpty()) {
			teamList = null;
		}
		
		Map<String, Object> selectAdmin = as.selectAdmin(vo.getAdmin_no());
		
		List<Map<String, Object>> list = as.adminList(map);
		
		if(list.isEmpty()) {
			list = null;
		}
		
		model.addAttribute("list", list);
		model.addAttribute("teamList", teamList);
		model.addAttribute("selectAdmin", selectAdmin);
		
		return ViewPath.ADMIN + "inputAdmin";
	}
	
	@RequestMapping("/createAdmin")
	public String createAdmin(Erp_AdminVO vo, String comcode_code, Model model) {
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		vo.setComcode_no(comcode_no);
		
		as.createAdmin(vo);
		
		return "redirect:/admin/inputAdmin?comcode_code="+comcode_code;
	}
	
	@RequestMapping("/updateAdmin")
	public String updateAdmin(Erp_AdminVO vo, String comcode_code, Model model) {
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		as.updateAdmin(vo);
		
		return "redirect:/admin/updateFormAdmin?admin_no="+vo.getAdmin_no()+"&comcode_code="+comcode_code;
	}
	
	@RequestMapping("/deleteAdmin")
	public String deleteAdmin(Erp_AdminVO vo, String comcode_code, Model model) {
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		as.deleteAdmin(vo.getAdmin_no());
		
		return "redirect:/admin/inputAdmin?comcode_code="+comcode_code;
	}
	
	
//	employee
	@RequestMapping("/inputEmployee")
	public String inputEmployee(Model model, String type, String word, String comcode_code) {
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		List<Erp_TeamVO> teamList = as.teamList(map);
		List<Map<String, Object>> list = as.EmpList(map);
		
		model.addAttribute("teamList", teamList);
		model.addAttribute("list", list);
		
		return ViewPath.ADMIN + "inputEmployee";
	}
	
	@RequestMapping("/updateFormEmployee")
	public String updateFormEmployee(Erp_Employee2VO vo, String comcode_code, Model model, String type, String word) {
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		List<Erp_TeamVO> teamList = as.teamList(map);
		List<Map<String, Object>> list = as.EmpList(map);
		
		model.addAttribute("teamList", teamList);
		model.addAttribute("list", list);
		
		Map<String, Object> selectEmployee = as.selectEmp(vo.getEmployee2_no());
		
		model.addAttribute("selectEmployee", selectEmployee);
		
		return ViewPath.ADMIN + "inputEmployee";
	}
	
	@RequestMapping("/createEmployee")
	@Transactional
	public String createEmployee(Erp_Employee1VO evo, Erp_Employee2VO e2vo, String comcode_code, Model model) {
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		e2vo.setComcode_no(comcode_no);
		
		as.createEmployee1(evo);
		as.createEmployee2(e2vo);
		
		return "redirect:/admin/inputEmployee?comcode_code="+comcode_code;
	}
	
	@RequestMapping("/updateEmployee")
	@Transactional
	public String updateEmployee(Erp_Employee1VO evo, Erp_Employee2VO e2vo, String comcode_code, Model model) {
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		as.updateEmp1(evo);
		as.updateEmp2(e2vo);
		
		return "redirect:/admin/updateFormEmployee?comcode_code="+comcode_code+"&employee2_no="+e2vo.getEmployee2_no();
	}
	
	@RequestMapping("/deleteEmployee")
	@Transactional
	public String deleteEmployee(Erp_Employee1VO evo, Erp_Employee2VO e2vo, String comcode_code, Model model) {
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		as.deleteEmp1(evo.getEmployee1_no());
		as.deleteEmp2(e2vo.getEmployee2_no());
		
		return "redirect:/admin/inputEmployee?comcode_code="+comcode_code;
	}
	
}
