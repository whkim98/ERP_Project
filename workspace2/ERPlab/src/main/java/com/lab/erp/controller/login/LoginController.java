package com.lab.erp.controller.login;

import java.time.LocalTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.lab.erp.common.ViewPath;
import com.lab.erp.service.login.LoginService;
import com.lab.erp.vo.all.Erp_ComcodeVO;


@Controller
public class LoginController {
	private LoginService ls;
	
	@Autowired
	public LoginController(LoginService ls) {
		this.ls = ls;
	}
	
	@RequestMapping("/login/check")
	public String check(HttpServletRequest request, String admin_id, String admin_pw, String comcode_code) {
		try {
			Map<String, Object> map = new HashMap<>();
			
			int comcode_no = ls.comNo(comcode_code);
			
			System.out.println(comcode_no);
			map.put("admin_id", admin_id);
			map.put("admin_pw", admin_pw);
			map.put("comcode_no", comcode_no);
			
			int su = ls.checkAdmin(map);
			
			String msg = null;
			String url = null;
			
			switch(su) {
			case 1: request.getSession().setAttribute("login", su); msg = "관리자로 로그인 하셨습니다"; 
			url = "/index"; break;
			case 2: request.getSession().setAttribute("login", su); msg = "기획본부장으로 로그인 하셨습니다";
			url = "/index"; break;
			case 3: request.getSession().setAttribute("login", su); msg = "경영기획팀으로 로그인 하셨습니다";
			url = "/index"; break;
			case 4: request.getSession().setAttribute("login", su); msg = "전략기획팀으로 로그인 하셨습니다";
			url = "/index"; break;
			case 5: request.getSession().setAttribute("login", su); msg = "관리본부장으로 로그인 하셨습니다";
			url = "/index"; break;
			case 6: request.getSession().setAttribute("login", su); msg = "회계팀으로 로그인 하셨습니다";
			url = "/index"; break;
			case 7: request.getSession().setAttribute("login", su); msg = "재무팀으로 로그인 하셨습니다";
			url = "/index"; break;
			case 8: request.getSession().setAttribute("login", su); msg = "인사팀으로 로그인 하셨습니다";
			url = "/index"; break;
			case 9: request.getSession().setAttribute("login", su); msg = "총무팀으로 로그인 하셨습니다";
			url = "/index"; break;
			case 10: request.getSession().setAttribute("login", su); msg = "영업본부장으로 로그인 하셨습니다";
			url = "/index"; break;
			case 11: request.getSession().setAttribute("login", su); msg = "해외영업팀으로 로그인 하셨습니다";
			url = "/index"; break;
			case 12: request.getSession().setAttribute("login", su); msg = "국내영업팀으로 로그인 하셨습니다";
			url = "/index"; break;
			case 13: request.getSession().setAttribute("login", su); msg = "매장영업팀으로 로그인 하셨습니다";
			url = "/index"; break;
			case 14: request.getSession().setAttribute("login", su); msg = "영업관리팀으로 로그인 하셨습니다";
			url = "/index"; break;
			case 15: request.getSession().setAttribute("login", su); msg = "지원본부장으로 로그인 하셨습니다";
			url = "/index"; break;
			case 16: request.getSession().setAttribute("login", su); msg = "생산팀으로 로그인 하셨습니다";
			url = "/index"; break;
			case 17: request.getSession().setAttribute("login", su); msg = "구매팀으로 로그인 하셨습니다";
			url = "/index"; break;
			case 18: request.getSession().setAttribute("login", su); msg = "품질관리팀으로 로그인 하셨습니다";
			url = "/index"; break;	
			case 19: request.getSession().setAttribute("login", su); msg = "물류팀으로 로그인 하셨습니다";
			url = "/index"; break;
			default: msg = "신설 팀입니다"; request.getSession().setAttribute("login", su); 
			url = "/index"; break;
			}
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
	
	@RequestMapping("/login/searchcode")
	public String searchcode(Model model, String type, String word) {
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("type", type);
		map.put("word", word);
		
		
		List<Erp_ComcodeVO> list = ls.comCodeList(map);
		model.addAttribute("list", list);
		return "window/comcode";
	}
		
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		
	    return "redirect:/"; 
	}
	

    
}
