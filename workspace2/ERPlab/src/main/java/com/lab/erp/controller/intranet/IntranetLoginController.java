package com.lab.erp.controller.intranet;

import java.time.LocalTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.lab.erp.common.ViewPath;
import com.lab.erp.service.intranet.IntranetService;
import com.lab.erp.service.login.LoginService;
import com.lab.erp.vo.all.Erp_ComcodeVO;
import com.lab.erp.vo.login.Erp_Employee1VO;


@Controller
@RequestMapping("/intranet")
public class IntranetLoginController {
	private LoginService ls;
	private IntranetService is;

	@Autowired
	public IntranetLoginController(LoginService ls) {
		this.ls = ls;
	}
	
	@RequestMapping("/")
	public String intranetMain() {
		return ViewPath.INTRANET + "main";
	}
	
	@RequestMapping("/check")
	public String check(HttpServletRequest request, Erp_Employee1VO vo, String comcode_code) {
		try {
			Map<String, Object> map = new HashMap<>();
			
			map.put("emploee1_id", vo.getEmployee1_id());
			map.put("emploee1_pw", vo.getEmployee1_pw());
			
			ls.checkEmp(map);
			
			Map<String, Object> name = is.getEmpName(vo.getEmployee1_id());
			
			String msg = null;
			String url = null;
			
			msg = name + "님이 로그인 하셨습니다.";
			url = "/index";
			
			request.getSession().setAttribute("chatNickName", name.get("team_name") + " " + name.get("employee1_name"));
			request.getSession().setAttribute("empNo", name.get("employee2_no"));
			
			System.out.println(request.getSession().getAttribute("chatNickName"));
			request.getSession().setAttribute("comcode_code", comcode_code);
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return "result/loginresult";
			
		}catch(Exception e) {
			String msg = null;
			String url = null;
			msg = "아이디 또는 비밀번호가 틀렸습니다"; 
			url = "/";
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return "result/loginresult";
		}
		
	}
		
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("empNo");
		session.removeAttribute("chatNickName");
		
	    return "redirect:/"; 
	}
	
	@RequestMapping("/inputPw")
	public String inputPw(Erp_Employee1VO vo, Model model) {
		Map<String, Object> map = is.selectEmp(vo.getEmployee2_no());
		
		model.addAttribute("map", map);
		
		return ViewPath.INTRANET + "inputPw";
	}
	
	@RequestMapping("/updatePw")
	@Transactional
	public String updatePw(Erp_Employee1VO vo, Model model) {
		is.updateEmpPw(vo);
		
		return "redirect:/intranet/inputPw?employee2_no="+vo.getEmployee2_no();
	}
    
}
