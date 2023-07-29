package com.lab.erp.controller.a;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lab.erp.common.Paging;
import com.lab.erp.common.ViewPath;
import com.lab.erp.service.a.A3Service;
import com.lab.erp.service.login.AdminService;
import com.lab.erp.service.login.LoginService;
import com.lab.erp.vo.a.a3.Erp_ContractVO;
import com.lab.erp.vo.a.a3.Erp_ProjectVO;
import com.lab.erp.vo.a.a3.Erp_ProjectkindVO;
import com.lab.erp.vo.login.Erp_Employee1VO;
import com.lab.erp.vo.login.Erp_TeamVO;

@RequestMapping("/a/a3/a31")
@Controller
public class A3Controller {
	private A3Service a3;
	private LoginService ls;
	private AdminService as;
	
	@Autowired
	public A3Controller(A3Service a3, LoginService ls, AdminService as) {
		this.a3 = a3;
		this.ls = ls;
		this.as = as;
	}

	@RequestMapping("/")
	public String projectList(Model model, String comcode_code, Integer page, String type, String word) {
		int comcode_no = ls.comNo(comcode_code);
		if(page == null) {
			page = 1;
		}
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("type",type);
		map.put("word",word);
		map.put("comcode_no", comcode_no);
		
		int boardCount = a3.getTotal(map);
		
		Paging paging = new Paging(page, boardCount);
	
		map.put("first", paging.getFirst());
		map.put("last", paging.getLast());
		
		List<Map<String, Object>> list = a3.searchList(map);
		
		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
		
		return ViewPath.A3 + "list";
	}
	
	@RequestMapping("/inputProject")
	public String inputProject(Model model) {
		List<Erp_TeamVO> tlist = as.teamList();
		List<Erp_ProjectkindVO> pklist = a3.kindList();
		
		model.addAttribute("tlist", tlist);
		model.addAttribute("pklist", pklist);
		
		return ViewPath.A3 + "inputProject";
	}
	
	@RequestMapping("/createProject")
	public String createProject(Model model, Erp_ProjectVO vo, String team_name, String projectkind_name, String comcode_code) {
		int comcode_no = ls.comNo(comcode_code);
		
		int insert = a3.createProject(vo, team_name, projectkind_name, comcode_no);
		
		String msg = null;
		String url = null;
		
		if(insert != 0) {
			msg = "프로젝트가 정상적으로 등록되었습니다.";
			url = "/createProject";
		}else {
			msg = "프로젝트 등록에 실패하였습니다. 지속적으로 문제가 발생한다면 관리자에게 연락주시기 바랍니다.";
			url = "/createProject";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return ViewPath.RESULT + "loginresult";
	}
	
	@RequestMapping("/updateForm")
	public String updateForm(Model model, String project_no) {
		int prNo = Integer.parseInt(project_no);
		
		Map<String, Object> map = a3.selectProject(prNo);
		if(map.isEmpty()) {
			map = null;
		}
		
		List<Erp_TeamVO> tlist = as.teamList();
		List<Erp_ProjectkindVO> pklist = a3.kindList();
		
		model.addAttribute("tlist", tlist);
		model.addAttribute("pklist", pklist);
		model.addAttribute("map", map);

		return ViewPath.A3 + "updateForm";
	}
	
	@RequestMapping("/update")
	public String updateProject(Model model, Erp_ProjectVO vo, String team_name, String projectkind_name, String comcode_code) {
		int comcode_no = ls.comNo(comcode_code);
		
		int update = a3.updateProject(vo, team_name, projectkind_name, comcode_no);
		
		String msg = null;
		String url = null;
		
		if(update != 0) {
			msg = "프로젝트가 정상적으로 수정되었습니다.";
			url = "/a/a3/a31/content";
		}else {
			msg = "프로젝트 수정에 실패하였습니다. 지속적으로 문제가 발생한다면 관리자에게 연락주시기 바랍니다.";
			url = "/a/a3/a31/updateForm?project_no=" + vo.getProject_no();
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return ViewPath.RESULT + "loginresult";
	}
	
	@RequestMapping("/delete")
	public String deleteProject(Model model, String project_no) {
		int prNo = Integer.parseInt(project_no);
		
		String msg = null;
		String url = null;
		
		List<Erp_ContractVO> list = a3.prContract(prNo);
		
		if(!list.isEmpty()) {
			a3.deleteContract(prNo);			
		}
		
		int delete = a3.deleteProject(prNo);
		if(delete != 0) {
			msg = "프로젝트가 정상적으로 삭제되었습니다.";
			url = "/a/a3/a31/list";
		}else {
			msg = "프로젝트 삭제에 실패하였습니다. 지속적으로 문제가 발생한다면 관리자에게 연락주시기 바랍니다.";
			url = "/a/a3/a31/content?project_no=" + project_no;
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return ViewPath.RESULT + "loginresult";
	}
	
	@RequestMapping("/content")
	public String selectProject(Model model, String project_no) {
		int prNo = Integer.parseInt(project_no);
		
		Map<String, Object> map = a3.selectProject(prNo);
		if(map.isEmpty()) {
			map = null;
		}
		
		model.addAttribute("list", map);
		
		return ViewPath.A3 + "content";
	}
	
	@RequestMapping("/searchemp")
	public String searchemp(Model model, String employee1_name, String comcode_code) {
		Map<String, Object> map = new HashMap<>();
		
		map.put("employee1_name", employee1_name);
		map.put("comcode_code", comcode_code);
		
		List<Erp_Employee1VO> list = a3.empList(map);
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "empList";
	}
	
	@RequestMapping("/kind")
	public String kind(Model model) {
		List<Erp_ProjectkindVO> list = a3.kindList();
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "kindList";
	}
	
	@RequestMapping("/team")
	public String team(Model model) {
		List<Erp_TeamVO> list = as.teamList();
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "teamList";
	}
}
