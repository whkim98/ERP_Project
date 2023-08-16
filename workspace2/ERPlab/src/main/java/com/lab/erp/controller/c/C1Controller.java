package com.lab.erp.controller.c;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lab.erp.service.c.C1Service;
import com.lab.erp.vo.a.a1.Erp_BusinesstypeVO;
import com.lab.erp.vo.c.Erp_ClientVO;
import com.lab.erp.vo.c.Erp_ReceivableVO;
import com.lab.erp.vo.c.c1.Erp_ForsalesVO;
import com.lab.erp.vo.c.c1.Erp_ImportpayVO;
import com.lab.erp.vo.d.d6.Erp_GoodsVO;

@Controller
public class C1Controller {

	private C1Service c1;
	
	@Autowired
	public C1Controller(C1Service c1) {
		this.c1 = c1;
	}
	
	@RequestMapping("/internationalsales/list")
	public String list(Model model) {
		List<Erp_ClientVO> list = c1.internationList();
		model.addAttribute("list", list);
		return "/c/c1/c11/internationList";
	}
	
	@RequestMapping("/internationalsales/bond/addForm")
	public String bondAdd() {
		return "/c/c1/c11/addForm";
	}
	
	@RequestMapping("/internationalsales/bond/insert")
	public String insert(Erp_ClientVO vo, int country_no, String client_name, int clientsort_no, String client_registeredno, String client_corporatedno, String client_representative, String client_businesstype, String client_addr1, String client_addr2, String client_postal, String client_directno, String client_fax, String client_email, String client_manager, String client_contact) {
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
		
//		int su = c1.insertClient(vo);
		
		return "redirect:/internationalsales/list";
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
	
	@RequestMapping("/internationalsales/bond")
	public String bond(Model model) {
//		List<Erp_ReceivableVO> list = c1.selectReceivable();
//		model.addAttribute("list", list);
		return "/c/c1/c11/bondlist";
	}
	
	@RequestMapping("/internationalsales/export")
	public String export(Model model) {
		List<Erp_ForsalesVO> list = c1.selectForsales();
		model.addAttribute("list", list);
		return "/c/c1/c13/forsalesList";
	}
	
	@RequestMapping("/internationalsales/export/insertForm")
	public String insertForm(Model model) {
		List<Erp_ClientVO> list = c1.internationList();
		List<Erp_GoodsVO> glist = c1.selectGoods();
		model.addAttribute("list", list);
		model.addAttribute("glist", glist);
		return "/c/c1/c13/insertForm";
	}
	
	@RequestMapping("/internationalsales/export/insert")
	public String insert(Erp_ForsalesVO vo, int team_no, int client_no, String forsales_date, int goods_no, int forsales_qty, int forsales_price, int forsales_tax, int forsales_total, int incoterms_no, int settletype_no) {
		
		Random random = new Random();
		
		
		for(int i = 0; i <= 1; i++) {
			
			if(i == 0) {
				
			int no = random.nextInt(9) + 1;
			int no2 = random.nextInt(9) + 1;
			
			int a = (random.nextInt(26) + 65);
			int b = (random.nextInt(26) + 65);
			
			char ci = (char) a;
			char bl = (char) b;
			String cino = "" + no + ci + no2 + bl;
			vo.setForsales_cino(cino);
			System.out.println(vo.getForsales_cino());
			
			
			} else if(i == 1) {
				
				int no = random.nextInt(9) + 1;
				int no2 = random.nextInt(9) + 1;
				
				int a = (random.nextInt(26) + 65);
				int b = (random.nextInt(26) + 65);
				
				char ci = (char) a;
				char bl = (char) b;
				String blno = "" + no + ci + no2 + bl;
				System.out.println(vo.getForsales_blno());
				}
			
		}
		
		
		vo.setTeam_no(team_no);
		vo.setClient_no(client_no);
		vo.setForsales_date(forsales_date);
		vo.setGoods_no(goods_no);
		vo.setForsales_qty(forsales_qty);
		vo.setForsales_price(forsales_price);
		vo.setForsales_tax(forsales_tax);
		vo.setForsales_total(forsales_total);
		vo.setIncoterms_no(incoterms_no);
		vo.setSettletype_no(settletype_no);
		c1.insertForsales(vo);
		return "redirect:/internationalsales/export";
	}
	
	@RequestMapping("/internationalsales/importpay")
	public String importpay(Model model, Erp_ImportpayVO vo) {
		List<Erp_ImportpayVO> list = c1.selectImportpay();
		model.addAttribute("list", list);
		return "/c/c1/c14/importpayList";
	}
	
}
