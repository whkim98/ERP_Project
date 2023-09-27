package com.lab.erp.controller.c;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lab.erp.service.c.C1Service;
import com.lab.erp.service.login.LoginService;
import com.lab.erp.vo.a.a1.Erp_BusinesstypeVO;
import com.lab.erp.vo.b.b1.Erp_Bs1VO;
import com.lab.erp.vo.b.b1.Erp_Bs2VO;
import com.lab.erp.vo.b.b1.Erp_Bs3VO;
import com.lab.erp.vo.b.b1.Erp_ClosingVO;
import com.lab.erp.vo.c.Erp_ClientVO;
import com.lab.erp.vo.c.c1.Erp_ForsalesVO;
import com.lab.erp.vo.c.c1.Erp_ImportVO;
import com.lab.erp.vo.c.c1.Erp_ImportorderVO;
import com.lab.erp.vo.c.c1.Erp_ImportpayVO;
import com.lab.erp.vo.d.d6.Erp_GoodsVO;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class C1Controller {

	private C1Service c1;
	private LoginService ls;
	
	@Autowired
	public C1Controller(C1Service c1, LoginService ls) {
		this.c1 = c1;
		this.ls = ls;
	}
	
	@RequestMapping("/internationalsales/list")
	public String list(Model model, String comcode_code, String type, String word) {
		int comcode_no = ls.comNo(comcode_code);
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("comcode_no", comcode_no);
		map.put("type", type);
		map.put("word", word);
		
		List<Map<String, Object>> list = c1.internationList(map);
		model.addAttribute("list", list);
		return "/c/c1/c11/internationList";
	}
	
	@RequestMapping("/internationalsales/bond/ajax")
	@ResponseBody
	public List<Map<String, Object>> ajax(Model model, String comcode_code, String type, String word) {
		Map<String, Object> map = new HashMap<>();
	      if(type == null || word == null) {
	         type = null;
	         word = null;
	      }
	      
	      int comcode_no = ls.comNo(comcode_code);
	      
	      map.put("comcode_no", comcode_no);
	      map.put("word", word);
	      map.put("type", type);
	      
	      List<Map<String, Object>> list = c1.internationList(map);
	      if(list.isEmpty()) {
		         list = null;
		      }
		      System.out.println(list);
		  return list;
	}
	
	@RequestMapping("/internationalsales/bond/insert")
	public String insert(String comcode_code, Erp_ClientVO vo, int country_no, String client_name, int clientsort_no, String client_registeredno, String client_corporatedno, String client_representative, String client_businesstype, String client_addr1, String client_addr2, String client_postal, String client_directno, String client_fax, String client_email, String client_manager, String client_contact) {
		
		int comcode_no = ls.comNo(comcode_code);
		
		System.out.println(comcode_code);
		System.out.println(comcode_no);
		
		vo.setCountry_no(country_no);
		vo.setClient_name(client_name);
		vo.setClientsort_no(clientsort_no);
		vo.setClient_registeredno(client_registeredno);
		vo.setClient_corporatedno(client_corporatedno);
		vo.setClient_representative(client_representative);
		vo.setClient_businesstype(client_businesstype);
		vo.setClient_addr1(client_addr1);
		vo.setClient_addr2(client_addr2);
		vo.setClient_postal(client_postal);
		vo.setClient_directno(client_directno);
		vo.setClient_fax(client_fax);
		vo.setClient_email(client_email);
		vo.setClient_manager(client_manager);
		vo.setClient_contact(client_contact);
		vo.setComcode_no(comcode_no);
		
		c1.insertClient(vo);
		
		return "redirect:/internationalsales/list?comcode_code=" + comcode_code;
	}
	
	@RequestMapping("/internationalsales/bond/typeinsert")
	public String type(int client_no, int businesstype_no) {
		Map<String, Object> map = new HashMap<>();
		map.put("client_no", client_no);
		map.put("businesstype_no", businesstype_no);
		c1.updateClient(map);
		return "";
	}
	
	@RequestMapping("/internationalsales/bond/typeinsertForm")
	public String type(int client_no, Model model) {
		List<Erp_BusinesstypeVO> list = c1.selectType();
		model.addAttribute("list", list);
		model.addAttribute("client_no", client_no);
		return "/c/c1/c11/typeinsertForm";
	}
	
//	@RequestMapping("/internationalsales/bond")
//	public String bond(Model model) {
//		List<Erp_ReceivableVO> list = c1.selectReceivable();
//		model.addAttribute("list", list);
//		return "/c/c1/c11/bondlist";
//	}
	
	
//	
//	@RequestMapping("/internationalsales/export/insertForm")
//	public String insertForm(Model model) {
//	//	List<Erp_ClientVO> list = c1.internationList();
//		List<Erp_GoodsVO> glist = c1.selectGoods();
//	//	model.addAttribute("list", list);
//		model.addAttribute("glist", glist);
//		return "/c/c1/c13/insertForm";
//	}
	
		
//	@RequestMapping("/internationalsales/importpay")
//	public String importpay(Model model, Erp_ImportpayVO vo) {
//		List<Erp_ImportpayVO> list = c1.selectImportpay();
//		model.addAttribute("list", list);
//		return "/c/c1/c14/importpayList";
//	}
	
	@RequestMapping("/internationalsales/bond/updateForm")
	public String updateForm(String type, String word, Model model, String comcode_code, int client_no) {
		int comcode_no = ls.comNo(comcode_code);
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("comcode_no", comcode_no);
		map.put("client_no", client_no);
		map.put("type", type);
		map.put("word", word);
		
		map = c1.internationList2(map);
		
		System.out.println(map);
	
		List<Map<String, Object>> list = c1.internationList(map);
		model.addAttribute("list", list);
		model.addAttribute("map", map);
		
		return "/c/c1/c11/internationList";
	}
	
	@RequestMapping("/internationsales/bond/update")
	public String internationsalesUpdate(String comcode_code, 
			int client_no, int country_no, int businesstype_no,
			String client_name, int clientsort_no, String client_registeredno
			, String client_corporatedno, String client_representative,
			String client_businesstype, String client_postal,
			String client_addr1, String client_addr2, String client_directno,
			String client_fax, String client_email, String client_manager,
			String client_contact) {
		
		Map<String, Object> map = new HashMap<>();
		map.put("country_no", country_no);
		map.put("client_name", client_name);
		map.put("clientsort_no", clientsort_no);
		map.put("client_registeredno", client_registeredno);
		map.put("client_corporatedno", client_corporatedno);
		map.put("client_representative", client_representative);
		map.put("client_businesstype", client_businesstype);
		map.put("businesstype_no", businesstype_no);
		map.put("client_addr1", client_addr1);
		map.put("client_addr2", client_addr2);
		map.put("client_postal", client_postal);
		map.put("client_directno", client_directno);
		map.put("client_fax", client_fax);
		map.put("client_email", client_email);
		map.put("client_manager", client_manager);
		map.put("client_contact", client_contact);
		map.put("client_no", client_no);
		
		c1.updateClient2(map);
		
		return "redirect:/internationalsales/list?comcode_code=" + comcode_code;
	}
	
	@RequestMapping("/internationsales/delete")
	public String deleteInternationsales(String comcode_code, int client_no) {
		
		c1.deleteClient2(client_no);
		
		return "redirect:/internationalsales/list?comcode_code=" + comcode_code;
	}
	
	
//수입, 수출 채무 
	
	//수입발주관리 리스트
	@RequestMapping("/internationsales/income")
	public String income(Model model, @RequestParam(required = false) Integer client_no2, String comcode_code, String type, String word) {
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("comcode_no", comcode_no);
		map.put("type", type);
		map.put("word", word);
		
		List<Map<String, Object>> list = c1.selectImportorder(map);
		
		List<Erp_ClientVO> clist = c1.selectClientlist();
		
		//List<Erp_GoodsVO> glist = c1.selectGoodslist(client_no2);
		
		model.addAttribute("list", list);
		model.addAttribute("clist", clist);
		//model.addAttribute("glist", glist);
		
		return "/c/c1/c16/incomeList";
	}
	
	@RequestMapping("/internationalsales/income/ajax")
	@ResponseBody
	public List<Map<String, Object>> incomeAjax(Model model, String comcode_code, String type, String word){
		Map<String, Object> map = new HashMap<>();
	      if(type == null || word == null) {
	         type = null;
	         word = null;
	      }
	      
	      int comcode_no = ls.comNo(comcode_code);
	      
	      map.put("comcode_no", comcode_no);
	      map.put("word", word);
	      map.put("type", type);
	      
	      List<Map<String, Object>> list = c1.selectImportorder(map);
	      if(list.isEmpty()) {
		         list = null;
		      }
		      System.out.println(list);
		  return list;
	}
	
	@RequestMapping("/internationsales/income/goods")
	@ResponseBody
	public List<Erp_GoodsVO> goods(Model model, @RequestParam(required = false) Integer client_no2) {
		
		System.out.println(client_no2);
		
		List<Erp_GoodsVO> glist = c1.selectGoodslist(client_no2);
		model.addAttribute("glist", glist);
		
		Map<String, Object> map = new HashMap<>();
		map.put("client_no2", client_no2);
		
		//map = c1.selectGoodslist2(map);
		
		model.addAttribute("map", map);
		return glist;
	}
	
	@RequestMapping("/internationsales/income/updateGoods")
	@ResponseBody
	public List<Erp_GoodsVO> updateGoods(Model model, @RequestParam(required = false) Integer client_no2) {
		List<Erp_GoodsVO> glist = c1.selectGoodslist(client_no2);
		model.addAttribute("glist", glist);
		
		Map<String, Object> map = new HashMap<>();
		map.put("client_no2", client_no2);
		
		map = c1.selectGoodslist2(map);
		
		model.addAttribute("map", map);
		return glist;
	}
	
	//수입발주관리 추가등록 눌렀을 때 erp_importpay도 같이 insert
	@RequestMapping("/internationsales/income/insertImportorder")
	public String insertImportorder(Erp_ImportpayVO ivo, Erp_ImportorderVO vo, String comcode_code, String importorder_code, Integer goods_no, int team_no, String importorder_date, int client_no, String importpay_expiry, int incoterms_no, int settletype_no) {
		
		System.out.println(comcode_code);
		
		int comcode_no = ls.comNo(comcode_code);
		
		System.out.println(client_no);
		System.out.println(goods_no);
		
		int importorder_price = c1.selectSumprice(goods_no);
		int importorder_tax = c1.selectTax(goods_no);
		
		int importorder_stored = 0;
		
		System.out.println("거래처"+client_no);
		System.out.println("상품"+goods_no);
		
		vo.setComcode_no(comcode_no);
		vo.setImportorder_code(importorder_code);
		vo.setImportorder_date(importorder_date);
		vo.setTeam_no(team_no);
		vo.setClient_no(client_no);
		vo.setGoods_no(goods_no);
		vo.setIncoterms_no(incoterms_no);
		vo.setSettletype_no(settletype_no);
		vo.setImportorder_stored(importorder_stored);
		vo.setImportorder_price(importorder_price);
		vo.setImportorder_tax(importorder_tax);
		vo.setImportorder_total(importorder_price + importorder_tax);		
		c1.insertImportorder(vo);
		
		int importorder_no = c1.selectImportorderno(importorder_code);
		ivo.setImportpay_payable(importorder_stored);
		ivo.setImportorder_no(importorder_no);
		ivo.setImportpay_code(importorder_code);
		ivo.setImportpay_expiry(importpay_expiry);
		ivo.setClient_no(client_no);
		ivo.setComcode_no(comcode_no);
		c1.insertImportpay(ivo);
		
		return "redirect:/internationsales/income?comcode_code="+comcode_code;
	}
	
	//수입발주 수정폼
	@RequestMapping("/internationsales/income/updateForm")
	public String incomeUpdateform(Model model, String comcode_code, String type, String word, int importorder_no) {
		int comcode_no = ls.comNo(comcode_code);
		
		try {
			int import_no = c1.selectImportno(importorder_no);
			//closing_no 뽑기 위해서 hidden으로 다시 넘겨줌
			model.addAttribute("import_no", import_no);
		} catch (Exception e) {
			int import_no = 0;
			//closing_no 뽑기 위해서 hidden으로 다시 넘겨줌
			model.addAttribute("import_no", import_no);
		}
		
		
		int importpay_no = c1.selectImportpayno(importorder_no);
		
		System.out.println("페이엔오" + importpay_no);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("comcode_no", comcode_no);
		map.put("importorder_no", importorder_no);
		
		map = c1.selectIncomeupdate(map);
		
		Map<String, Object> map2 = new HashMap<>();
		
		map2.put("comcode_no", comcode_no);
		map2.put("type", type);
		map2.put("word", word);
		
		List<Map<String, Object>> list = c1.selectImportorder(map2);
		
		Map<String, Object> map3 = new HashMap<>();
		map3.put("comcode_no", comcode_no);
		map3.put("importpay_no", importpay_no);
		
		map3 = c1.selectImportpayupdate(map3);
		
		
		//뷰에서 importorder_stored가 1이면 재무상태표 계정과목도 선택할 수 
		//있게 하고 0이면 출력 안 함
		List<Erp_Bs1VO> dlist = c1.selectBsd();
		List<Erp_Bs1VO> clist = c1.selectBsc();
		
		List<Erp_ClientVO> cllist = c1.selectClientlist();
		
		model.addAttribute("map", map);
		model.addAttribute("map3", map3);
		model.addAttribute("list", list);
		model.addAttribute("dlist", dlist);
		model.addAttribute("clist", clist);
		model.addAttribute("cllist", cllist);
		
		
		
		//뷰에서 importorder_total값 다시 받아서 그만큼 부호 반대로 계산하고
		//새로운 total 계산해서 다시 빼줘야 함(importorder_total은 readonly로)
		//bs3_no를 hidden으로 넘겨서 다시 받아오기(update에서 쓸거임)
		
		return "/c/c1/c16/incomeList";
		
	}
	
	//수입발주 수정
	@RequestMapping("/internationsales/income/update")
	public String incomeupdate(String comcode_code, HttpServletRequest request, Erp_ClosingVO cvo, Erp_Bs1VO b1vo, Erp_Bs2VO b2vo, Erp_Bs3VO b3vo, @RequestParam(required = false) Integer import_no, @RequestParam(required = false) Integer incoterms_no, @RequestParam(required = false) Integer settletype_no, @RequestParam(required = false) Integer team_no, String importorder_date, @RequestParam(required = false) Integer client_no, @RequestParam(required = false) Integer goods_no, @RequestParam(required = false) Integer importorder_no, String importpay_expiry, @RequestParam(required = false) Integer importpay_no) {
		
		System.out.println("업데이트로 왔어요");
		
		int bs3_no = Integer.parseInt(request.getParameter("bs3_no"));
		int dbs3_no = Integer.parseInt(request.getParameter("dbs3_no"));
		
		System.out.println("bs3_no: "+ bs3_no);
		System.out.println("dbs3_no: "+ dbs3_no);
		
		System.out.println("업데이트payno="+importpay_no);
		System.out.println("임포트오더no=" + importorder_no);
		
		int importorder_price = c1.selectSumprice(goods_no);
		int importorder_tax = c1.selectTax(goods_no);
		
		
		Map<String, Object> map = new HashMap<>();
		map.put("importorder_no", importorder_no);
		map.put("importorder_price", importorder_price);
		map.put("importorder_tax", importorder_tax);
		map.put("importorder_date", importorder_date);
		map.put("client_no", client_no);
		map.put("goods_no", goods_no);
		map.put("team_no", team_no);
		map.put("incoterms_no", incoterms_no);
		map.put("settletype_no", settletype_no);
		
		c1.updateImportorder(map);
		
		
		System.out.println(importpay_expiry);
		Map<String, Object> map2 = new HashMap<>();
		map2.put("client_no", client_no);
		map2.put("importpay_expiry", importpay_expiry);
		map2.put("importpay_no", importpay_no);
		
		c1.updateImportpay(map2);
		
		//뷰에서 bs3_no를 넘긴 게 있으면 재무상태표 수정 
		//없으면 안 함(if사용)
		if(bs3_no != 0 || dbs3_no != 0) {
			//재무상태표
			int bs_no = c1.selectBsno(bs3_no);
			int bs2_no = c1.selectBsno2(bs3_no);

			//대변 in 재무상태표
			b3vo.setBs3_no(bs3_no);
			b2vo.setBs2_no(bs2_no);
			b1vo.setBs1_no(bs_no);
			
			b3vo.setBs3_amount(-(importorder_price + importorder_tax));
			b2vo.setBs2_amount(-(importorder_price + importorder_tax));
			b1vo.setBs1_amount(-(importorder_price + importorder_tax));
			
			c1.updateBs(b1vo);
			c1.updateBs2(b2vo);
			c1.updateBs3(b3vo);
			
			b3vo.setBs3_amount(importorder_price + importorder_tax);
			b2vo.setBs2_amount(importorder_price + importorder_tax);
			b1vo.setBs1_amount(importorder_price + importorder_tax);
			
			c1.updateBs(b1vo);
			c1.updateBs2(b2vo);
			c1.updateBs3(b3vo);
			
			bs_no = c1.selectBsno(dbs3_no);
			bs2_no = c1.selectBsno2(dbs3_no);
			
			b3vo.setBs3_no(dbs3_no);
			b2vo.setBs2_no(bs2_no);
			b1vo.setBs1_no(bs_no);
			
			b3vo.setBs3_amount(importorder_price + importorder_tax);
			b2vo.setBs2_amount(importorder_price + importorder_tax);
			b1vo.setBs1_amount(importorder_price + importorder_tax);
			
			c1.updateBs(b1vo);
			c1.updateBs2(b2vo);
			c1.updateBs3(b3vo);
			
			b3vo.setBs3_amount(-(importorder_price + importorder_tax));
			b2vo.setBs2_amount(-(importorder_price + importorder_tax));
			b1vo.setBs1_amount(-(importorder_price + importorder_tax));
			
			c1.updateBs(b1vo);
			c1.updateBs2(b2vo);
			c1.updateBs3(b3vo);
			
			int debtor_no = c1.selectDebtor(bs3_no);
			
			int creditor_no = c1.selectCreditor(dbs3_no);
			
			String import_blno = c1.selectImportblno(import_no);
			
			int closing_no = c1.selectClosingno(import_blno);
			
			Map<String, Object> map3 = new HashMap<>();
			
			map3.put("debtor_no", debtor_no);
			map3.put("closing_debtor", importorder_price + importorder_tax);
			map3.put("creditor_no", creditor_no);
			map3.put("closing_creditor", -(importorder_price + importorder_tax));
			map3.put("closing_no", closing_no);
			
			c1.updateClosing2(map3);
			
		} else if(bs3_no == 0 || dbs3_no == 0) {
			
		}
		
		return "redirect:/internationsales/income?comcode_code=" + comcode_code;
	}
	
	//cino, blno설정 폼
	@RequestMapping("/internationsales/income/storedform")
	public String storedform(Model model, @RequestParam(required = false) Integer importorder_no) {
		System.out.println("스토어드폼왔다");
		List<Erp_Bs1VO> listd = c1.selectBsd2();
		List<Erp_Bs1VO> listc = c1.selectBsc2();
		
		System.out.println(listd);
		
		//재무상태표 계정과목 선택
		model.addAttribute("listd", listd);
		model.addAttribute("listc", listc);
		
		//수입테이블에 importorder번호 insert 시켜야 해서 view에서 hidden
		//으로 다시 넘겨줌
		System.out.println(importorder_no);
		model.addAttribute("importorder_no", importorder_no);
		return "/c/c1/c16/storedForm";
	}
	
	//입고여부 변경(입고예정 0 / 입고완료 1) *수입파트에서는 따로 insert가 불가능하고
	//여기서 버튼 누르면 입고 완료로 바뀌고 수입테이블에 insert도 자동으로 시키게 ㄱ
	@RequestMapping("/internationsales/income/stored")
	public String stored(Model model, Erp_ImportVO vo, Erp_ClosingVO cvo, Erp_Bs1VO b1vo, Erp_Bs2VO b2vo, Erp_Bs3VO b3vo, int bs3_no, int dbs3_no, String comcode_code, String import_cino, String import_blno, @RequestParam(required = false) Integer importorder_no) {
		
		System.out.println("임폴트오더엔"+importorder_no);
		
		System.out.println(bs3_no);
		
		int importpay_no = c1.selectImportpayno(importorder_no);
		
		int debtor_no = c1.selectDebtor(bs3_no);
		
		int creditor_no = c1.selectCreditor(dbs3_no);
		
		int total = c1.selectTotal(importorder_no);
		
		int stored = 1;
		
		//입고여부변경
		Map<String, Object> map = new HashMap<>();
		map.put("importorder_no", importorder_no);
		map.put("importorder_stored", stored);
		
		c1.updateStored(map);
		
		//채권지급여부 변경
		Map<String, Object> map2 = new HashMap<>();
		map2.put("importpay_payable", 1);
		map2.put("importpay_no", importpay_no);
		
		c1.updatePayable(map2);
		
		//수입 insert
		
		int comcode_no = ls.comNo(comcode_code);
		
		vo.setComcode_no(comcode_no);
		vo.setImport_cino(import_cino);
		vo.setImport_blno(import_blno);
		vo.setImportorder_no(importorder_no);
		
		c1.insertImport(vo);
		
		//일마감 테이블 insert
		cvo.setClosing_code(import_blno);
		cvo.setClosing_creditor(-total);
		cvo.setClosing_debtor(total);
		cvo.setComcode_no(comcode_no);
		cvo.setCreditor_no(creditor_no);
		cvo.setDebtor_no(debtor_no);
		c1.insertClosing(cvo);
		
		//재무상태표
		int bs_no = c1.selectBsno(bs3_no);
		int bs2_no = c1.selectBsno2(bs3_no);

		//대변 in 재무상태표
		b3vo.setBs3_no(bs3_no);
		b2vo.setBs2_no(bs2_no);
		b1vo.setBs1_no(bs_no);
		
		b3vo.setBs3_amount(total);
		b2vo.setBs2_amount(total);
		b1vo.setBs1_amount(total);
		
		c1.updateBs(b1vo);
		c1.updateBs2(b2vo);
		c1.updateBs3(b3vo);
		
		//차변 in 재무상태표
		bs_no = c1.selectBsno(dbs3_no);
		bs2_no = c1.selectBsno2(dbs3_no);
		
		b3vo.setBs3_no(dbs3_no);
		b2vo.setBs2_no(bs2_no);
		b1vo.setBs1_no(bs_no);
		
		b3vo.setBs3_amount(-total);
		b2vo.setBs2_amount(-total);
		b1vo.setBs1_amount(-total);
		
		c1.updateBs(b1vo);
		c1.updateBs2(b2vo);
		c1.updateBs3(b3vo);

		
		return "redirect:/internationsales/income?comcode_code="+comcode_code;
	}
	
	@RequestMapping("/internationsales/income/stored2")
	public String stored2(String comcode_code, int importorder_total, Erp_Bs1VO b1vo, Erp_Bs2VO b2vo, Erp_Bs3VO b3vo, int importorder_no, String importorder_blno) {
		Map<String, Object> map = new HashMap<>();
		map.put("importorder_stored", 0);
		map.put("importorder_no", importorder_no);
		c1.updateStored2(map);
		
		int debtor_no = c1.selectDebtorno2(importorder_blno);
		int creditor_no = c1.selectCreditorno2(importorder_blno);
		
		int bs3_no = c1.selectBs3Nod(debtor_no);
		int dbs3_no = c1.selectBs3Noc(creditor_no);
		
		int bs_no = c1.selectBsno(bs3_no);
		int bs2_no = c1.selectBsno2(bs3_no);
		
		b3vo.setBs3_no(bs3_no);
		b2vo.setBs2_no(bs2_no);
		b1vo.setBs1_no(bs_no);
		
		b3vo.setBs3_amount(-importorder_total);
		b2vo.setBs2_amount(-importorder_total);
		b1vo.setBs1_amount(-importorder_total);
		
		c1.updateBs(b1vo);
		c1.updateBs2(b2vo);
		c1.updateBs3(b3vo);
		
		return "redirect:/internationsales/income?comcode_code="+comcode_code;
	}
	
	@RequestMapping("/internationsales/income/delete")
	public String incomeDelete(@RequestParam(required = false) Integer importorder_no, @RequestParam(required = false) Integer bs3_no, @RequestParam(required = false) String comcode_code) {
		System.out.println(importorder_no);
		//c1.deleteImport(importorder_no);
		c1.deleteImportorder(importorder_no);
		return "redirect:/internationsales/income?comcode_code="+comcode_code;
	}
	
	//수입관리(재무상태표 포함)
	@RequestMapping("/internationsales/import")
	public String importt(Model model, String comcode_code, String type, String word) {
		int comcode_no = ls.comNo(comcode_code);
		
		List<Erp_Bs1VO> listd = c1.selectBsd();
		List<Erp_Bs1VO> listc = c1.selectBsc();
		
		Map<String, Object> map = new HashMap<>();
		map.put("comcode_no", comcode_no);
		map.put("type", type);
		map.put("word", word);
		
		List<Map<String, Object>> list = c1.selectImport(map);
		model.addAttribute("list", list);
		model.addAttribute("listd", listd);
		model.addAttribute("listc", listc);	
		return "c/c1/c15/importList";
		
	}
	
	@RequestMapping("/internationsales/import/updateForm")
	public String importupdateForm(String type, String word, Model model, String comcode_code, int import_no) {
		
		int comcode_no = ls.comNo(comcode_code);
		
		
		Map<String, Object> map = new HashMap<>();
		map.put("comcode_no", comcode_no);
		map.put("import_no", import_no);
		
		map = c1.selectimportUpdate(map);
		
		Map<String, Object> map2 = new HashMap<>();
		map2.put("comcode_no", comcode_no);
		map2.put("import_no", import_no);
		
		map2 = c1.selectimportUpdate2(map2);
		
		Map<String, Object> map3 = new HashMap<>();
		map3.put("comcode_no", comcode_no);
		map3.put("type", type);
		map3.put("word", word);
		
		List<Map<String, Object>> list = c1.selectImport(map3);
		List<Erp_Bs1VO> listd = c1.selectBsd2();
		List<Erp_Bs1VO> listc = c1.selectBsc2();
		
		model.addAttribute("list", list);
		model.addAttribute("listd", listd);
		model.addAttribute("listc", listc);
		
		model.addAttribute("map", map);
		model.addAttribute("map2", map2);
		
		//blno가져와서 closing_no가져올 때 쓸거임(hidden으로 다음 메소드에 넘기기)
		model.addAttribute("import_no", import_no);		
		return "c/c1/c15/importList";
	}
	
	@RequestMapping("/internationsales/import/update")
	public String importUpdate(Erp_Bs1VO b1vo, Erp_Bs2VO b2vo, Erp_Bs3VO b3vo, int bs3_no, int dbs3_no, String comcode_code, String import_date, String closing_date, String import_cino, String import_blno, int import_no) {
		
		int debtor_no = c1.selectDebtorno(bs3_no);
		int creditor_no = c1.selectCreditorno(dbs3_no);
		
		System.out.println(bs3_no);
		System.out.println(debtor_no);
		System.out.println(creditor_no);
		
		int importorder_no = c1.selectImportorderno2(import_no);
		
		int total = c1.selectTotal(importorder_no);
		
		int bs_no = c1.selectBsno(bs3_no);
		int bs2_no = c1.selectBsno2(bs3_no);
		
		if(bs3_no == 6 && dbs3_no == 21) {
			
			b3vo.setBs3_no(bs3_no);
			b2vo.setBs2_no(bs2_no);
			b1vo.setBs1_no(bs_no);
			
			b3vo.setBs3_amount(total);
			b2vo.setBs2_amount(total);
			b1vo.setBs1_amount(total);
			
			c1.updateBs(b1vo);
			c1.updateBs2(b2vo);
			c1.updateBs3(b3vo);
			
			bs3_no = 7;
			b3vo.setBs3_no(bs3_no);
			b2vo.setBs2_no(bs2_no);
			b1vo.setBs1_no(bs_no);
			
			b3vo.setBs3_amount(-total);
			b2vo.setBs2_amount(-total);
			b1vo.setBs1_amount(-total);
			
			c1.updateBs(b1vo);
			c1.updateBs2(b2vo);
			c1.updateBs3(b3vo);
			
			
			bs_no = c1.selectBsno(dbs3_no);
			bs2_no = c1.selectBsno2(dbs3_no);
			
			b3vo.setBs3_no(dbs3_no);
			b2vo.setBs2_no(bs2_no);
			b1vo.setBs1_no(bs_no);
			
			b3vo.setBs3_amount(-total);
			b2vo.setBs2_amount(-total);
			b1vo.setBs1_amount(-total);
			
			c1.updateBs(b1vo);
			c1.updateBs2(b2vo);
			c1.updateBs3(b3vo);
			
			dbs3_no = 1;
			bs_no = c1.selectBsno(dbs3_no);
			bs2_no = c1.selectBsno2(dbs3_no);
			
			b3vo.setBs3_no(dbs3_no);
			b2vo.setBs2_no(bs2_no);
			b1vo.setBs1_no(bs_no);
			
			b3vo.setBs3_amount(total);
			b2vo.setBs2_amount(total);
			b1vo.setBs1_amount(total);
			
			c1.updateBs(b1vo);
			c1.updateBs2(b2vo);
			c1.updateBs3(b3vo);
			
		}else if(bs3_no == 7 && dbs3_no == 1) {
			b3vo.setBs3_no(bs3_no);
			b2vo.setBs2_no(bs2_no);
			b1vo.setBs1_no(bs_no);
			
			b3vo.setBs3_amount(total);
			b2vo.setBs2_amount(total);
			b1vo.setBs1_amount(total);
			
			c1.updateBs(b1vo);
			c1.updateBs2(b2vo);
			c1.updateBs3(b3vo);
			
			bs3_no = 6;
			b3vo.setBs3_no(bs3_no);
			b2vo.setBs2_no(bs2_no);
			b1vo.setBs1_no(bs_no);
			
			b3vo.setBs3_amount(-total);
			b2vo.setBs2_amount(-total);
			b1vo.setBs1_amount(-total);
			
			c1.updateBs(b1vo);
			c1.updateBs2(b2vo);
			c1.updateBs3(b3vo);
			
			
			bs_no = c1.selectBsno(dbs3_no);
			bs2_no = c1.selectBsno2(dbs3_no);
			
			b3vo.setBs3_no(dbs3_no);
			b2vo.setBs2_no(bs2_no);
			b1vo.setBs1_no(bs_no);
			
			b3vo.setBs3_amount(-total);
			b2vo.setBs2_amount(-total);
			b1vo.setBs1_amount(-total);
			
			c1.updateBs(b1vo);
			c1.updateBs2(b2vo);
			c1.updateBs3(b3vo);
			
			dbs3_no = 21;
			bs_no = c1.selectBsno(dbs3_no);
			bs2_no = c1.selectBsno2(dbs3_no);
			
			b3vo.setBs3_no(dbs3_no);
			b2vo.setBs2_no(bs2_no);
			b1vo.setBs1_no(bs_no);
			
			b3vo.setBs3_amount(total);
			b2vo.setBs2_amount(total);
			b1vo.setBs1_amount(total);
			
			c1.updateBs(b1vo);
			c1.updateBs2(b2vo);
			c1.updateBs3(b3vo);
		} else if(bs3_no == 6 && dbs3_no == 1) {
			b3vo.setBs3_no(bs3_no);
			b2vo.setBs2_no(bs2_no);
			b1vo.setBs1_no(bs_no);
			
			b3vo.setBs3_amount(total);
			b2vo.setBs2_amount(total);
			b1vo.setBs1_amount(total);
			
			c1.updateBs(b1vo);
			c1.updateBs2(b2vo);
			c1.updateBs3(b3vo);
			
			bs3_no = 7;
			b3vo.setBs3_no(bs3_no);
			b2vo.setBs2_no(bs2_no);
			b1vo.setBs1_no(bs_no);
			
			b3vo.setBs3_amount(-total);
			b2vo.setBs2_amount(-total);
			b1vo.setBs1_amount(-total);
			
			c1.updateBs(b1vo);
			c1.updateBs2(b2vo);
			c1.updateBs3(b3vo);
			
			
			bs_no = c1.selectBsno(dbs3_no);
			bs2_no = c1.selectBsno2(dbs3_no);
			
			b3vo.setBs3_no(dbs3_no);
			b2vo.setBs2_no(bs2_no);
			b1vo.setBs1_no(bs_no);
			
			b3vo.setBs3_amount(-total);
			b2vo.setBs2_amount(-total);
			b1vo.setBs1_amount(-total);
			
			c1.updateBs(b1vo);
			c1.updateBs2(b2vo);
			c1.updateBs3(b3vo);
			
			dbs3_no = 21;
			bs_no = c1.selectBsno(dbs3_no);
			bs2_no = c1.selectBsno2(dbs3_no);
			
			b3vo.setBs3_no(dbs3_no);
			b2vo.setBs2_no(bs2_no);
			b1vo.setBs1_no(bs_no);
			
			b3vo.setBs3_amount(total);
			b2vo.setBs2_amount(total);
			b1vo.setBs1_amount(total);
			
			c1.updateBs(b1vo);
			c1.updateBs2(b2vo);
			c1.updateBs3(b3vo);
		} else if(bs3_no == 7 && dbs3_no == 21) {
			b3vo.setBs3_no(bs3_no);
			b2vo.setBs2_no(bs2_no);
			b1vo.setBs1_no(bs_no);
			
			b3vo.setBs3_amount(total);
			b2vo.setBs2_amount(total);
			b1vo.setBs1_amount(total);
			
			c1.updateBs(b1vo);
			c1.updateBs2(b2vo);
			c1.updateBs3(b3vo);
			
			bs3_no = 6;
			b3vo.setBs3_no(bs3_no);
			b2vo.setBs2_no(bs2_no);
			b1vo.setBs1_no(bs_no);
			
			b3vo.setBs3_amount(-total);
			b2vo.setBs2_amount(-total);
			b1vo.setBs1_amount(-total);
			
			c1.updateBs(b1vo);
			c1.updateBs2(b2vo);
			c1.updateBs3(b3vo);
			
			
			bs_no = c1.selectBsno(dbs3_no);
			bs2_no = c1.selectBsno2(dbs3_no);
			
			b3vo.setBs3_no(dbs3_no);
			b2vo.setBs2_no(bs2_no);
			b1vo.setBs1_no(bs_no);
			
			b3vo.setBs3_amount(-total);
			b2vo.setBs2_amount(-total);
			b1vo.setBs1_amount(-total);
			
			c1.updateBs(b1vo);
			c1.updateBs2(b2vo);
			c1.updateBs3(b3vo);
			
			dbs3_no = 1;
			bs_no = c1.selectBsno(dbs3_no);
			bs2_no = c1.selectBsno2(dbs3_no);
			
			b3vo.setBs3_no(dbs3_no);
			b2vo.setBs2_no(bs2_no);
			b1vo.setBs1_no(bs_no);
			
			b3vo.setBs3_amount(total);
			b2vo.setBs2_amount(total);
			b1vo.setBs1_amount(total);
			
			c1.updateBs(b1vo);
			c1.updateBs2(b2vo);
			c1.updateBs3(b3vo);
		}
		
		int comcode_no = ls.comNo(comcode_code);
		String closing_code = c1.selectImportblno(import_no);
		
		int closing_no = c1.selectClosingno(closing_code);
		//수입테이블 수정
		Map<String, Object> map = new HashMap<>();
		
		map.put("comcode_no", comcode_no);
		map.put("import_cino", import_cino);		
		map.put("import_blno", import_blno);
		map.put("import_no", import_no);
		c1.importUpdate(map);
		
		//바뀐 수입테이블에 따른 일마감테이블 수정
		Map<String, Object> map3 = new HashMap<>();
		
		map3.put("closing_date", closing_date);
		map3.put("debtor_no", debtor_no);
		map3.put("creditor_no", creditor_no);
		map3.put("closing_code", import_blno);
		map3.put("closing_no", closing_no);
		c1.closingUpdate(map3);
		
		//여기서는 importpay나 재무상태표는 update할 필요 없음
		//왜냐면 import테이블 구조를 보면 알고 재무상태표는 발주테이블을 수정할 때
		//update하는 것임
		
		return "redirect:/internationsales/import?comcode_code=" + comcode_code;
	}
	
	//수입채무
	@RequestMapping("/internationsales/importpay")
	public String importpay(Model model, String comcode_code, String word, String type) {
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		map.put("comcode_no", comcode_no);
		map.put("word", word);
		map.put("type", type);
		
		List<Map<String, Object>> list = c1.selectImportpay(map);
		
		model.addAttribute("list", list);
		
		return "";
	}
	
	//수입채무 지급여부 변경 버튼 누르면 지급여부 컬럼 바뀌도록 update
	@RequestMapping("/internationsales/importpay/update")
	public String importpayupdate(int importpay_no, Erp_Bs1VO b1vo, Erp_Bs2VO b2vo, Erp_Bs3VO b3vo, int importpay_payable) {
		Map<String, Object> map = new HashMap<>();
		map.put("importpay_no", importpay_no);
		map.put("importpay_payable", importpay_payable);
		
		c1.updateImportpay(map);
		
		int salesgoods_no = c1.selectSalesgoodsno(importpay_no);
		
		int total = c1.selectSumqty(salesgoods_no);
		
		int bs3_no = c1.selectBs3no(salesgoods_no);
		
		int bs_no = c1.selectBsno(bs3_no);
		int bs2_no = c1.selectBsno2(bs3_no);
		
		b3vo.setBs3_no(bs3_no);
		b2vo.setBs2_no(bs2_no);
		b1vo.setBs1_no(bs_no);
		
		//대변
		b3vo.setBs3_amount(-total);
		b2vo.setBs2_amount(-total);
		b1vo.setBs1_amount(-total);
		
		c1.updateBs(b1vo);
		c1.updateBs2(b2vo);
		c1.updateBs3(b3vo);
		
		bs3_no = 1;
		
		b3vo.setBs3_no(bs3_no);
		b2vo.setBs2_no(bs2_no);
		b1vo.setBs1_no(bs_no);
		
		//차변 (현금)
		b3vo.setBs3_amount(-total);
		b2vo.setBs2_amount(-total);
		b1vo.setBs1_amount(-total);
		
		c1.updateBs(b1vo);
		c1.updateBs2(b2vo);
		c1.updateBs3(b3vo);
		
		return "";
	}
	
	//수출관리
	
	@RequestMapping("/internationalsales/export")
	public String export(Model model, String comcode_code, String type, String word) {
		int comcode_no = ls.comNo(comcode_code);
		Map<String, Object> map = new HashMap<>();
		map.put("comcode_no", comcode_no);
		map.put("type", type);
		map.put("word", word);
		
		List<Map<String, Object>> list = c1.selectForsales(map);
		
		List<Erp_ClientVO> clist = c1.selectClientlist();
		
		List<Erp_GoodsVO> glist = c1.selectGoods();
		
		List<Erp_Bs1VO> dlist = c1.selectBsd3();
		
		List<Erp_Bs1VO> cclist = c1.selectBsc3();
		
		model.addAttribute("glist", glist);
		model.addAttribute("clist", clist);
		model.addAttribute("list", list);
		model.addAttribute("dlist", dlist);
		model.addAttribute("cclist", cclist);	
		
		return "/c/c1/c13/forsalesList";
	}
	
	@RequestMapping("/internationsales/export/ajax")
	@ResponseBody
	public List<Map<String, Object>> exportAjax(Model model, String comcode_code, String type, String word){
		Map<String, Object> map = new HashMap<>();
		if(type == null || word == null) {
	         type = null;
	         word = null;
	      }
	      
	      int comcode_no = ls.comNo(comcode_code);
	      
	      map.put("comcode_no", comcode_no);
	      map.put("word", word);
	      map.put("type", type);
	      
	      List<Map<String, Object>> list = c1.selectForsales(map);
	      if(list.isEmpty()) {
		         list = null;
		      }
		      System.out.println(list);
		  return list;
	}
	
	@RequestMapping("/internationalsales/export/insert")
	public String insert(Erp_ClosingVO cvo, Erp_ForsalesVO vo, Erp_Bs1VO b1vo, Erp_Bs2VO b2vo, Erp_Bs3VO b3vo, int bs3_no, int team_no, int client_no, String forsales_date, int goods_no, int incoterms_no, int settletype_no, String comcode_code, String forsales_cino, String forsales_blno, int dbs3_no) {
		
//		Random random = new Random();
//		
//		
//		for(int i = 0; i <= 1; i++) {
//			
//			if(i == 0) {
//				
//			int no = random.nextInt(9) + 1;
//			int no2 = random.nextInt(9) + 1;
//			
//			int a = (random.nextInt(26) + 65);
//			int b = (random.nextInt(26) + 65);
//			
//			char ci = (char) a;
//			char bl = (char) b;
//			String cino = "" + no + ci + no2 + bl;
//			vo.setForsales_cino(cino);
//			System.out.println(vo.getForsales_cino());
//			
//			
//			} else if(i == 1) {
//				
//				int no = random.nextInt(9) + 1;
//				int no2 = random.nextInt(9) + 1;
//				
//				int a = (random.nextInt(26) + 65);
//				int b = (random.nextInt(26) + 65);
//				
//				char ci = (char) a;
//				char bl = (char) b;
//				String blno = "" + no + ci + no2 + bl;
//				System.out.println(vo.getForsales_blno());
//				}
//			
//		}
		
		int comcode_no = ls.comNo(comcode_code);
		int total = c1.selectSumprice(goods_no);
		int price = c1.selectPrice(goods_no);
		System.out.println(price);
		System.out.println(total);
		int debtor_no = c1.selectDebtorforsales(bs3_no);
		int creditor_no = c1.selectCreditorforsales(dbs3_no);
		
		vo.setForsales_cino(forsales_cino);
		vo.setForsales_blno(forsales_blno);
		vo.setComcode_no(comcode_no);
		vo.setTeam_no(team_no);
		vo.setClient_no(client_no);
		vo.setForsales_date(forsales_date);
		vo.setGoods_no(goods_no);
		vo.setForsales_price(price);
		vo.setForsales_total(total);
		vo.setIncoterms_no(incoterms_no);
		vo.setSettletype_no(settletype_no);
		c1.insertForsales(vo);
		
		cvo.setClosing_code(forsales_blno);
		cvo.setDebtor_no(debtor_no);
		cvo.setCreditor_no(creditor_no);
		cvo.setClosing_debtor(total);
		cvo.setClosing_creditor(-total);
		cvo.setComcode_no(comcode_no);
		c1.insertClosingforsales(cvo);
		
		int bs_no = c1.selectBsno(bs3_no);
		int bs2_no = c1.selectBsno2(bs3_no);
		
		b3vo.setBs3_no(bs3_no);
		b2vo.setBs2_no(bs2_no);
		b1vo.setBs1_no(bs_no);
		
		//대변
		b3vo.setBs3_amount(total);
		b2vo.setBs2_amount(total);
		b1vo.setBs1_amount(total);
		
		c1.updateBs(b1vo);
		c1.updateBs2(b2vo);
		c1.updateBs3(b3vo);
		
		
		//차변
		bs_no = c1.selectBsno(dbs3_no);
		bs2_no = c1.selectBsno2(dbs3_no);
		
		b3vo.setBs3_no(dbs3_no);
		b2vo.setBs2_no(bs2_no);
		b1vo.setBs1_no(bs_no);
		
		b3vo.setBs3_amount(-total);
		b2vo.setBs2_amount(-total);
		b1vo.setBs1_amount(-total);
		
		c1.updateBs(b1vo);
		c1.updateBs2(b2vo);
		c1.updateBs3(b3vo);

		return "redirect:/internationalsales/export?comcode_code=" + comcode_code;
	}
	
	@RequestMapping("/internationsales/export/updateForm")
	public String exportForm(String type, String word, Model model, String comcode_code, int forsales_no) {
		int comcode_no = ls.comNo(comcode_code);
		
		String prevBlno = c1.forsalesBlno(forsales_no);
		
		System.out.println(prevBlno);
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("comcode_no", comcode_no);
		map.put("forsales_no", forsales_no);
		map.put("type", type);
		map.put("word", word);
		
		map = c1.selectForsales2(map);
		
		List<Map<String, Object>> list = c1.selectForsales(map);
		
		List<Erp_ClientVO> clist = c1.selectClientlist();
		
		List<Erp_GoodsVO> glist = c1.selectGoods();
		
		List<Erp_Bs1VO> dlist = c1.selectBsd3();
		
		List<Erp_Bs1VO> cclist = c1.selectBsc3();
		
		model.addAttribute("glist", glist);
		model.addAttribute("clist", clist);
		model.addAttribute("dlist", dlist);
		model.addAttribute("cclist", cclist);	
		model.addAttribute("list", list);
		model.addAttribute("map", map);
		model.addAttribute("prevBlno", prevBlno);
		
		return "/c/c1/c13/forsalesList";
	}
	
	@RequestMapping("/internationsales/export/update")
	public String exportUpdate(Erp_Bs1VO b1vo, Erp_Bs2VO b2vo, Erp_Bs3VO b3vo, String comcode_code, String prevBlno, int forsales_no, String forsales_cino, String forsales_blno, int team_no, int client_no, String forsales_date, int goods_no, int incoterms_no, int settletype_no, int bs3_no, int dbs3_no) {
		
		int debtor_no = c1.selectDebtorforsales(bs3_no);
		int creditor_no = c1.selectCreditorforsales(dbs3_no);
		
		int closing_debtor = c1.selectClosingdb(prevBlno);
		int closing_creditor = c1.selectClosingcr(prevBlno);
		
		int total = c1.selectSumprice(goods_no);
		int price = c1.selectPrice(goods_no);
		
		Map<String, Object> map = new HashMap<>();
		map.put("forsales_no", forsales_no);
		map.put("forsales_cino", forsales_cino);
		map.put("forsales_blno", forsales_blno);
		map.put("team_no", team_no);
		map.put("client_no", client_no);
		map.put("goods_no", goods_no);
		map.put("forsales_date", forsales_date);
		map.put("incoterms_no", incoterms_no);
		map.put("settletype_no", settletype_no);
		map.put("forsales_total", total);
		map.put("forsales_price", price);
		
		c1.updateForsales(map);
		
		Map<String, Object> map2 = new HashMap<>();
		map2.put("prevblno", prevBlno);
		map2.put("debtor_no", debtor_no);
		map2.put("creditor_no", creditor_no);
		map2.put("closing_code", forsales_blno);
		map2.put("closing_debtor", total);
		map2.put("closing_creditor", -total);
		
		c1.updateClosing(map2);
		
		int bs_no = c1.selectBsno(bs3_no);
		int bs2_no = c1.selectBsno2(bs3_no);
		
		b3vo.setBs3_no(bs3_no);
		b2vo.setBs2_no(bs2_no);
		b1vo.setBs1_no(bs_no);
		
		//대변
		b3vo.setBs3_amount(-closing_debtor);
		b2vo.setBs2_amount(-closing_debtor);
		b1vo.setBs1_amount(-closing_debtor);
		
		c1.updateBs(b1vo);
		c1.updateBs2(b2vo);
		c1.updateBs3(b3vo);
		
		b3vo.setBs3_no(bs3_no);
		b2vo.setBs2_no(bs2_no);
		b1vo.setBs1_no(bs_no);
		
		b3vo.setBs3_amount(total);
		b2vo.setBs2_amount(total);
		b1vo.setBs1_amount(total);
		
		c1.updateBs(b1vo);
		c1.updateBs2(b2vo);
		c1.updateBs3(b3vo);
		
		//차변
		bs_no = c1.selectBsno(dbs3_no);
		bs2_no = c1.selectBsno2(dbs3_no);
		
		b3vo.setBs3_no(dbs3_no);
		b2vo.setBs2_no(bs2_no);
		b1vo.setBs1_no(bs_no);
		
		b3vo.setBs3_amount(closing_creditor);
		b2vo.setBs2_amount(closing_creditor);
		b1vo.setBs1_amount(closing_creditor);
		
		c1.updateBs(b1vo);
		c1.updateBs2(b2vo);
		c1.updateBs3(b3vo);
		
		bs_no = c1.selectBsno(dbs3_no);
		bs2_no = c1.selectBsno2(dbs3_no);
		
		b3vo.setBs3_no(dbs3_no);
		b2vo.setBs2_no(bs2_no);
		b1vo.setBs1_no(bs_no);
		
		b3vo.setBs3_amount(-total);
		b2vo.setBs2_amount(-total);
		b1vo.setBs1_amount(-total);
		
		c1.updateBs(b1vo);
		c1.updateBs2(b2vo);
		c1.updateBs3(b3vo);
		
		return "redirect:/internationalsales/export?comcode_code=" + comcode_code;
	}
	
	@RequestMapping("/internationsales/export/delete")
	public String exportDelete(@RequestParam(required = false) Integer forsales_no, @RequestParam(required = false) Integer bs3_no, @RequestParam(required = false) Integer dbs3_no, @RequestParam(required = false) String comcode_code) {
		
		c1.deleteForsales(forsales_no);
		
		return "redirect:/internationalsales/export?comcode_code=" + comcode_code;
	}

	
}
