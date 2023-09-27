package com.lab.erp.controller.intranet;

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

import com.lab.erp.common.ViewPath;
import com.lab.erp.service.intranet.IntranetService;
import com.lab.erp.service.login.LoginService;
import com.lab.erp.vo.all.Erp_ComcodeVO;
import com.lab.erp.vo.login.Erp_Employee1VO;


@Controller
public class IntranetLoginController {
	private LoginService ls;
	private IntranetService is;
	private HttpServletRequest request;

	@Autowired
	public IntranetLoginController(LoginService ls, IntranetService is, HttpServletRequest request) {
		this.is = is;
		this.ls = ls;
		this.request = request;
	}
	
	@RequestMapping("/intranet/check")
	public String intranetCheck(Erp_Employee1VO vo, String comcode_code) {
		try {
			Map<String, Object> map = new HashMap<>();
									
			map.put("employee1_id", vo.getEmployee1_id());
			map.put("employee1_pw", vo.getEmployee1_pw());
			map.put("comcode_code_intranet", vo.getComcode_code());

			int su = is.checkEmp(map);

			if (su != 0) {
				Map<String, Object> name = is.getEmpName(map);
				request.getSession().setAttribute("Intralogin", su);
				request.getSession().setAttribute("chatNickName", name.get("team_name") + " " + name.get("employee1_name"));
				request.getSession().setAttribute("empNo", name.get("employee2_no"));
				request.getSession().setAttribute("Intranetlogin", name.get("employee1_no"));
				request.getSession().setAttribute("comcode_code", comcode_code);
				
				String msg = null;
				String url = null;
				
				msg = name.get("employee1_name") + "님이 로그인 하셨습니다.";
				url = "/intranet/intranetMain";
				
				request.setAttribute("msg", msg);
				request.setAttribute("url", url);
				
				return "result/loginresult";
			}else {
				String msg = null;
				String url = null;
				
				msg = "아이디 또는 비밀번호가 틀렸습니다"; 
				url = "/";
				
				request.setAttribute("msg", msg);
				request.setAttribute("url", url);
				
				return "result/loginresult";
			}
					
		}catch(Exception e) {
				
				e.printStackTrace();
				
				String msg = null;
				String url = null;
				
				msg = "아이디 또는 비밀번호가 틀렸습니다."; 
				url = "/";
				
				request.getSession().invalidate();
				
				request.setAttribute("msg", msg);
				request.setAttribute("url", url);
				
				return "result/loginresult";
			}
		}
	
	@RequestMapping("/check")
	public String check(HttpServletRequest request, Erp_Employee1VO vo, String comcode_code) {
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("employee1_id", vo.getEmployee1_id());
			map.put("employee1_pw", vo.getEmployee1_pw());
			
			int no = ls.checkEmp(map);
			Map<String, Object> name = is.getEmpName(map);
			String msg = null;
			String url = null;
			
			msg = name.get("employee1_name") + "님이 로그인 하셨습니다.";
			url = "intranet/";
			
			request.getSession().setAttribute("chatNickName", name.get("team_name") + " " + name.get("employee1_name"));
			request.getSession().setAttribute("empNo", name.get("employee2_no"));
			
			request.getSession().setAttribute("comcode_code", comcode_code);
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return "result/loginresult";
			
		}catch(Exception e) {
			e.printStackTrace();
			String msg = null;
			String url = null;
			
			msg = "로그인 중 오류가 발생했습니다."; 
			url = "/";
			
			request.getSession().invalidate();
			
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			
			return "result/loginresult";
		}
	}
	
	@RequestMapping("/intranet/searchcode")
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
		return "intranet/comcode";
	}
		
	@GetMapping("/intranet/logout")
	public String logout(HttpSession session) {
		request.getSession().removeAttribute("Intralogin");
		request.getSession().removeAttribute("chatNickName");
		request.getSession().removeAttribute("empNo");
		request.getSession().removeAttribute("Intranetlogin");
		request.getSession().removeAttribute("comcode_code");
		
	    return "redirect:/"; 
	}
	
	@RequestMapping("/intranet/inputPw")
	public String inputPw(Erp_Employee1VO vo, Model model) {
		Map<String, Object> map = is.selectEmp(vo.getEmployee2_no());
		
		model.addAttribute("map", map);
		
		return ViewPath.INTRANET + "mypage/mypage";
	}
	
	@RequestMapping("/intranet/updatePw")
	@Transactional
	public String updatePw(Erp_Employee1VO vo, Model model, String new_employee1_pw) {
		String msg = null;
		String url = null;
		
		vo.setEmployee1_pw(new_employee1_pw);
		
		int update = is.updateEmpPw(vo);
		
		if(update != 0) {
			msg = "비밀번호가 변경되었습니다. 다시 로그인해주세요.";
			url = "/";
			
			request.getSession().removeAttribute("Intralogin");
			request.getSession().removeAttribute("chatNickName");
			request.getSession().removeAttribute("empNo");
			request.getSession().removeAttribute("Intranetlogin");
			request.getSession().removeAttribute("comcode_code");
			
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			
			return "result/loginresult";
		}else {
			return "redirect:/intranet/inputPw?employee2_no="+vo.getEmployee2_no();
		}
		
	}
	
	@RequestMapping("/intranet/checkCurrPw")
	@ResponseBody
	public String checkCurrPw(Erp_Employee1VO vo) {
		try {
			is.checkCurrPw(vo);
			
			return "변경할 비밀번호를 입력해주세요.";
		}catch(Exception e) {
			return "비밀번호가 일치하지 않습니다. 다시 입력해주세요.";
		}
	}
    
}
