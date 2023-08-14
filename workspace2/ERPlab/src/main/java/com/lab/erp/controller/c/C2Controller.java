package com.lab.erp.controller.c;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lab.erp.common.ViewPath;
import com.lab.erp.service.c.C2Service;
import com.lab.erp.service.login.LoginService;
import com.lab.erp.vo.a.a1.Erp_BusinesstypeVO;
import com.lab.erp.vo.c.Erp_ClientVO;
import com.lab.erp.vo.c.Erp_ClientsortVO;
import com.lab.erp.vo.c.Erp_CountryVO;

@Controller
@RequestMapping("/c/c2")
public class C2Controller {
	private C2Service c2;
	private LoginService ls;
	
	public C2Controller(C2Service c2, LoginService ls) {
		this.c2 = c2;
		this.ls = ls;
	}
	
	@RequestMapping("/c21")
	public String clientList(Model model, String type, String word, String comcode) {
		int comcode_no = ls.comNo(comcode);
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> list = c2.clientListb4(map);
		
		model.addAttribute("list", list);
		
		return ViewPath.C2 + "/c21/inputClient";
	}
	
	@RequestMapping("/c21/createClient")
	public String createClient(String comcode_code, Erp_ClientVO vo, Model model) {
		int comcode_no = ls.comNo(comcode_code);
		
		vo.setComcode_no(comcode_no);
		
		int insert = c2.createClient(vo);
		if(insert == 0) {
			String msg = "추가 실패";
			String url = "/c/c2/c21?comcode_code="+comcode_code;
			
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}else {
			return "redirect:/c/c2/c21?comcode_code="+comcode_code;
		}
	}
	
	@RequestMapping("/c21/updateForm")
	public String updateForm(Model model, Erp_ClientVO vo, String type, String word, String comcode) {
		int comcode_no = ls.comNo(comcode);
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> list = c2.clientListb4(map);
		
		Map<String, Object> clmap = c2.selectClientb4(vo.getClient_no());
		
		model.addAttribute("list", list);
		model.addAttribute("clmap", clmap);
		
		return ViewPath.C2 + "/c21/updateForm";
	}
	
	@RequestMapping("/c21/update")
	public String updateClient(Model model, Erp_ClientVO vo, String comcode_code) {
		int comcode_no = ls.comNo(comcode_code);
		
		vo.setComcode_no(comcode_no);
		
		int update = c2.updateClient(vo);
		
		if(update == 0) {
			String msg = "수정 실패";
			String url = "/c/c2/c21/updateForm?comcode_code="+comcode_code+"&client_no="+vo.getClient_no();
			
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}else {
			return "redirect:/c/c2/c21/updateForm?comcode_code="+comcode_code+"&client_no="+vo.getClient_no();
		}
	}
	
	@RequestMapping("/c21/delete")
	public String deleteClient(Model model, Erp_ClientVO vo, String comcode_code) {
		int delete = c2.deleteClient(vo.getClient_no());
		
		if(delete == 0) {
			String msg = "삭제 실패";
			String url = "/c/c2/c21/updateForm?comcode_code="+comcode_code+"&client_no="+vo.getClient_no();
			
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}else {
			return "redirect:/c/c2/c21?comcode_code="+comcode_code;
		}
	}
	
	@RequestMapping("/c21/searchbn")
	public String searchbn(String btype, String bnword, Model model) {
		if(btype == null || bnword == null) {
			btype = null;
			bnword = null;
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("btype", btype);
		map.put("bnword", bnword);
		
		List<Erp_BusinesstypeVO> list = c2.btName(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "/c/c2/c21/businessName";
	}
	@RequestMapping("/c21/searchbs")
	public String searchbs(String btype, String bword, Model model) {
		if(btype == null || bword == null) {
			btype = null;
			bword = null;
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("btype", btype);
		map.put("bword", bword);
		
		List<Erp_BusinesstypeVO> list = c2.btSubctgr(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "/c/c2/c21/businessSub";
	}
	@RequestMapping("/c21/searchcs")
	public String searchcs(String cstype, String csword, Model model) {
		if(cstype == null || csword == null) {
			cstype = null;
			csword = null;
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("cstype", cstype);
		map.put("csword", csword);
		
		List<Erp_ClientsortVO> list = c2.csList(map);
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "/c/c2/c21/csList";
	}
	@RequestMapping("/c21/searchct")
	public String searchct(String ctype, String cword, Model model) {
		if(ctype == null || cword == null) {
			ctype = null;
			cword = null;
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("ctype", ctype);
		map.put("cword", cword);
		
		List<Erp_CountryVO> list = c2.countryList(map);
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "/c/c2/c21/countryList";
	}
	
	@RequestMapping("/c21/clientsort")
	@ResponseBody
	public Erp_ClientsortVO clientsort(String clientsort_name) {
		try {
			Erp_ClientsortVO vo = c2.autoSort(clientsort_name);
			
			return vo;
		}catch(Exception e) {
			return null;
		}
	}
	@RequestMapping("/c21/country")
	@ResponseBody
	public Erp_CountryVO country(String country_name) {
		try {
			Erp_CountryVO vo = c2.autoCountry(country_name);
			
			return vo;
		}catch(Exception e) {
			return null;
		}
	}
}
