package com.lab.erp.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
public class AdminController {
	private AdminService as;
	private LoginService ls;
	private HttpServletRequest request;
	
	@Autowired
	public AdminController(AdminService as, LoginService ls, HttpServletRequest request) {
		this.as = as;
		this.ls = ls;
		this.request = request;
	}
	
	@RequestMapping("/admin")
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
		
		String comcode_name = as.getComcodeName(comcode_code);
		
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
		
		model.addAttribute("list", list);						// admin계정 list
		model.addAttribute("teamList", teamList);				// admin계정 등록 시 권한 부여할 때 띄울 erp_team List
		model.addAttribute("comcode_name", comcode_name);		// 고객사 이름
		
		return ViewPath.ADMIN + "admin";
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
		
		String comcode_name = as.getComcodeName(comcode_code);
		
		Map<String, Object> selectAdmin = as.selectAdmin(vo.getAdmin_no());
		
		model.addAttribute("selectAdmin", selectAdmin);				// admin List에서 선택한 사람의 정보
		model.addAttribute("comcode_name", comcode_name);			// 고객사 이름
		
		return ViewPath.ADMIN + "adminUpdate";
	}
	
	@RequestMapping("adminInsert")
	public String adminInsert(String comcode_code, Model model) {
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
		
		
		return ViewPath.ADMIN + "adminInsert";
	}
	
	@RequestMapping("/searcht")
	public String searcht(Model model, String type, String word) {
		Map<String, Object> map = new HashMap<>();
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		map.put("type", type);
		map.put("word", word);
		
		List<Erp_TeamVO> list = as.teamList(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "admin/teamList";
	}
	
	@RequestMapping("/checkAdminId")
	@ResponseBody
	public String checkAdminId(Erp_AdminVO vo) {
		try {
			int no = as.checkAdminId(vo.getAdmin_id());
			
			return "중복된 ID 입니다.";
		}catch(Exception e) {
			return "사용 가능한 ID 입니다.";
		}
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
		
		return "redirect:/admin?comcode_code="+comcode_code;			// insert되는 순간 admin계정 List에 추가된 상태로 등록창 띄움
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
		
		return "redirect:/updateFormAdmin?admin_no="+vo.getAdmin_no()+"&comcode_code="+comcode_code;		// update되는 순간 update된 admin 정보 띄움
	}

	/*
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
		
		return "redirect:/admin/inputAdmin?comcode_code="+comcode_code;					// delete되는 순간 admin계정 List에 삭제된 상태로 등록창 띄움
	}
	*/
	
	@RequestMapping("/deleteAdmin")
	public String deleteAdmin(@RequestParam("admin_no") String adminNo, 
	                          @RequestParam("comcode_code") String comcodeCode, 
	                          Model model) {
	    String msg = null;
	    String url = null;

	    if (comcodeCode == null || comcodeCode.isEmpty()) {
	        request.getSession().invalidate();
	        msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
	        url = "/";
	        model.addAttribute("msg", msg);
	        model.addAttribute("url", url);
	        return ViewPath.RESULT + "loginresult";
	    }

	    try {
	        int adminNoInt = Integer.parseInt(adminNo);
	        as.deleteAdmin(adminNoInt);
	    } catch (NumberFormatException e) {
	        // 정수로 변환할 수 없는 경우 처리
	        // 예외 처리 코드 추가
	    }

	    return "redirect:/admin?comcode_code=" + comcodeCode;
	}


	
	/*
	@PostMapping("/deleteAdmin")
    public String deleteAdmin(
    		@RequestParam("admin_no") int adminNo, 
            @RequestParam("comcode_code") String comcodeCode, Model model) {
        String msg = null;
        String url = null;

        if (comcodeCode == null || comcodeCode.isEmpty()) {
			request.getSession().invalidate();
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
        }

        as.deleteAdmin(adminNo);

        return "redirect:/admin/adminList?comcode_code=" + comcodeCode;
	}
	*/
	
	
//	employee
	
	@RequestMapping("/intranet")
	public String intranetAdmin() {
		
		return ViewPath.ADMIN + "intranet";
	}
	
	
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
		
		String comcode_name = as.getComcodeName(comcode_code);
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		List<Erp_TeamVO> teamList = as.teamList(map);
		List<Map<String, Object>> list = as.EmpList(map);
		
		model.addAttribute("comcode_name", comcode_name);				// 고객사 이름
		model.addAttribute("teamList", teamList);						// 직원 계정 등록 시 선택할 erp_team List
		model.addAttribute("list", list);								// 직원 List
		
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
		
		String comcode_name = as.getComcodeName(comcode_code);
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		List<Erp_TeamVO> teamList = as.teamList(map);
		List<Map<String, Object>> list = as.EmpList(map);
		Map<String, Object> selectEmployee = as.selectEmp(vo.getEmployee2_no());
		
		
		model.addAttribute("comcode_name", comcode_name);
		model.addAttribute("teamList", teamList);
		model.addAttribute("list", list);
		model.addAttribute("selectEmployee", selectEmployee);			// 직원List에서 선택한 직원의 정보
		
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
	
	@RequestMapping("/searchERPadminAll")
	public String searcherpadminall(Model model, String type, String word) {
		Map<String, Object> map = new HashMap<>();
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		map.put("type", type);
		map.put("word", word);
		
		List<Map<String, Object>> list = as.adminList(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		model.addAttribute("list", list);
		
		return ViewPath.ADMIN + "adminList";
	}
	
	
	
	
}
