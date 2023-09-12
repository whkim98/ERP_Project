package com.lab.erp.controller.b;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lab.erp.common.ViewPath;
import com.lab.erp.service.b.B1Service;
import com.lab.erp.service.login.LoginService;
import com.lab.erp.vo.b.b1.Erp_Bs2VO;
import com.lab.erp.vo.b.b1.Erp_Bs3VO;

@Controller
public class B1Controller {
	private LoginService login;
	
	private B1Service b1;
	
	@Autowired
	public B1Controller(LoginService login, B1Service b1) {
		this.login = login;
		this.b1 = b1;		
	}
	
	// bs
	@RequestMapping("/b11main")
	public String b11main(Model model, String comcode_code, int bs2_no) {
		int comcode_no = login.comNo(comcode_code);
		int ctgr = 10;		
		
		List<Erp_Bs3VO> list = b1.bsList();		
		model.addAttribute("list", list);		
		
		List<Erp_Bs2VO> bs2list = b1.bs2List();		
		model.addAttribute("bs2list", bs2list);		

		List<Erp_Bs3VO> bs3ctgr = b1.bs3ctgr(bs2_no);	
		model.addAttribute("bs3ctgr", bs3ctgr);
		
		Map<Integer, Erp_Bs3VO> bs2map = new HashMap<>(); 
		for (int i=1; i<= bs2list.size(); i++) {
			bs2map.put(i, bs3ctgr.get(i));
		}
		model.addAttribute("bs2map", bs2map);
		
		return ViewPath.B1 + "/b11/b11main";
	}
	

}
