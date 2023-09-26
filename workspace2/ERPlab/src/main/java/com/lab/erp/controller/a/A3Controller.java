package com.lab.erp.controller.a;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.exceptions.TooManyResultsException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lab.erp.common.Paging;
import com.lab.erp.common.ViewPath;
import com.lab.erp.service.a.A3Service;
import com.lab.erp.service.login.AdminService;
import com.lab.erp.service.login.LoginService;
import com.lab.erp.vo.a.a3.Erp_ContractVO;
import com.lab.erp.vo.a.a3.Erp_ContractkindVO;
import com.lab.erp.vo.a.a3.Erp_EstimateVO;
import com.lab.erp.vo.a.a3.Erp_ProjectVO;
import com.lab.erp.vo.a.a3.Erp_ProjectkindVO;
import com.lab.erp.vo.c.Erp_ClientVO;
import com.lab.erp.vo.login.Erp_Employee1VO;
import com.lab.erp.vo.login.Erp_TeamVO;

import jakarta.servlet.http.HttpServletRequest;

@RequestMapping("/a/a3")
@Controller
public class A3Controller {
	private A3Service a3;
	private LoginService ls;
	private AdminService as;
	private HttpServletRequest request;
	
	@Autowired
	public A3Controller(A3Service a3, LoginService ls, AdminService as, HttpServletRequest request) {
		this.a3 = a3;
		this.ls = ls;
		this.as = as;
		this.request = request;
	}
	
	
	@RequestMapping("/a31/inputProject")
	public String inputProject(Model model, String type, String word, String comcode_code) {
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		
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
		
		map.put("type",type);
		map.put("word",word);
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> list = a3.searchList(map);
		
		model.addAttribute("list", list);
		
		return ViewPath.A3 + "/a31/inputProject";
	}
	
	@RequestMapping("/a31/projectAjax")
	@ResponseBody
	public List<Map<String, Object>> projectAjax(String type, String word, String comcode_code) {
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		int comcode_no = ls.comNo(comcode_code);
		
		map.put("type",type);
		map.put("word",word);
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> list = a3.searchList(map);
		
		return list;
	}
	
//	프로젝트 관리
	@RequestMapping("/a31/createProject")
	@Transactional
	public String createProject(Model model, Erp_ProjectVO vo, String comcode_code) {
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
		
		a3.createProject(vo);
		
		return "redirect:/a/a3/a31/inputProject?comcode_code="+comcode_code;
	}
	
	@RequestMapping("/a31/updateFormP")
	public String updateForm(Model model, Erp_ProjectVO vo, String type, String word, String comcode_code) {
		int prNo = vo.getProject_no();
		
		Map<String, Object> inmap = a3.selectProject(prNo);
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		
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
		
		map.put("type",type);
		map.put("word",word);
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> list = a3.searchList(map);
		
		model.addAttribute("list", list);
		model.addAttribute("inmap", inmap);

		return ViewPath.A3 + "/a31/inputProject";
	}
	
	@RequestMapping("/a31/update")
	@Transactional
	public String updateProject(Model model, Erp_ProjectVO vo, String comcode_code) {
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
		
		a3.updateProject(vo);
		
		return "redirect:/a/a3/a31/updateFormP?project_no="+vo.getProject_no()+"&comcode_code="+comcode_code;
	}
	
	@RequestMapping("/a31/delete")
	@Transactional
	public String deleteProject(Model model, String project_no, String comcode_code) {
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
		
		int prNo = Integer.parseInt(project_no);
		
		a3.deleteProject(prNo);
		
		return "redirect:/a/a3/a31/inputProject?comcode_code="+comcode_code;
	}
	
