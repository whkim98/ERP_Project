package com.lab.erp.controller.b;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lab.erp.service.b.B7Service;
import com.lab.erp.service.login.LoginService;
import com.lab.erp.vo.b.b1.Erp_Bs1VO;
import com.lab.erp.vo.b.b1.Erp_Bs2VO;
import com.lab.erp.vo.b.b1.Erp_Bs3VO;
import com.lab.erp.vo.b.b7.Erp_SuppliesVO;
import com.lab.erp.vo.b.b7.Erp_ToolsVO;


@Controller
public class B7Controller {

	private B7Service b7;
	private LoginService ls;
	
	@Autowired
	public B7Controller(B7Service b7, LoginService ls) {
		this.b7 = b7;
		this.ls = ls;
	}
	
	@RequestMapping("/tools")
	public String tools(Model model, String comcode_code, String type, String word) {
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		map.put("comcode_no", comcode_no);
		map.put("type", type);
		map.put("word", word);
		
		List<Map<String, Object>> list = b7.selectTools(map);
		
		model.addAttribute("list", list);
		
		return "";
	}
	
	@RequestMapping("/tools/insert")
	public String insertTools(Erp_ToolsVO vo, int salesgoods_no, Erp_Bs1VO b1vo, Erp_Bs2VO b2vo, Erp_Bs3VO b3vo, String comcode_code, int bs3_no, int dbs3_no, int team_no, String tools_code, String tools_name, int toolstype_no, String tools_usage, String tools_date, int tools_price, int tools_tax, int tools_total, String tools_expiry) {
		
		int comcode_no = ls.comNo(comcode_code);
		
		int total = b7.selectSumqty(salesgoods_no);
		
		vo.setComcode_no(comcode_no);
		vo.setTeam_no(team_no);
		vo.setTools_code(tools_code);
		vo.setTools_date(tools_date);
		vo.setTools_expiry(tools_expiry);
		vo.setTools_name(tools_name);
		vo.setTools_price(tools_price);
		vo.setTools_tax(tools_tax);
		vo.setTools_total(tools_total);
		vo.setTools_usage(tools_usage);
		vo.setToolstype_no(toolstype_no);
		
		b7.insertTools(vo);
		
		int bs_no = b7.selectBsno(bs3_no);
		int bs2_no = b7.selectBsno2(bs3_no);
		
		b3vo.setBs3_no(bs3_no);
		b2vo.setBs2_no(bs2_no);
		b1vo.setBs1_no(bs_no);
		
		//대변
		b3vo.setBs3_amount(total);
		b2vo.setBs2_amount(total);
		b1vo.setBs1_amount(total);
		
		b7.updateBs(b1vo);
		b7.updateBs2(b2vo);
		b7.updateBs3(b3vo);
		
		bs_no = b7.selectBsno(dbs3_no);
		bs2_no = b7.selectBsno2(dbs3_no);
		
		b3vo.setBs3_no(dbs3_no);
		b2vo.setBs2_no(bs2_no);
		b1vo.setBs1_no(bs_no);
		
		b3vo.setBs3_amount(-total);
		b2vo.setBs2_amount(-total);
		b1vo.setBs1_amount(-total);
		
		b7.updateBs(b1vo);
		b7.updateBs2(b2vo);
		b7.updateBs3(b3vo);
		
		return "";
	}
	
	//비품 소모품
	@RequestMapping("/supplies")
	public String supplies(String comcode_code, Model model, String type, String word) {
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		map.put("comcode_no", comcode_no);
		map.put("word", word);
		map.put("type", type);
		
		List<Map<String, Object>> list = b7.selectSupplies(map);
		
		model.addAttribute("list", list);
		
		return "";
	}
	
	@RequestMapping("/supplies/insert")
	public String insertSupplies(Erp_SuppliesVO vo, int salesgoods_no, Erp_Bs1VO b1vo, Erp_Bs2VO b2vo, Erp_Bs3VO b3vo, int bs3_no, int dbs3_no, String comcode_code, String supplies_code, int team_no, String supplies_name, int suppliestype_no, String supplies_usage, String supplies_date, int supplies_price, int supplies_tax, int supplies_total) {
		int comcode_no = ls.comNo(comcode_code);
		int total = b7.selectSumqty(salesgoods_no);
		vo.setComcode_no(comcode_no);
		vo.setSupplies_code(supplies_code);
		vo.setSupplies_date(supplies_date);
		vo.setSupplies_name(supplies_name);
		vo.setSupplies_price(supplies_price);
		vo.setSupplies_tax(supplies_tax);
		vo.setSupplies_total(total);
		vo.setSupplies_usage(supplies_usage);
		vo.setSuppliestype_no(suppliestype_no);
		vo.setTeam_no(team_no);
		b7.insertSupplies(vo);
		
		int bs_no = b7.selectBsno(bs3_no);
		int bs2_no = b7.selectBsno2(bs3_no);
		
		b3vo.setBs3_no(bs3_no);
		b2vo.setBs2_no(bs2_no);
		b1vo.setBs1_no(bs_no);
		
		//대변
		b3vo.setBs3_amount(total);
		b2vo.setBs2_amount(total);
		b1vo.setBs1_amount(total);
		
		b7.updateBs(b1vo);
		b7.updateBs2(b2vo);
		b7.updateBs3(b3vo);
		
		bs_no = b7.selectBsno(dbs3_no);
		bs2_no = b7.selectBsno2(dbs3_no);
		
		b3vo.setBs3_no(dbs3_no);
		b2vo.setBs2_no(bs2_no);
		b1vo.setBs1_no(bs_no);
		
		b3vo.setBs3_amount(-total);
		b2vo.setBs2_amount(-total);
		b1vo.setBs1_amount(-total);
		
		b7.updateBs(b1vo);
		b7.updateBs2(b2vo);
		b7.updateBs3(b3vo);
		
		return "";
	}
	
}
