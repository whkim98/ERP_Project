package com.lab.erp.controller.b;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lab.erp.common.ViewPath;
import com.lab.erp.service.b.B3Service;
import com.lab.erp.service.c.C2Service;
import com.lab.erp.service.login.LoginService;
import com.lab.erp.vo.b.b1.Erp_Bs3VO;
import com.lab.erp.vo.c.Erp_CountryVO;

@Controller
public class B3Controller {
	private LoginService login;
	
	private B3Service b3;
	private C2Service c2;
	
	@Autowired
	public B3Controller(LoginService login, B3Service b3, C2Service c2) {
		this.login = login;
		this.b3 = b3;
		this.c2 = c2;
	}

	
	// <전표>	
	@RequestMapping("/b31main")
	public String b31main(Model model, String comcode_code){
		int comcode_no = login.comNo(comcode_code);
		int ctgr = 16;
		
		Map<String, Object> map = new HashMap<>();
		map.put("comcode_code", comcode_no);
		map.put("ctgr_no", ctgr);			
		
		List<Map<String, Object>> list = b3.statementList(map);
		if(list.isEmpty()) {
			list = null ;
		}
		
		List<Erp_Bs3VO> bs3list1 = b3.ctgrDebtor(ctgr);
		List<Erp_Bs3VO> bs3list2 = b3.ctgrCreditor(ctgr);
		List<Erp_Bs3VO> bs3list3 = b3.bs3List();
		
		model.addAttribute("bs3list1", bs3list1);
		model.addAttribute("bs3list2", bs3list2);
		model.addAttribute("bs3list3", bs3list3);
		model.addAttribute("list", list);
		
		return ViewPath.B3 + "/b31/b31main";
	}
	
	@RequestMapping("/b31delete")
	@Transactional // rollback 기능
	public String b31delete(int statement_no, String bs3_no1, String bs3_no2, Model model, String comcode_code) {
		int comcode_no = login.comNo(comcode_code);
		
		
		b3.deleteStatement(statement_no);
		
		return ViewPath.B3 + "/b31/b31main";
	}
	
	
	@RequestMapping("/b31insert")
	public String b31insert() {
		
		return ViewPath.B3 + "/b31/b31insert";
	}
	
	// 전자세금계산서
	@GetMapping("/b32main")
	public String b32main(){
		
		
		
		return ViewPath.B3 + "/b32/b32main";
	}	
	
	
	// 외화관리
	@RequestMapping("/b33main")
	public String b33main(Model model) {
		
		Map<String, Object> map = new HashMap<>();		
		List<Erp_CountryVO> list = c2.countryList(map);
		model.addAttribute("list", list);
		
		return ViewPath.B3 + "/b33/b33main";
	}
		
}