	@RequestMapping("/a31/searchemp")
	public String searchemp(Model model, String comcode_code) {
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
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("comcode_code", comcode_code);
		
		List<Erp_Employee1VO> list = a3.empList(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "a/a3/a31/empList";
	}
	
	@RequestMapping("/a31/searchempAjax")
	@ResponseBody
	public List<Erp_Employee1VO> searchempAjax(String comcode_code, String type, String word) {
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_code", comcode_code);
		
		List<Erp_Employee1VO> list = a3.empList(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		return list;
	}
	
	@RequestMapping("/a31/searchpk")
	public String searchpk(Model model, String type, String word) {
		Map<String, Object> map = new HashMap<>();
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		map.put("type", type);
		map.put("word", word);
		
		List<Erp_ProjectkindVO> list = a3.kindList(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "a/a3/a31/kindList";
	}
	
	@RequestMapping("/a31/searcht")
	public String searcht(Model model, String type, String word) {
		Map<String, Object> map = new HashMap<>();
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		map.put("type", type);
		map.put("word", word);
		
		List<Erp_TeamVO> list = a3.teamList(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "a/a3/a31/teamList";
	}
	
	@RequestMapping("/a31/searchtAjax")
	@ResponseBody
	public List<Erp_TeamVO> searchtAjax(String type, String word) {
		Map<String, Object> map = new HashMap<>();
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		map.put("type", type);
		map.put("word", word);
		
		List<Erp_TeamVO> list = a3.teamList(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		return list;
	}
	
	@RequestMapping("/a31/kind")
	@ResponseBody
	public Erp_ProjectkindVO kind(Model model, String projectkind_name) {
		
		try {
			Erp_ProjectkindVO vo = a3.kindName(projectkind_name);
			model.addAttribute("vo", vo);
			
			return vo;
		}catch(Exception e) {
			return null;
		}
		
	}
	
	@RequestMapping("/a31/team")
	@ResponseBody
	public Erp_TeamVO team(Model model, String team_name) {
		try {
			Erp_TeamVO vo = a3.teamName(team_name);
			model.addAttribute("vo", vo);
			
			return vo;
		}catch(Exception e) {
			return null;
		}
	}
	
//	계약 관리
	@RequestMapping("/a32/inputContract")
	public String inputContract(String type, String word, String comcode_code, Model model) {
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
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("comcode_no", comcode_no);
		map.put("type",type);
		map.put("word",word);
		
		List<Map<String, Object>> list = a3.prContractList(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		model.addAttribute("list", list);
		
		return ViewPath.A3 + "/a32/inputContract";
	}
	
	@RequestMapping("/a32/contractAjax")
	@ResponseBody
	public List<Map<String, Object>> contractAjax(String type, String word, String comcode_code) {
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("comcode_no", comcode_no);
		map.put("type",type);
		map.put("word",word);
		
		List<Map<String, Object>> list = a3.prContractList(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		return list;
	}
	
	@RequestMapping("/a32/createContract")
	@Transactional
	public String createContract(Model model, Erp_ContractVO vo, String comcode_code) {
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
		
		a3.createContract(vo);
		
		return "redirect:/a/a3/a32/inputContract?comcode_code="+comcode_code;
	}
	
	@RequestMapping("/a32/update")
	@Transactional
	public String updateContract(Model model, Erp_ContractVO vo, String comcode_code) {
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
		
		a3.updateContract(vo);
		
		return "redirect:/a/a3/a32/updateForm?comcode_code="+comcode_code+"&contract_no="+vo.getContract_no();
	}
	
	@RequestMapping("/a32/delete")
	@Transactional
	public String deleteContract(Model model, Erp_ContractVO vo, String comcode_code) {
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
		
		a3.deleteContract(vo.getContract_no());
		
		return "redirect:/a/a3/a32/inputContract?comcode_code="+comcode_code;
	}
	
	@RequestMapping("/a32/updateForm")
	public String selectContract(Model model, Erp_ContractVO vo,String type, String word, String comcode_code) {
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
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("comcode_no", comcode_no);
		map.put("type",type);
		map.put("word",word);
		
		List<Map<String, Object>> list = a3.prContractList(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		Map<String, Object> inmap = a3.selectContract(vo.getContract_no());
		
		model.addAttribute("list", list);
		model.addAttribute("inmap", inmap);
		
		return ViewPath.A3 + "/a32/inputContract";
	}
	
	@RequestMapping("/a32/clList")
	public String clList(Model model, String type, String word, String comcode_code) {
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
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		map.put("type", type);
		map.put("word", word);
		
		map.put("comcode_no", comcode_no);
		
		List<Erp_ClientVO> list = a3.clList(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "a/a3/a32/clList";
	}
	
	@RequestMapping("/a32/clListAjax")
	@ResponseBody
	public List<Erp_ClientVO> clListAjax(String type, String word, String comcode_code) {
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		map.put("type", type);
		map.put("word", word);
		
		map.put("comcode_no", comcode_no);
		
		List<Erp_ClientVO> list = a3.clList(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		return list;
	}
	@RequestMapping("/a32/prList")
	public String prList(Model model, String type, String word, String comcode_code) {
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
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}else {
			if(type.contains("status")) {
				if(word.contains("미완")) {
					map.put("word", 0);
				}else if(word.contains("진행")) {
					map.put("word", 2);
				}else if(word.contains("완료")){
					map.put("word", 1);
				}else {
					word = null;
				}
			}
		}
		
		map.put("type", type);
		map.put("word", word);
		
		map.put("comcode_no", comcode_no);
		
		List<Erp_ProjectVO> list = a3.prList(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "a/a3/a32/prList";
	}
	
	@RequestMapping("/a32/prListAjax")
	@ResponseBody
	public List<Erp_ProjectVO> prListAjax32(String type, String word, String comcode_code) {
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}else {
			if(type.contains("status")) {
				if(word.contains("미완")) {
					map.put("word", 0);
				}else if(word.contains("진행")) {
					map.put("word", 2);
				}else if(word.contains("완료")){
					map.put("word", 1);
				}else {
					word = null;
				}
			}
		}
		
		map.put("type", type);
		map.put("word", word);
		
		map.put("comcode_no", comcode_no);
		
		List<Erp_ProjectVO> list = a3.prList(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		return list;
	}
	
	@RequestMapping("/a32/ckList")
	public String ckList(Model model, String type, String word) {
		Map<String, Object> map = new HashMap<>();
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		map.put("type", type);
		map.put("word", word);
		
		List<Erp_ContractkindVO> list = a3.ckList(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "a/a3/a32/ckList";
	}
	
	
	@RequestMapping("/a32/searchcl")
	@ResponseBody
	public Erp_ClientVO searchcl(Model model, String client_name, String comcode_code) {
		try {
			int comcode_no = ls.comNo(comcode_code);
			
			Map<String, Object> map = new HashMap<>();
			
			map.put("comcode_no", comcode_no);
			map.put("client_name", client_name);
			
			Erp_ClientVO vo = a3.getCl(map);
			
			model.addAttribute("vo", vo);
			
			return vo;
		}catch(Exception e) {
			return null;
		}
	}
	
	@RequestMapping("/a32/searchpr")
	@ResponseBody
	public Erp_ProjectVO searchpr(Model model, String comcode_code, String project_name) {
		try {
			int comcode_no = ls.comNo(comcode_code);
			
			Map<String, Object> map = new HashMap<>();
			
			map.put("comcode_no", comcode_no);
			map.put("project_name", project_name);
			
			Erp_ProjectVO vo = a3.getProject(map);
			
			model.addAttribute("vo", vo);
			
			return vo;
		}catch(Exception e) {
			return null;
		}
	}
	
	@RequestMapping("/a32/searchck")
	@ResponseBody
	public Erp_ContractkindVO ckName(Model model, String contractkind_name) {
		try {
			Erp_ContractkindVO vo = a3.getCk(contractkind_name);
			model.addAttribute("vo", vo);
			
			return vo;
		}catch(Exception e) {
			return null;
		}
	}
	
//	실적 / 평가
	@RequestMapping("/a33/inputEstimate")
	public String estimateList(Model model, String type, String word, String comcode_code) {
		Map<String, Object> map = new HashMap<>();
		
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
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		map.put("type",type);
		map.put("word",word);
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> list = a3.estimateList(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		model.addAttribute("list", list);
		
		return ViewPath.A3 + "/a33/inputEstimate";
	}
	
	@RequestMapping("/a33/estimateAjax")
	@ResponseBody
	public List<Map<String, Object>> estimateAjax(String type, String word, String comcode_code) {
		Map<String, Object> map = new HashMap<>();
		
		int comcode_no = ls.comNo(comcode_code);
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		map.put("type",type);
		map.put("word",word);
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> list = a3.estimateList(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		return list;
	}
	
	@RequestMapping("/a33/createEstimate")
	@Transactional
	public String createEstimate(Model model, Erp_EstimateVO vo, String comcode_code) {
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
		
		a3.createEstimate(vo);
		
		return "redirect:/a/a3/a33/inputEstimate?comcode_code="+comcode_code;
	}
	
	@RequestMapping("/a33/updateForm")
	public String updateFormE(Model model, Erp_EstimateVO vo, String comcode_code, String type, String word) {
		Map<String, Object> map = new HashMap<>();
		
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
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		map.put("type",type);
		map.put("word",word);
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> list = a3.estimateList(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		model.addAttribute("list", list);
		
		Map<String, Object> vomap = new HashMap<>();
		
		vomap.put("estimate_no", vo.getEstimate_no());
		
		Map<String, Object> inmap = a3.selectEstimate(vomap);
		
		model.addAttribute("inmap", inmap);
		
		return ViewPath.A3 + "/a33/inputEstimate";
	}
	
	@RequestMapping("/a33/update")
	@Transactional
	public String updateEstimate(Model model, Erp_EstimateVO vo, String comcode_code) {
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
		
		a3.updateEstimate(vo);
		
		return "redirect:/a/a3/a33/updateForm?estimate_no="+vo.getEstimate_no();
	}
	
	@RequestMapping("/a33/delete")
	@Transactional
	public String deleteEstimate(Model model, Erp_EstimateVO vo, String comcode_code) {
		a3.deleteEstimate(vo.getEstimate_no());
		
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
		
		return "redirect:/a/a3/a33/inputEstimate?comcode_code="+comcode_code;
	}
	
	@RequestMapping("/a33/searchpr")
	@ResponseBody
	public Erp_ProjectVO searchpr2(Model model, String project_name, String comcode_code) {
		try {
			int comcode_no = ls.comNo(comcode_code);
			
			Map<String, Object> map = new HashMap<>();
			
			map.put("comcode_no", comcode_no);
			map.put("project_name", project_name);
			
			Erp_ProjectVO vo = a3.getProject(map);
			
			return vo;
		}catch(Exception e) {
			return null;
		}
	}
	
	@RequestMapping("/a33/prList")
	public String prList1(Model model, String type, String word, String comcode_code) {
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
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}else {
			if(type.contains("status")) {
				if(word.contains("미완")) {
					map.put("word", 0);
				}else if(word.contains("진행")) {
					map.put("word", 2);
				}else if(word.contains("완료")){
					map.put("word", 1);
				}else {
					word = null;
				}
			}
		}
		
		map.put("type", type);
		map.put("word", word);
		
		map.put("comcode_no", comcode_no);
		
		List<Erp_ProjectVO> list = a3.prList(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "a/a3/a33/prList";
	}
	
	@RequestMapping("/a33/prListAjax")
	@ResponseBody
	public List<Erp_ProjectVO> prListAjax33(String type, String word, String comcode_code) {
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}else {
			if(type.contains("status")) {
				if(word.contains("미완")) {
					map.put("word", 0);
				}else if(word.contains("진행")) {
					map.put("word", 2);
				}else if(word.contains("완료")){
					map.put("word", 1);
				}else {
					word = null;
				}
			}
		}
		
		map.put("type", type);
		map.put("word", word);
		
		map.put("comcode_no", comcode_no);
		
		List<Erp_ProjectVO> list = a3.prList(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		return list;
	}
}
