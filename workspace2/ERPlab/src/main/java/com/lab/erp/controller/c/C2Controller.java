package com.lab.erp.controller.c;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lab.erp.common.ViewPath;
import com.lab.erp.service.c.C2Service;
import com.lab.erp.service.login.LoginService;
import com.lab.erp.vo.a.a1.Erp_BusinesstypeVO;
import com.lab.erp.vo.b.b1.Erp_Bs3VO;
import com.lab.erp.vo.b.b1.Erp_ClosingVO;
import com.lab.erp.vo.c.Erp_BondbillsVO;
import com.lab.erp.vo.c.Erp_ClientVO;
import com.lab.erp.vo.c.Erp_ClientsortVO;
import com.lab.erp.vo.c.Erp_CountryVO;
import com.lab.erp.vo.c.Erp_GoodsconnectVO;
import com.lab.erp.vo.c.Erp_ReceivableVO;
import com.lab.erp.vo.c.Erp_SalesgoodsVO;
import com.lab.erp.vo.c.c2.Erp_LocalsalesVO;
import com.lab.erp.vo.c.c2.Erp_ReturnVO;
import com.lab.erp.vo.d.d6.Erp_GoodsVO;

@Controller
@RequestMapping("/c/c2")
public class C2Controller {
	private C2Service c2;
	private LoginService ls;
	
