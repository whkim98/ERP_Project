package com.lab.erp.controller.b;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lab.erp.common.ViewPath;
import com.lab.erp.service.b.B4Service;
import com.lab.erp.service.login.LoginService;
import com.lab.erp.vo.b.b1.Erp_ClosingVO;

@Controller
@RequestMapping("/b/b4")
public class B4Controller {
	private B4Service b4;
	private LoginService ls;
	
	@Autowired
	public B4Controller(B4Service b4, LoginService ls) {
		this.b4 = b4;
		this.ls = ls;
	}
	
	@RequestMapping("/b41")
	public String deadlineList(Model model, String comcode_code, String type, String word) {
		int comcode_no = ls.comNo(comcode_code);
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("comcode_no", comcode_no);
		map.put("type",type);
		map.put("word",word);
		
		List<Map<String, Object>> list = b4.deadlineList(map);
		Erp_ClosingVO vo = b4.totalAmount(map);
		
		model.addAttribute("list", list);
		model.addAttribute("vo", vo);
		
		return ViewPath.B4 + "/b41/list";
	}
	
	@RequestMapping("/b41/selectCtgr")
	public String selectCtgr(Erp_ClosingVO cvo, String comcode_code, Model model, String type, String word) {
		int comcode_no = ls.comNo(comcode_code);
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("ctgr_no", cvo.getCtgr_no());
		map.put("type",type);
		map.put("word",word);
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> list = b4.selectCtgr(map);
		Erp_ClosingVO vo = b4.ctgrAmount(map);
		
		model.addAttribute("ctgr_no", cvo.getCtgr_no());
		model.addAttribute("list", list);
		model.addAttribute("vo", vo);
		
		return ViewPath.B4 + "/b41/selectCtgr";
	}
}
