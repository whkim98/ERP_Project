package com.lab.erp.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lab.erp.common.ViewPath;
<<<<<<< HEAD
import com.lab.erp.service.login.LoginService;
=======
import com.lab.erp.service.all.LoginService;
import com.lab.erp.vo.all.Erp_AdminVO;
>>>>>>> 1de0200e861394bcdda39aaa186f30682f2abea1

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class LoginController {
	private LoginService ls;
	
	@Autowired
	public LoginController(LoginService ls) {
		this.ls = ls;
	}
	
	@RequestMapping("/login/check")
	public String check(HttpServletRequest request, String admin_id, String admin_pw) {
		Map<String, Object> map = new HashMap<>();
		
		map.put("admin_id", admin_id);
		map.put("admin_pw", admin_pw);
		int su = ls.checkAdmin(map);
		
		String msg = null;
		String url = null;
		
		switch(su) {
		case 0: msg = "아이디 또는 비밀번호가 틀렸습니다"; url = ViewPath.LOGIN + "login.jsp"; break;
		case 1: request.getSession().setAttribute("admin", su); msg = "관리자로 로그인 하셨습니다"; 
				url = "/WEB-INF/views/index.jsp"; break;
		case 2: request.getSession().setAttribute("planningtop", su); msg = "기획본부장으로 로그인 하셨습니다";
				url = "/WEB-INF/views/index.jsp"; break;
		case 3: request.getSession().setAttribute("managementplanning", su); msg = "경영기획팀으로 로그인 하셨습니다";
				url = "/WEB-INF/views/index.jsp"; break;
		case 4: request.getSession().setAttribute("strategicplanning", su); msg = "전략기획팀으로 로그인 하셨습니다";
				url = "/WEB-INF/views/index.jsp"; break;
		case 5: request.getSession().setAttribute("managementtop", su); msg = "관리본부장으로 로그인 하셨습니다";
				url = "/WEB-INF/views/index.jsp"; break;
		case 6: request.getSession().setAttribute("account", su); msg = "회계팀으로 로그인 하셨습니다";
				url = "/WEB-INF/views/index.jsp"; break;
		case 7: request.getSession().setAttribute("finance", su); msg = "재무팀으로 로그인 하셨습니다";
				url = "/WEB-INF/views/index.jsp"; break;
		case 8: request.getSession().setAttribute("greeting", su); msg = "인사팀으로 로그인 하셨습니다";
				url = "/WEB-INF/views/index.jsp"; break;
		case 9: request.getSession().setAttribute("gunradish", su); msg = "총무팀으로 로그인 하셨습니다";
				url = "/WEB-INF/views/index.jsp"; break;
		case 10: request.getSession().setAttribute("salestop", su); msg = "영업본부장으로 로그인 하셨습니다";
				url = "/WEB-INF/views/index.jsp"; break;
		case 11: request.getSession().setAttribute("internationalsales", su); msg = "해외영업팀으로 로그인 하셨습니다";
				url = "/WEB-INF/views/index.jsp"; break;
		case 12: request.getSession().setAttribute("domesticsales", su); msg = "국내영업팀으로 로그인 하셨습니다";
				url = "/WEB-INF/views/index.jsp"; break;
		case 13: request.getSession().setAttribute("storesales", su); msg = "매장영업팀으로 로그인 하셨습니다";
				url = "/WEB-INF/views/index.jsp"; break;
		case 14: request.getSession().setAttribute("businessmanagement", su); msg = "영업관리팀으로 로그인 하셨습니다";
				url = "/WEB-INF/views/index.jsp"; break;
		case 15: request.getSession().setAttribute("supporttop", su); msg = "지원본부장으로 로그인 하셨습니다";
				url = "/WEB-INF/views/index.jsp"; break;
		case 16: request.getSession().setAttribute("production", su); msg = "생산팀으로 로그인 하셨습니다";
				url = "/WEB-INF/views/index.jsp"; break;
		case 17: request.getSession().setAttribute("purchase", su); msg = "구매팀으로 로그인 하셨습니다";
				url = "/WEB-INF/views/index.jsp"; break;
		case 18: request.getSession().setAttribute("quality", su); msg = "품질관리팀으로 로그인 하셨습니다";
				url = "/WEB-INF/views/index.jsp"; break;	
		case 19: request.getSession().setAttribute("distribution", su); msg = "물류팀으로 로그인 하셨습니다";
				url = "/WEB-INF/views/index.jsp"; break;
		default: msg = "신설 팀입니다"; url = "/WEB-INF/views/index.jsp"; break;
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		
		return ViewPath.RESULT + "loginresult.jsp";
	}
}
