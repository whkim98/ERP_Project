package com.lab.erp.controller.b;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lab.erp.service.b.B7Service;
import com.lab.erp.service.login.LoginService;
import com.lab.erp.vo.b.b1.Erp_Bs1VO;
import com.lab.erp.vo.b.b1.Erp_Bs2VO;
import com.lab.erp.vo.b.b1.Erp_Bs3VO;
import com.lab.erp.vo.b.b1.Erp_ClosingVO;
import com.lab.erp.vo.b.b7.Erp_SuppliesVO;
import com.lab.erp.vo.b.b7.Erp_SuppliestypeVO;
import com.lab.erp.vo.b.b7.Erp_ToolsVO;
import com.lab.erp.vo.b.b7.Erp_ToolstypeVO;


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
		
		List<Erp_Bs1VO> dlist = b7.selectBsdeb();
		
		List<Erp_Bs1VO> cclist = b7.selectBscre();
		
		List<Erp_ToolstypeVO> tlist = b7.toolstypeList();
		
		model.addAttribute("list", list);
		model.addAttribute("dlist", dlist);
		model.addAttribute("cclist", cclist);
		model.addAttribute("tlist", tlist);
		
		return "/b/b7/b71/toolsList";
	}
	
	@RequestMapping("/tools/ajax")
	@ResponseBody
	public List<Map<String, Object>> toolsAjax(Model model, String comcode_code, String type, String word) {
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		map.put("comcode_no", comcode_no);
		map.put("word", word);
		map.put("type", type);
		
		List<Map<String, Object>> list = b7.selectTools(map);
		
		if(list.isEmpty()) {
			list = null;
		}
		
		return list;
	}
	
	@RequestMapping("/tools/insert")
	public String insertTools(Erp_ClosingVO cvo, Erp_ToolsVO vo, Erp_Bs1VO b1vo, Erp_Bs2VO b2vo, Erp_Bs3VO b3vo, String comcode_code, int bs3_no, int dbs3_no, int team_no, String tools_code, String tools_name, int toolstype_no, String tools_usage, String tools_date, int tools_price, String tools_expiry) {
		
		int comcode_no = ls.comNo(comcode_code);
		
		int total = tools_price + (tools_price / 10);
		
		vo.setComcode_no(comcode_no);
		vo.setTeam_no(team_no);
		vo.setTools_code(tools_code);
		vo.setTools_date(tools_date);
		vo.setTools_expiry(tools_expiry);
		vo.setTools_name(tools_name);
		vo.setTools_price(tools_price);
		vo.setTools_tax(tools_price / 10);
		vo.setTools_total(total);
		vo.setTools_usage(tools_usage);
		vo.setToolstype_no(toolstype_no);
		
		b7.insertTools(vo);
		
		int debtor_no = b7.selectDebno(bs3_no);
		int creditor_no = b7.selectCreno(dbs3_no);
		
		cvo.setClosing_code(tools_code);
		cvo.setDebtor_no(debtor_no);
		cvo.setCreditor_no(creditor_no);
		cvo.setComcode_no(comcode_no);
		cvo.setClosing_creditor(-total);
		cvo.setClosing_debtor(total);
		
		b7.insertToolclosing(cvo);
		
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
		
		return "redirect:/tools?comcode_code = " + comcode_code;
	}
	
	@RequestMapping("/tools/updateForm")
	public String toolsUpdateform(String type, String word, Model model, String comcode_code, int tools_no) {
		
		int comcode_no = ls.comNo(comcode_code);
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("comcode_no", comcode_no);
		map.put("tools_no", tools_no);
		map.put("type", type);
		map.put("word", word);
		
		map = b7.selectTools2(map);
		
		List<Map<String, Object>> list = b7.selectTools(map);
		
		List<Erp_Bs1VO> dlist = b7.selectBsdeb2();
		
		List<Erp_Bs1VO> cclist = b7.selectBscre2();
		
		List<Erp_ToolstypeVO> tlist = b7.toolstypeList();
		
		model.addAttribute("list", list);
		model.addAttribute("dlist", dlist);
		model.addAttribute("cclist", cclist);
		model.addAttribute("tlist", tlist);
		model.addAttribute("map", map);
		
		return "/b/b7/b71/toolsList";
	}
	
	@RequestMapping("/tools/update")
	public String toolsUpdate(Erp_Bs1VO b1vo, Erp_Bs2VO b2vo, Erp_Bs3VO b3vo, String comcode_code) {
		
		
		
		return "redirect:/tools?comcode_code=" + comcode_code;
		
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
		
		List<Erp_Bs1VO> dlist = b7.selectBsdeb2();
		
		List<Erp_Bs1VO> cclist = b7.selectBscre2();
		
		List<Erp_SuppliestypeVO> slist = b7.suppliestypeList();
		
		model.addAttribute("list", list);
		model.addAttribute("cclist", cclist);
		model.addAttribute("dlist", dlist);
		model.addAttribute("slist", slist);
		
		return "/b/b7/b72/suppliesList";
	}
	
	@RequestMapping("/supplies/ajax")
	@ResponseBody
	public List<Map<String, Object>> suppliesAjax(Model model, String comcode_code, String type, String word){
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		map.put("comcode_no", comcode_no);
		map.put("word", word);
		map.put("type", type);
		
		List<Map<String, Object>> list = b7.selectSupplies(map);
		
		if(list.isEmpty()) {
			list = null;
		}
		
		return list;
	
	}
	
	@RequestMapping("/supplies/insert")
	public String insertSupplies(Erp_SuppliesVO vo, Erp_Bs1VO b1vo, Erp_Bs2VO b2vo, Erp_Bs3VO b3vo, int bs3_no, int dbs3_no, String comcode_code, String supplies_code, int team_no, String supplies_name, int suppliestype_no, String supplies_usage, String supplies_date, int supplies_price) {
		int comcode_no = ls.comNo(comcode_code);
		int total = supplies_price + (supplies_price / 10);
		
		vo.setComcode_no(comcode_no);
		vo.setSupplies_code(supplies_code);
		vo.setSupplies_date(supplies_date);
		vo.setSupplies_name(supplies_name);
		vo.setSupplies_price(supplies_price);
		vo.setSupplies_tax(supplies_price / 10);
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
		
		return "redirect:/supplies?comcode_code=" + comcode_code;
	}
	
	@RequestMapping("/supplies/updateForm")
	public String suppliesUpdateform(String type, String word, Model model, String comcode_code, int supplies_no) {
		
		int comcode_no = ls.comNo(comcode_code);
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("comcode_no", comcode_no);
		map.put("supplies_no", supplies_no);
		map.put("type", type);
		map.put("word", word);
		
		map = b7.selectSupplies2(map);
		
		List<Map<String, Object>> list = b7.selectSupplies(map);
		
		List<Erp_Bs1VO> dlist = b7.selectBsdeb2();
		
		List<Erp_Bs1VO> cclist = b7.selectBscre2();
		
		List<Erp_SuppliestypeVO> slist = b7.suppliestypeList();
		
		model.addAttribute("list", list);
		model.addAttribute("dlist", dlist);
		model.addAttribute("cclist", cclist);
		model.addAttribute("slist", slist);
		model.addAttribute("map", map);
		
		return "/b/b7/b72/suppliesList";
		
	}
	
}