	@Autowired
	public C2Controller(C2Service c2, LoginService ls) {
		this.c2 = c2;
		this.ls = ls;
	}
	
//	거래처
	@RequestMapping("/c21")
	public String clientList(Model model, String type, String word, String comcode_code) {
		String msg = null;
		String url = null;
		
		if(comcode_code == "") {
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
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> list = c2.clientListb4(map);
		
		model.addAttribute("list", list);
		
		return ViewPath.C2 + "/c21/inputClient";
	}
	
	@RequestMapping("/c21/clientAjax")
	public List<Map<String, Object>> clientAjax(String type, String word, String comcode_code){
		
		int comcode_no = ls.comNo(comcode_code);
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> list = c2.clientListb4(map);
		
		return list;
	}
	
	@RequestMapping("/c21/createClient")
	@Transactional
	public String createClient(String comcode_code, Erp_ClientVO vo, Model model, 
			String[] goods_no) {
		String msg = null;
		String url = null;
		
		if(comcode_code == "") {
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		vo.setComcode_no(comcode_no);
		
		int insert = c2.createClient(vo);
		if(insert == 0) {
			msg = "추가 실패";
			url = "redirect:/c/c2/c21?comcode_code="+comcode_code;
			
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}else {
			int client_no = c2.getClNo(vo.getClient_registeredno());
			for(int i = 0; i < goods_no.length; i++) {
				Erp_GoodsconnectVO gcvo = new Erp_GoodsconnectVO();
				int gno = 0;
				if(goods_no[i] == "") {
					gno = 1;
				}else {
					gno = Integer.parseInt(goods_no[i]);
				}
				gcvo.setGoods_no(gno);
				gcvo.setClient_no(client_no);
				c2.inputGC(gcvo);
			}
			return "redirect:/c/c2/c21?comcode_code="+comcode_code;
		}
	}
	
	@RequestMapping("/c21/updateForm")
	public String updateForm(Model model, Erp_ClientVO vo, String type, String word, String comcode_code) {
		String msg = null;
		String url = null;
		
		if(comcode_code == "") {
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
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> list = c2.clientListb4(map);
		
		List<Map<String, Object>> gclist = c2.clientGoods(vo.getClient_no());
		
		Map<String, Object> clmap = c2.selectClientb4(vo.getClient_no());
		
		model.addAttribute("gclist", gclist);
		model.addAttribute("list", list);
		model.addAttribute("clmap", clmap);
		
		return ViewPath.C2 + "/c21/updateForm";
	}
	
	@RequestMapping("/c21/update")
	@Transactional
	public String updateClient(Model model, Erp_ClientVO vo, String comcode_code, 
			String[] goods_no) {
		String msg = null;
		String url = null;
		
		if(comcode_code == "") {
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		vo.setComcode_no(comcode_no);
		
		int update = c2.updateClient(vo);
		
		if(update == 0) {
			msg = "수정 실패";
			url = "redirect:/c/c2/c21/updateForm?comcode_code="+comcode_code+"&client_no="+vo.getClient_no();
			
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}else {
			for(int i = 0; i < goods_no.length; i++) {
				Erp_GoodsconnectVO gcvo = new Erp_GoodsconnectVO();
				int gno = 0;
				if(goods_no[i] == "") {
					gno = 1;
				}else {
					gno = Integer.parseInt(goods_no[i]);
				}
				gcvo.setGoods_no(gno);
				gcvo.setClient_no(vo.getClient_no());
				c2.updateGC(gcvo);
			}
			
			return "redirect:/c/c2/c21/updateForm?comcode_code="+comcode_code+"&client_no="+vo.getClient_no();
		}
	}
	
	@RequestMapping("/c21/delete")
	@Transactional
	public String deleteClient(Model model, Erp_ClientVO vo, String comcode_code) {
		String msg = null;
		String url = null;
		
		if(comcode_code == "") {
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		int delete = c2.deleteClient(vo.getClient_no());
		
		c2.deleteGCClient(vo.getClient_no());
		
		if(delete == 0) {
			msg = "삭제 실패";
			url = "redirect:/c/c2/c21/updateForm?comcode_code="+comcode_code+"&client_no="+vo.getClient_no();
			
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}else {
			return "redirect:/c/c2/c21?comcode_code="+comcode_code;
		}
	}
	
	@RequestMapping("/c21/goodsList")
	public String goodsList(Model model) {
		List<Erp_GoodsVO> list = c2.goodsList();
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "/c/c21/goodsList";
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
	
	
//	채권
	@RequestMapping("/c22")
	public String inputReceivable(String comcode_code, Model model, String type, String word) {
		
		String msg = null;
		String url = null;
		
		if(comcode_code == "") {
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
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> rlist = c2.receivableList(map);
		
		List<Erp_Bs3VO> dlist = c2.ctgrDebtor(36);
		List<Erp_Bs3VO> clist = c2.ctgrCreditor(36);
		
		model.addAttribute("list", rlist);
		model.addAttribute("dlist", dlist);
		model.addAttribute("clist", clist);
		
		return ViewPath.C2 + "/c22/inputReceivable";
	}
	
	@RequestMapping("/c22/receivableAjax")
	@ResponseBody
	public List<Map<String, Object>> receivableAjax(String type, String word, String comcode_code){
		int comcode_no = ls.comNo(comcode_code);
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> list = c2.receivableList(map);
		
		return list;
	}
	
	@RequestMapping("/c22/createReceivable")
	@Transactional
	public String createReceivable(Erp_ReceivableVO vo, String comcode_code, Model model) {
		String msg = null;
		String url = null;
		
		if(comcode_code == "") {
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		int insert = c2.createReceivable(vo);
		if(insert != 0) {
			return "redirect:/c/c2/c22?comcode_code="+comcode_code;
		}else {
			msg = "등록 실패";
			url = "redirect:/c/c2/c22?comcode_code="+comcode_code;
			return ViewPath.RESULT + "loginresult";
		}
	}
	
	@RequestMapping("/c22/updateForm")
	public String updateFormR(String comcode_code, Model model, Erp_ReceivableVO vo, String type, String word) {
		if(comcode_code == "") {
			String msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			String url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> rlist = c2.receivableList(map);
		
		List<Erp_Bs3VO> dlist = c2.ctgrDebtor(36);
		List<Erp_Bs3VO> clist = c2.ctgrCreditor(36);
		
		model.addAttribute("list", rlist);
		model.addAttribute("dlist", dlist);
		model.addAttribute("clist", clist);
		
		Map<String, Object> inmap = c2.selectReceivable(vo.getReceivable_no());
		
		Map<String, Object> clmap = c2.selectClientb4((int)inmap.get("client_no"));
		
		model.addAttribute("inmap", inmap);
		model.addAttribute("clmap", clmap);
		
		return ViewPath.C2 + "/c22/inputReceivable";
	}
	
	@RequestMapping("/c22/update")
	public String updateReceivable(String comcode_code, Model model, Erp_ReceivableVO vo) {
		String msg = null;
		String url = null;
		
		if(comcode_code == "") {
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		int update = c2.updateReceivable(vo);
		if(update != 0) {
			return "redirect:/c/c2/c22/updateForm?comcode_code="+comcode_code+"&receivable_no="+vo.getReceivable_no();
		}else {
			msg = "수정 실패";
			url = "redirect:/c/c2/c22/updateForm?comcode_code="+comcode_code+"&receivable_no="+vo.getReceivable_no();
			return ViewPath.RESULT + "loginresult";
		}
	}
	
	@RequestMapping("/c22/delete")
	public String deleteReceivable(String comcode_code, Model model, Erp_BondbillsVO vo) {
		String msg = null;
		String url = null;
		
		if(comcode_code == "") {
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		int delete = c2.deleteBills(vo.getBondbills_no());
		if(delete != 0) {
			return "redirect:/c/c2/c22?comcode_code="+comcode_code;
		}else {
			msg = "삭제 실패";
			url = "redirect:/c/c2/c22/updateForm?comcode_code="+comcode_code+"&receivable_no="+vo.getReceivable_no();
			return ViewPath.RESULT + "loginresult";
		}
	}
	
	
//	수금
	@RequestMapping("/c22/inputBondbills")
	public String inputBondbills(String comcode_code, Model model, Erp_BondbillsVO vo, String type, String word) {
		String msg = null;
		String url = null;
		
		if(comcode_code == "") {
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		List<Map<String, Object>> list = null;
		List<Erp_Bs3VO> dlist = c2.ctgrDebtor(36);
		List<Erp_Bs3VO> clist = c2.ctgrCreditor(36);
		
		int comcode_no = ls.comNo(comcode_code);
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		if(vo == null) {
			list = c2.bondbillsList(map);
		}else {
			map.put("receivable_no", vo.getReceivable_no());
			list = c2.receiveBondbills(map);
		}
		
		model.addAttribute("list", list);
		model.addAttribute("dlist", dlist);
		model.addAttribute("clist", clist);
		
		return ViewPath.C2 + "inputBondbills";
	}
	
	@RequestMapping("/c22/billsAjax")
	@ResponseBody
	public List<Map<String, Object>> billsAjax(String comcode_code, Erp_BondbillsVO vo, String type, String word){
		List<Map<String, Object>> list = null;
		
		int comcode_no = ls.comNo(comcode_code);
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		if(vo == null) {
			list = c2.bondbillsList(map);
		}else {
			map.put("receivable_no", vo.getReceivable_no());
			list = c2.receiveBondbills(map);
		}
		
		return list;
	}
	
	@RequestMapping("/c22/createBondbills")
	@Transactional
	public String createBondbills(String comcode_code, String bs3_no1, String bs3_no2, Model model, 
			Erp_BondbillsVO vo, String receivable_clno, String debtor_no, String creditor_no) {
		Map<String, Object> inmap = c2.selectReceivable(vo.getReceivable_no());
		
		String msg = null;
		String url = null;
		
		if(comcode_code == "") {
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		int deptno = 0;
		int creditno = 0;
		int b1 = 0;
		int b2 = 0;
		
		if(debtor_no == "") {
			deptno = 0;
		}else {
			deptno = Integer.parseInt(debtor_no);
		}
		if(creditor_no == "") {
			creditno = 0;
		}else {
			creditno = Integer.parseInt(creditor_no);
		}
		if(bs3_no1 == "") {
			b1 = 0;
		}else {
			b1 = Integer.parseInt(bs3_no1);
		}
		if(bs3_no2 == "") {
			b2 = 0;
		}else {
			b2 = Integer.parseInt(bs3_no2);
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		c2.inputBills(vo);
		
		int getbills = c2.getBillsTotal(vo.getReceivable_no());
		if(getbills > (int)inmap.get("receivable_total")) {
			msg = "총 채권금액에 초과합니다. 다시 확인해주세요.";
			url = "/c/c2/c22/inputBondbills?comcode_code="+comcode_code;
			
			return ViewPath.RESULT + "loginresult";
		}
		
		Erp_ClosingVO cvo = new Erp_ClosingVO();
		cvo.setClosing_code(receivable_clno);
		cvo.setCtgr_no(36);
		cvo.setComcode_no(comcode_no);
		cvo.setDebtor_no(deptno);
		cvo.setCreditor_no(creditno);
		cvo.setClosing_debtor(vo.getBondbills_total());
		cvo.setClosing_creditor(vo.getBondbills_total());
		
		c2.createClosing(cvo);
		
		Map<String, Object> dmap = c2.getBsNo(b1);
		Map<String, Object> cmap = c2.getBsNo(b2);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("bs3_amount", vo.getBondbills_total());
		map.put("bs3_no", dmap.get("bs3_no"));
		map.put("bs2_no", dmap.get("bsno2"));
		map.put("bs1_no", dmap.get("bs1_no"));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		map.put("bs3_amount", (-vo.getBondbills_total()));
		map.put("bs3_no", cmap.get("bs3_no"));
		map.put("bs2_no", cmap.get("bsno2"));
		map.put("bs1_no", cmap.get("bs1_no"));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		model.addAttribute("comcode_code", comcode_code);
		model.addAttribute("receivable_no", vo.getReceivable_no());
		
		return "redirect:/c/c2/c22/inputBondbills";
	}
	
	@RequestMapping("/c22/updateFormB")
	public String updateFormB(String comcode_code, Model model, Erp_BondbillsVO vo, String type, String word) {
		String msg = null;
		String url = null;
		
		if(comcode_code == "") {
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		List<Map<String, Object>> list = null;
		List<Erp_Bs3VO> dlist = c2.ctgrDebtor(36);
		List<Erp_Bs3VO> clist = c2.ctgrCreditor(36);
		
		int comcode_no = ls.comNo(comcode_code);
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		if(vo == null || vo.getReceivable_no() == 0) {
			list = c2.bondbillsList(map);
		}else {
			map.put("receivable_no", vo.getReceivable_no());
			list = c2.receiveBondbills(map);
		}
		
		Map<String, Object> inmap = c2.selectBondbills(vo.getBondbills_no()); 
		
		model.addAttribute("inmap", inmap);
		model.addAttribute("list", list);
		model.addAttribute("dlist", dlist);
		model.addAttribute("clist", clist);
		
		return ViewPath.C2 + "inputBondbills";
	}
	
	@RequestMapping("/c22/updateBondbills")
	@Transactional
	public String updateBonbills(String comcode_code, Model model, Erp_BondbillsVO vo, 
			String bs3_no11, String bs3_no21, String bs3_no12, String bs3_no22,
			String receivable_clno, String debtor_no, String creditor_no) {
		String msg = null;
		String url = null;
		
		if(comcode_code == "") {
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		int deptno = 0;
		int creditno = 0;
		int b11 = 0;
		int b21 = 0;
		int b12 = 0;
		int b22 = 0;
		
		if(debtor_no == "") {
			deptno = 0;
		}else {
			deptno = Integer.parseInt(debtor_no);
		}
		if(creditor_no == "") {
			creditno = 0;
		}else {
			creditno = Integer.parseInt(creditor_no);
		}
		
		if(bs3_no11 != null) {
			b11 = Integer.parseInt(bs3_no11);
		}
		if(bs3_no21 != null) {
			b21 = Integer.parseInt(bs3_no21);
		}
		if(bs3_no12.equals("")) {
			b12 = b11;
		}else {
			b12 = Integer.parseInt(bs3_no12);
		}
		if(bs3_no22.equals("")) {
			b22 = b21;
		}else {
			b22 = Integer.parseInt(bs3_no22);
		}
		
		Map<String, Object> imap = c2.selectBondbills(vo.getBondbills_no()); 
		
		c2.updateBills(vo);
		
		Erp_ClosingVO cvo = new Erp_ClosingVO();
		cvo.setClosing_code(receivable_clno);
		cvo.setDebtor_no(deptno);
		cvo.setCreditor_no(creditno);
		cvo.setClosing_debtor(vo.getBondbills_total());
		cvo.setClosing_creditor(vo.getBondbills_total());
		
		c2.updateClosing(cvo);
		Map<String, Object> map = new HashMap<>();
		
		Map<String, Object> dmap = c2.getBsNo(b11);
		Map<String, Object> cmap = c2.getBsNo(b21);
		
		map.put("bs3_amount", (-(int)imap.get("bondbills_total")));
		map.put("bs3_no", dmap.get("bs3_no"));
		map.put("bs2_no", dmap.get("bsno2"));
		map.put("bs1_no", dmap.get("bs1_no"));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		map.put("bs3_amount", (int)imap.get("bondbills_total"));
		map.put("bs3_no", cmap.get("bs3_no"));
		map.put("bs2_no", cmap.get("bsno2"));
		map.put("bs1_no", cmap.get("bs1_no"));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		dmap = c2.getBsNo(b12);
		cmap = c2.getBsNo(b22);
		
		map.put("bs3_amount", vo.getBondbills_total());
		map.put("bs3_no", dmap.get("bs3_no"));
		map.put("bs2_no", dmap.get("bsno2"));
		map.put("bs1_no", dmap.get("bs1_no"));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		map.put("bs3_amount", (-vo.getBondbills_total()));
		map.put("bs3_no", cmap.get("bs3_no"));
		map.put("bs2_no", cmap.get("bsno2"));
		map.put("bs1_no", cmap.get("bs1_no"));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		model.addAttribute("receivable_no", vo.getReceivable_no());
		model.addAttribute("comcode_code", comcode_code);
		model.addAttribute("bondbills_no", vo.getBondbills_no());
		
		return "redirect:/c/c2/c22/updateFormB";
	}
	
	@RequestMapping("/c22/deleteBondbills")
	@Transactional
	public String deleteBondbills(String comcode_code, Model model, Erp_BondbillsVO vo, 
			String bs3_no1, String bs3_no2, String receivable_code) {
		int b1 = 0;
		int b2 = 0;
		
		String msg = null;
		String url = null;
		
		if(comcode_code == "") {
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		if(bs3_no1 == "") {
			b1 = 0;
		}else {
			b1 = Integer.parseInt(bs3_no1);
		}
		if(bs3_no2 == "") {
			b2 = 0;
		}else {
			b2 = Integer.parseInt(bs3_no2);
		}
		
		c2.deleteBills(vo.getBondbills_no());
		
		int cno = c2.getClosingNo(receivable_code);
		
		c2.deleteClosing(cno);
		
		Map<String, Object> map = new HashMap<>();
		
		Map<String, Object> dmap = c2.getBsNo(b1);
		Map<String, Object> cmap = c2.getBsNo(b2);
		
		map.put("bs3_amount", (-vo.getBondbills_total()));
		map.put("bs3_no", dmap.get("bs3_no"));
		map.put("bs2_no", dmap.get("bsno2"));
		map.put("bs1_no", dmap.get("bs1_no"));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		map.put("bs3_amount", vo.getBondbills_total());
		map.put("bs3_no", cmap.get("bs3_no"));
		map.put("bs2_no", cmap.get("bsno2"));
		map.put("bs1_no", cmap.get("bs1_no"));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		model.addAttribute("comcode_code", comcode_code);
		model.addAttribute("receivable_no", vo.getReceivable_no());
		
		return "redirect:/c/c2/c22/inputBondbills";
	}
	
	
//	반품
	@RequestMapping("/c23/inputReturn")
	public String inputReturn(String comcode_code, Model model, String type, String word) {
		String msg = null;
		String url = null;
		
		if(comcode_code == "") {
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
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> list = c2.returnList(map);
		
		model.addAttribute("list", list);
		
		return ViewPath.C2 + "/c23/inputReturn";
	}
	
	@RequestMapping("/c23/returnAjax")
	@ResponseBody
	public List<Map<String, Object>> returnAjax(String comcode_code, String type, String word){
		int comcode_no = ls.comNo(comcode_code);
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> list = c2.returnList(map);
		
		return list;
	}
	
	@RequestMapping("/c23/createReturn")
	@Transactional
	public String createReturn(Erp_ReturnVO vo, String comcode_code, Model model, 
			String bs3_no1, String bs3_no2) {
		String msg = null;
		String url = null;
		
		if(comcode_code == "") {
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		vo.setComcode_no(comcode_no);
		
		c2.inputReturn(vo);
		
		Erp_ClosingVO cvo = new Erp_ClosingVO();
		cvo.setClosing_code(vo.getReturn_code());
		cvo.setClosing_debtor(vo.getReturn_total());
		cvo.setClosing_creditor(vo.getReturn_total());
		cvo.setComcode_no(comcode_no);
		cvo.setCtgr_no(37);
		cvo.setDebtor_no(6);
		cvo.setCreditor_no(1);
		
		c2.createClosing(cvo);
		
		Map<String, Object> dmap = c2.getBsNo(6);
		Map<String, Object> cmap = c2.getBsNo(1);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("bs3_amount", vo.getReturn_total());
		map.put("bs3_no", dmap.get("bs3_no"));
		map.put("bs2_no", dmap.get("bsno2"));
		map.put("bs1_no", dmap.get("bs1_no"));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		map.put("bs3_amount", (-vo.getReturn_total()));
		map.put("bs3_no", cmap.get("bs3_no"));
		map.put("bs2_no", cmap.get("bsno2"));
		map.put("bs1_no", cmap.get("bs1_no"));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		model.addAttribute("comcode_code", comcode_code);
		
		return "redirect:/c/c2/c23/inputReturn";
	}
	
	@RequestMapping("/c23/updateForm")
	public String updateFormRt(String comcode_code, Model model, Erp_ReturnVO vo, String type, String word) {
		String msg = null;
		String url = null;
		
		if(comcode_code == "") {
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
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> list = c2.returnList(map);
		
		Map<String, Object> inmap = c2.selectReturn(vo.getReturn_no());
		
		model.addAttribute("list", list);
		model.addAttribute("inmap", inmap);
		
		return ViewPath.C2 + "/c23/inputReturn";
	}
	
	@RequestMapping("/c23/updateReturn")
	@Transactional
	public String updateReturn(Erp_ReturnVO vo, Model model, String comcode_code) {
		String msg = null;
		String url = null;
		
		if(comcode_code == "") {
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		Map<String, Object> inmap = c2.selectReturn(vo.getReturn_no());
		
		int cno = c2.getClosingNo(vo.getReturn_code());
		
		c2.updateReturn(vo);
		
		Erp_ClosingVO cvo = new Erp_ClosingVO();
		cvo.setClosing_code(vo.getReturn_code());
		cvo.setClosing_debtor(vo.getReturn_total());
		cvo.setClosing_creditor(vo.getReturn_total());
		cvo.setDebtor_no(134);
		cvo.setCreditor_no(133);
		cvo.setClosing_no(cno);
		c2.updateClosing(cvo);
		
		Map<String, Object> map = new HashMap<>();
		
		Map<String, Object> dmap = c2.getBsNo(6);
		Map<String, Object> cmap = c2.getBsNo(1);
		
		map.put("bs3_amount", (-(int)inmap.get("return_total")));
		map.put("bs3_no", dmap.get("bs3_no"));
		map.put("bs2_no", dmap.get("bsno2"));
		map.put("bs1_no", dmap.get("bs1_no"));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		map.put("bs3_amount", (int)inmap.get("return_total"));
		map.put("bs3_no", cmap.get("bs3_no"));
		map.put("bs2_no", cmap.get("bsno2"));
		map.put("bs1_no", cmap.get("bs1_no"));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		map.put("bs3_amount", vo.getReturn_total());
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		map.put("bs3_amount", (-vo.getReturn_total()));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		model.addAttribute("comcode_code", comcode_code);
		
		return "redirect:/c/c2/c23/inputReturn";
	}
	
	@RequestMapping("/c23/delete")
	@Transactional
	public String deleteReturn(Erp_ReturnVO vo, Model model, String comcode_code) {
		String msg = null;
		String url = null;
		
		if(comcode_code == "") {
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		c2.deleteReturn(vo.getReturn_no());
		
		int cno = c2.getClosingNo(vo.getReturn_code());
		
		c2.deleteClosing(cno);
		
		Map<String, Object> map = new HashMap<>();
		
		Map<String, Object> dmap = c2.getBsNo(6);
		Map<String, Object> cmap = c2.getBsNo(1);
		
		map.put("bs3_amount", (-vo.getReturn_total()));
		map.put("bs3_no", dmap.get("bs3_no"));
		map.put("bs2_no", dmap.get("bsno2"));
		map.put("bs1_no", dmap.get("bs1_no"));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		map.put("bs3_amount", vo.getReturn_total());
		map.put("bs3_no", cmap.get("bs3_no"));
		map.put("bs2_no", cmap.get("bsno2"));
		map.put("bs1_no", cmap.get("bs1_no"));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		model.addAttribute("comcode_code", comcode_code);
		
		return "redirect:/c/c2/c23/inputReturn";
	}
	
	
//	국내영업매출
	@RequestMapping("/c25/inputLocalSales")
	public String inputLocalSales(Model model, String comcode_code, String type, String word) {
		String msg = null;
		String url = null;
		
		if(comcode_code == "") {
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
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> list = c2.localSalesList(map);
		
		model.addAttribute("list", list);
		
		return ViewPath.C2 + "/c25/inputLocalSales";
	}
	
	@RequestMapping("/c25/localsalesAjax")
	@ResponseBody
	public List<Map<String, Object>> localsalesAjax(String comcode_code, String type, String word){
		int comcode_no = ls.comNo(comcode_code);
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> list = c2.localSalesList(map);
		
		return list;
	}
	
	@RequestMapping("/c25/createLocalSales")
	@Transactional
	public String createLocalSales(Erp_LocalsalesVO vo, String comcode_code, Model model, 
			String bs3_no1, String bs3_no2, String debtor_no, String creditor_no, 
			String[] goods_no, String[] salesgoods_qty, String[] salesgoods_price, 
			String[] salesgoods_tax, String[] salesgoods_total) {
		String msg = null;
		String url = null;
		
		if(comcode_code == "") {
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		int deptno = 0;
		int creditno = 0;
		int b1 = 0;
		int b2 = 0;
		
		if(debtor_no == "") {
			deptno = 0;
		}else {
			deptno = Integer.parseInt(debtor_no);
		}
		if(creditor_no == "") {
			creditno = 0;
		}else {
			creditno = Integer.parseInt(creditor_no);
		}
		if(bs3_no1 == "") {
			b1 = 0;
		}else {
			b1 = Integer.parseInt(bs3_no1);
		}
		if(bs3_no2 == "") {
			b2 = 0;
		}else {
			b2 = Integer.parseInt(bs3_no2);
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		for(int i = 0; i < goods_no.length; i++) {
			int gno = 0;
			int qty = 0;
			int price = 0;
			int tax = 0;
			int total = 0;
			Erp_SalesgoodsVO svo = new Erp_SalesgoodsVO();
			if(goods_no[i] == "") {
				gno = 31;
			}else {
				gno = Integer.parseInt(goods_no[i]);
			}
			if(salesgoods_qty[i] != "") {
				qty = Integer.parseInt(salesgoods_qty[i]);
			}
			if(salesgoods_price[i] != "") {
				price = Integer.parseInt(salesgoods_price[i]);
			}
			if(salesgoods_tax[i] != "") {
				tax = Integer.parseInt(salesgoods_tax[i]);
			}
			if(salesgoods_total[i] != "") {
				total = Integer.parseInt(salesgoods_total[i]);
			}
			svo.setSalesgoods_price(price);
			svo.setSalesgoods_tax(tax);
			svo.setSalesgoods_total(total);
			svo.setSalesgoods_code(vo.getLocalsales_cino());
			svo.setGoods_no(gno);
			svo.setSalesgoods_qty(qty);
			c2.inputSalesGoods(svo);
		}
		
		vo.setComcode_no(comcode_no);
		
		c2.inputLocalSales(vo);
		
		Erp_ClosingVO cvo = new Erp_ClosingVO();
		cvo.setClosing_code(vo.getLocalsales_cino());
		cvo.setComcode_no(comcode_no);
		cvo.setDebtor_no(deptno);
		cvo.setCreditor_no(creditno);
		cvo.setClosing_debtor(vo.getLocalsales_total());
		cvo.setClosing_creditor(vo.getLocalsales_total());
		cvo.setCtgr_no(39);
		c2.createClosing(cvo);
		
		Map<String, Object> map = new HashMap<>();
		
		Map<String, Object> dmap = c2.getBsNo(b1);
		Map<String, Object> cmap = c2.getBsNo(b2);
		
		map.put("bs3_amount", vo.getLocalsales_total());
		map.put("bs3_no", dmap.get("bs3_no"));
		map.put("bs2_no", dmap.get("bsno2"));
		map.put("bs1_no", dmap.get("bs1_no"));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		map.put("bs3_amount", (-vo.getLocalsales_total()));
		map.put("bs3_no", cmap.get("bs3_no"));
		map.put("bs2_no", cmap.get("bsno2"));
		map.put("bs1_no", cmap.get("bs1_no"));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		model.addAttribute("comcode_code", comcode_code);
		
		return "redirect:/c/c2/c25/inputLocalSales";
	}
	
	@RequestMapping("/c25/updateForm")
	public String updateFormL(Model model, String comcode_code, Erp_LocalsalesVO vo, String type, String word) {
		String msg = null;
		String url = null;
		
		if(comcode_code == "") {
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
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> list = c2.localSalesList(map);
		
		List<Erp_SalesgoodsVO> slist = c2.getSGNo(vo.getLocalsales_cino());
		
		Map<String, Object> inmap = c2.selectLocalSales(vo.getLocalsales_no());
		
		model.addAttribute("slist", slist);
		model.addAttribute("list", list);
		model.addAttribute("inmap", inmap);
		
		return ViewPath.C2 + "/c25/inputLocalSales";
	}
	
	@RequestMapping("/c25/update")
	@Transactional
	public String updateLocalSales(Model model, String comcode_code, Erp_LocalsalesVO vo, 
			String bs3_no11, String bs3_no21, String bs3_no12, String bs3_no22, 
			String debtor_no, String creditor_no, 
			String[] goods_no, String[] salesgoods_qty, String[] salesgoods_price, 
			String[] salesgoods_tax, String[] salesgoods_total) {
		String msg = null;
		String url = null;
		
		if(comcode_code == "") {
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		int deptno = 0;
		int creditno = 0;
		int b11 = 0;
		int b21 = 0;
		int b12 = 0;
		int b22 = 0;
		
		if(debtor_no == "") {
			deptno = 0;
		}else {
			deptno = Integer.parseInt(debtor_no);
		}
		if(creditor_no == "") {
			creditno = 0;
		}else {
			creditno = Integer.parseInt(creditor_no);
		}
		
		if(bs3_no11 != null) {
			b11 = Integer.parseInt(bs3_no11);
		}
		if(bs3_no21 != null) {
			b21 = Integer.parseInt(bs3_no21);
		}
		if(bs3_no12.equals("")) {
			b12 = b11;
		}else {
			b12 = Integer.parseInt(bs3_no12);
		}
		if(bs3_no22.equals("")) {
			b22 = b21;
		}else {
			b22 = Integer.parseInt(bs3_no22);
		}
		
		Map<String, Object> inmap = c2.selectLocalSales(vo.getLocalsales_no());
		
		int cno = c2.getClosingNo(vo.getLocalsales_cino());
		
		c2.updateLocalSales(vo);
		
		for(int i = 0; i < goods_no.length; i++) {
			int gno = 0;
			int qty = 0;
			int price = 0;
			int tax = 0;
			int total = 0;
			Erp_SalesgoodsVO svo = new Erp_SalesgoodsVO();
			if(goods_no[i] == "") {
				gno = 31;
			}else {
				gno = Integer.parseInt(goods_no[i]);
			}
			if(salesgoods_qty[i] != "") {
				qty = Integer.parseInt(salesgoods_qty[i]);
			}
			if(salesgoods_price[i] != "") {
				price = Integer.parseInt(salesgoods_price[i]);
			}
			if(salesgoods_tax[i] != "") {
				tax = Integer.parseInt(salesgoods_tax[i]);
			}
			if(salesgoods_total[i] != "") {
				total = Integer.parseInt(salesgoods_total[i]);
			}
			svo.setSalesgoods_price(price);
			svo.setSalesgoods_tax(tax);
			svo.setSalesgoods_total(total);
			svo.setSalesgoods_code(vo.getLocalsales_cino());
			svo.setGoods_no(gno);
			svo.setSalesgoods_qty(qty);
			c2.updateSGNo(svo);
		}
		
		Erp_ClosingVO cvo = new Erp_ClosingVO();
		cvo.setClosing_code(vo.getLocalsales_cino());
		cvo.setClosing_debtor(vo.getLocalsales_total());
		cvo.setClosing_creditor(vo.getLocalsales_total());
		cvo.setDebtor_no(deptno);
		cvo.setCreditor_no(creditno);
		cvo.setClosing_no(cno);
		c2.updateClosing(cvo);
		
		Map<String, Object> map = new HashMap<>();
		
		Map<String, Object> dmap = c2.getBsNo(b11);
		Map<String, Object> cmap = c2.getBsNo(b21);
		
		map.put("bs3_amount", (-(int)inmap.get("localsales_total")));
		map.put("bs3_no", dmap.get("bs3_no"));
		map.put("bs2_no", dmap.get("bsno2"));
		map.put("bs1_no", dmap.get("bs1_no"));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		map.put("bs3_amount", (int)inmap.get("localsales_total"));
		map.put("bs3_no", cmap.get("bs3_no"));
		map.put("bs2_no", cmap.get("bsno2"));
		map.put("bs1_no", cmap.get("bs1_no"));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		dmap = c2.getBsNo(b12);
		cmap = c2.getBsNo(b22);
		
		map.put("bs3_amount", vo.getLocalsales_total());
		map.put("bs3_no", dmap.get("bs3_no"));
		map.put("bs2_no", dmap.get("bsno2"));
		map.put("bs1_no", dmap.get("bs1_no"));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		map.put("bs3_amount", (-vo.getLocalsales_total()));
		map.put("bs3_no", cmap.get("bs3_no"));
		map.put("bs2_no", cmap.get("bsno2"));
		map.put("bs1_no", cmap.get("bs1_no"));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		model.addAttribute("comcode_code", comcode_code);
		model.addAttribute("localsales_no", vo.getLocalsales_no());
		model.addAttribute("localsales_cino", vo.getLocalsales_cino());
		
		return "redirect:/c/c2/c25/updateForm";
	}
	
	@RequestMapping("/c25/delete")
	@Transactional
	public String deleteLocalSales(Model model, String comcode_code, Erp_LocalsalesVO vo, 
			String bs3_no1, String bs3_no2) {
		String msg = null;
		String url = null;
		
		if(comcode_code == "") {
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		int b1 = 0;
		int b2 = 0;
		
		if(bs3_no1 == "") {
			b1 = 0;
		}else {
			b1 = Integer.parseInt(bs3_no1);
		}
		if(bs3_no2 == "") {
			b2 = 0;
		}else {
			b2 = Integer.parseInt(bs3_no2);
		}
		
		c2.deleteLocalSales(vo.getLocalsales_no());
		
		int cno = c2.getClosingNo(vo.getLocalsales_cino());
		
		c2.deleteClosing(cno);
		
		c2.deleteSGCode(vo.getLocalsales_cino());
		
		Map<String, Object> map = new HashMap<>();
		
		Map<String, Object> dmap = c2.getBsNo(b1);
		Map<String, Object> cmap = c2.getBsNo(b2);
		
		map.put("bs3_amount", (-vo.getLocalsales_total()));
		map.put("bs3_no", dmap.get("bs3_no"));
		map.put("bs2_no", dmap.get("bsno2"));
		map.put("bs1_no", dmap.get("bs1_no"));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		map.put("bs3_amount", vo.getLocalsales_total());
		map.put("bs3_no", cmap.get("bs3_no"));
		map.put("bs2_no", cmap.get("bsno2"));
		map.put("bs1_no", cmap.get("bs1_no"));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		model.addAttribute("comcode_code", comcode_code);
		
		return "redirect:/c/c2/c25/inputLocalSales";
	}
	
}
