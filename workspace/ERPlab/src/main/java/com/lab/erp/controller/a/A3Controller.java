package com.lab.erp.controller.a;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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

@RequestMapping("/a/a3")
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
	
	@RequestMapping("/a31/")
	public String projectList(Model model, String comcode_code, Integer page, String type, String word) {
		System.out.println(comcode_code);
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
		
		return ViewPath.A3 + "/a31/list";
	}
	
	@RequestMapping("/a31/inputProject")
	public String inputProject(Model model) {
		List<Erp_TeamVO> tlist = as.teamList();
		List<Erp_ProjectkindVO> pklist = a3.kindList();
		
		model.addAttribute("tlist", tlist);
		model.addAttribute("pklist", pklist);
		
		return ViewPath.A3 + "/a31/inputProject";
	}
	
//	프로젝트 관리
	@RequestMapping("/a31/createProject")
	public String createProject(Model model, Erp_ProjectVO vo, String comcode_code) {
		int comcode_no = ls.comNo(comcode_code);
		
		vo.setComcode_no(comcode_no);
		
		int insert = a3.createProject(vo);
		
		String msg = null;
		String url = null;
		
		if(insert != 0) {
			msg = "프로젝트가 정상적으로 등록되었습니다.";
			url = "/a/a3/a31/?comcode_code=" + comcode_code;
		}else {
			msg = "프로젝트 등록에 실패하였습니다. 지속적으로 문제가 발생한다면 관리자에게 문의주시기 바랍니다.";
			url = "/a/a3/a31//inputProject";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return ViewPath.RESULT + "loginresult";
	}
	
	@RequestMapping("/a31/updateFormP")
	public String updateForm(Model model, Erp_ProjectVO vo) {
		int prNo = vo.getProject_no();
		
		Map<String, Object> map = a3.selectProject(prNo);
		
		List<Erp_TeamVO> tlist = as.teamList();
		List<Erp_ProjectkindVO> pklist = a3.kindList();
		
		model.addAttribute("tlist", tlist);
		model.addAttribute("pklist", pklist);
		model.addAttribute("map", map);

		return ViewPath.A3 + "/a31/updateFormP";
	}
	
	@RequestMapping("/a31/update")
	public String updateProject(Model model, Erp_ProjectVO vo, String comcode_code) {
		int comcode_no = ls.comNo(comcode_code);
		
		vo.setComcode_no(comcode_no);
		
		int update = a3.updateProject(vo);
		
		String msg = null;
		String url = null;
		
		if(update != 0) {
			msg = "프로젝트가 정상적으로 수정되었습니다.";
			url = "/a/a3/a31/contentP?project_no=" + vo.getProject_no();
		}else {
			msg = "프로젝트 수정에 실패하였습니다. 지속적으로 문제가 발생한다면 관리자에게 문의주시기 바랍니다.";
			url = "/a/a3/a31/updateFormP?project_no=" + vo.getProject_no();
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return ViewPath.RESULT + "loginresult";
	}
	
	@RequestMapping("/a31/delete")
	public String deleteProject(Model model, String project_no, String comcode_code) {
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
			url = "/a/a3/a31/?comcode_code=" + comcode_code;
		}else {
			msg = "프로젝트 삭제에 실패하였습니다. 지속적으로 문제가 발생한다면 관리자에게 문의주시기 바랍니다.";
			url = "/a/a3/a31/contentP?project_no=" + prNo;
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return ViewPath.RESULT + "loginresult";
	}
	
	@RequestMapping("/a31/contentP")
	public String selectProject(Model model, Erp_ProjectVO vo) {
		int prNo = vo.getProject_no();
		
		Map<String, Object> map = a3.selectProject(prNo);
		if(map.isEmpty()) {
			map = null;
		}
		
		model.addAttribute("map", map);
		
		return ViewPath.A3 + "/a31/content";
	}
	
	@RequestMapping("/a31/searchemp")
	public String searchemp(Model model, String employee1_name, String comcode_code) {
		Map<String, Object> map = new HashMap<>();
		
		map.put("employee1_name", employee1_name);
		map.put("comcode_code", comcode_code);
		
		List<Erp_Employee1VO> list = a3.empList(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "/a/a3/a31/empList";
	}
	
	@RequestMapping("/a31/kind")
	public String kind(Model model) {
		List<Erp_ProjectkindVO> list = a3.kindList();
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "/a/a3/a31/kindList";
	}
	
	@RequestMapping("/a31/team")
	public String team(Model model) {
		List<Erp_TeamVO> list = as.teamList();
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "/a/a3/a31/teamList";
	}
	
//	계약 관리
	@RequestMapping("/a32/")
	public String prContractList(Model model, Erp_ContractVO vo, String type, String word, String comcode_code) {
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("comcode_no", comcode_no);
		map.put("type",type);
		map.put("word",word);
		map.put("project_no", vo.getProject_no());
		
		List<Map<String, Object>> list = a3.prContractList(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		model.addAttribute("list", list);
		
		return ViewPath.A3 + "/a32/list";
	}
	
	@RequestMapping("/a32/inputContract")
	public String inputContract() {
		return ViewPath.A3 + "/a32/inputContract";
	}
	
	@RequestMapping("/a32/createContract")
	public String createContract(Model model, Erp_ContractVO vo) {
		String msg = null;
		String url = null;
		
		int insert = a3.createContract(vo);
		
		
		if(insert != 0) {
			msg = "계약이 정상적으로 등록되었습니다.";
			url = "/a/a3/a32/?project_no=" + vo.getProject_no();
		}else {
			msg = "계약 등록에 실패하였습니다. 지속적으로 문제가 발생한다면 관리자에게 문의주시기 바랍니다.";
			url = "/a/a3/a32/inputContract";
		}
		
		model.addAttribute("url", url);
		model.addAttribute("msg", msg);
		
		return ViewPath.RESULT + "loginresult";
	}
	
	@RequestMapping("/a32/updateFormC")
	public String updateFormC(Model model, Erp_ContractVO vo) {
		Map<String, Object> map = a3.selectContract(vo.getContract_no());
		
		model.addAttribute("map", map);
		
		return ViewPath.A3 + "/a32/updateForm";
	}
	
	@RequestMapping("/a32/update")
	public String updateContract(Model model, Erp_ContractVO vo) {
		String msg = null;
		String url = null;
		
		int update = a3.updateContract(vo);
		
		if(update != 0) {
			msg = "계약이 정상적으로 수정되었습니다.";
			url = "/a/a3/a32/contentC?contract_no=" + vo.getContract_no();
		}else {
			msg = "계약 수정에 실패하였습니다. 지속적으로 문제가 발생한다면 관리자에게 문의주시기 바랍니다.";
			url = "/a/a3/a32/updateFormC?contract_no=" + vo.getContract_no();
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return ViewPath.RESULT + "loginresult";
	}
	
	@RequestMapping("/a32/delete")
	public String deleteContract(Model model, Erp_ContractVO vo, String comcode_code) {
		int delete = a3.deleteContract(vo.getContract_no());
		
		String msg = null;
		String url = null;
		
		if(delete != 0) {
			msg = "계약이 정상적으로 삭제되었습니다.";
			url = "/a/a3/a32/?project_no=" + vo.getProject_no() + "&comcode_code=" + comcode_code;
		}else {
			msg = "계약 삭제에 실패하였습니다. 지속적으로 문제가 발생한다면 관리자에게 문의주시기 바랍니다.";
			url = "/a/a3/a32/contentC?contract_no=" + vo.getContract_no();
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return ViewPath.RESULT + "loginresult";
	}
	
	@RequestMapping("/a32/contentC")
	public String selectContract(Model model, Erp_ContractVO vo) {
		Map<String, Object> map = a3.selectContract(vo.getContract_no());
		
		model.addAttribute("map", map);
		
		return ViewPath.A3 + "/a32/content";
	}
	
	@RequestMapping(value="/a32/clientAjax", produces = "application/text; charset=utf8")
	@ResponseBody
	public String clientAjax(String client_name) {
		String msg = null;
		
		Erp_ClientVO cvo = a3.getClientNo(client_name);
		if(cvo == null) {
			msg = "없는 거래처 이름입니다. 새로 등록하시거나 다시 한번 확인해 주시기 바랍니다.";
		}
		
		return msg;
	}
	
	@RequestMapping(value="/a32/clientInfo", produces = "application/text; charset=utf8")
	@ResponseBody
	public Map<String,Object> clientInfo(int client_no) {
		
		Map<String,Object> map = a3.getClient(client_no);
		if(map == null) {
			map = null;
		}
		
		return map;
	}
	
	@RequestMapping("/a32/searchcl")
	public String clList(Model model, String client_name, String comcode_code) {
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("client_name", client_name);
		map.put("comcode_no", comcode_no);
		
		List<Erp_ClientVO> list = a3.clList(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "/a/a3/a32/clList";
	}
	
	@RequestMapping("/a32/searchpr")
	public String prList(Model model, String project_name, String comcode_code) {
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("project_name", project_name);
		map.put("comcode_no", comcode_no);
		
		List<Erp_ProjectVO> list = a3.getProject(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "/a/a3/a32/prList";
	}
	
	@RequestMapping("/a32/searchck")
	public String ckList(Model model) {
		List<Erp_ContractkindVO> list = a3.ckList();
		if(list.isEmpty()) {
			list = null;
		}
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "/a/a3/a32/ckList";
	}
	
//	실적 / 평가
	@RequestMapping("/a33/")
	public String estimateList(Model model, Erp_EstimateVO vo, Integer page, String type, String word, String comcode_code) {
		Map<String, Object> map = new HashMap<>();
		
		int comcode_no = ls.comNo(comcode_code);
		
		if(page == null) {
			page = 1;
		}
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		map.put("type",type);
		map.put("word",word);
		map.put("comcode_no", comcode_no);
		map.put("project_no", vo.getProject_no());
		
		int boardCount = a3.getTotalet(map);
		
		Paging paging = new Paging(page, boardCount);
	
		map.put("first", paging.getFirst());
		map.put("last", paging.getLast());
		
		List<Map<String, Object>> list = a3.estimateList(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		model.addAttribute("paging", paging);
		model.addAttribute("list", list);
		
		return ViewPath.A3 + "/a33/list";
	}
	
	@RequestMapping("/a33/inputEstimate")
	public String inputEstimate() {
		return ViewPath.A3 + "/a33/inputEstimate";
	}
	
	@RequestMapping("/a33/createEstimate")
	public String createEstimate(Model model, Erp_EstimateVO vo, String comcode_code) {
		int insert = a3.createEstimate(vo);
		
		String msg = null;
		String url = null;
		
		if(insert != 0) {
			msg = "평가가 정상적으로 등록되었습니다.";
			url = "/a/a3/a33/?comcode_code=" + comcode_code;
		}else {
			msg = "평가 등록에 실패하였습니다. 지속적으로 문제가 발생한다면 관리자에게 문의주시기 바랍니다.";
			url = "/a/a3/a33/inputEstimate";
		}
		
		model.addAttribute("url", url);
		model.addAttribute("msg", msg);
		
		return ViewPath.RESULT + "loginresult";
	}
	
	@RequestMapping("/a33/updateForm")
	public String updateFormE(Model model, Erp_EstimateVO vo) {
		Map<String, Object> vomap = new HashMap<>();
		
		vomap.put("estimate_no", vo.getEstimate_no());
		vomap.put("project_no", vo.getProject_no());
		
		Map<String, Object> map = a3.selectEstimate(vomap);
		
		model.addAttribute("map", map);
		
		return ViewPath.A3 + "/a33/updateForm";
	}
	
	@RequestMapping("/a33/update")
	public String updateEstimate(Model model, Erp_EstimateVO vo, String comcode_code) {
		int update = a3.updateEstimate(vo);
		
		String msg = null;
		String url = null;
		
		if(update != 0) {
			msg = "평가가 정상적으로 수정되었습니다.";
			url = "/a/a3/a33/?comcode_code=" + comcode_code;
		}else {
			msg = "평가 수정에 실패하였습니다. 지속적으로 문제가 발생한다면 관리자에게 문의주시기 바랍니다.";
			url = "/a/a3/a33/updateFormE?estimate_no="+vo.getEstimate_no()+"&project_no="+vo.getProject_no();
		}
		
		model.addAttribute("url", url);
		model.addAttribute("msg", msg);
		
		return ViewPath.RESULT + "loginresult";
	}
	
	@RequestMapping("/a33/delete")
	public String deleteEstimate(Model model, Erp_EstimateVO vo, String comcode_code) {
		int delete = a3.deleteEstimate(vo.getEstimate_no());
		
		String msg = null;
		String url = null;
		
		if(delete != 0) {
			msg = "평가가 정상적으로 삭제되었습니다.";
			url = "/a/a3/a33/?project_no=" + vo.getProject_no() + "&comcode_code=" + comcode_code;
		}else {
			msg = "평가 삭제에 실패하였습니다. 지속적으로 문제가 발생한다면 관리자에게 문의주시기 바랍니다.";
			url = "/a/a3/a33/contentE?estimate_no="+vo.getEstimate_no()+"&project_no="+vo.getProject_no();
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return ViewPath.RESULT + "loginresult";
	}
	
	@RequestMapping("/a33/content")
	public String selectEstimate(Model model, Erp_EstimateVO vo) {
		Map<String, Object> vomap = new HashMap<>();
		
		vomap.put("estimate_no", vo.getEstimate_no());
		vomap.put("project_no", vo.getProject_no());
		
		Map<String, Object> map = a3.selectEstimate(vomap);
		
		model.addAttribute("map", map);
		
		return ViewPath.A3 + "/a33/content";
	}
	
	@RequestMapping("/a33/searchpr")
	public String searchpr(Model model, String project_name, String comcode_code) {
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("project_name", project_name);
		map.put("comcode_no", comcode_no);
		
		List<Erp_ProjectVO> list = a3.getProject(map);
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "a/a3/a33/prList";
	}
}
