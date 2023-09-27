package com.lab.erp.controller.c;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.Principal;
import java.util.Collection;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lab.erp.common.ViewPath;
import com.lab.erp.service.c.C2Service;
import com.lab.erp.service.d.D2Service;
import com.lab.erp.service.login.LoginService;
import com.lab.erp.vo.a.a1.Erp_BusinesstypeVO;
import com.lab.erp.vo.b.b1.Erp_Bs3VO;
import com.lab.erp.vo.b.b1.Erp_ClosingVO;
import com.lab.erp.vo.b.b3.Erp_SettletypeVO;
import com.lab.erp.vo.c.Erp_BondbillsVO;
import com.lab.erp.vo.c.Erp_ClientVO;
import com.lab.erp.vo.c.Erp_ClientsortVO;
import com.lab.erp.vo.c.Erp_CountryVO;
import com.lab.erp.vo.c.Erp_GoodsconnectVO;
import com.lab.erp.vo.c.Erp_ReceivableVO;
import com.lab.erp.vo.c.Erp_SalesgoodsVO;
import com.lab.erp.vo.c.c2.Erp_LocalsalesVO;
import com.lab.erp.vo.c.c2.Erp_ReturnVO;
import com.lab.erp.vo.d.d2.Erp_OrderVO;
import com.lab.erp.vo.d.d2.Erp_OrderconnectVO;
import com.lab.erp.vo.d.d6.Erp_GoodsVO;
import com.lab.erp.vo.d.d6.Erp_GoodslotVO;

import jakarta.servlet.AsyncContext;
import jakarta.servlet.DispatcherType;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConnection;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletInputStream;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpUpgradeHandler;
import jakarta.servlet.http.Part;

@Controller
@RequestMapping("/c/c2")
public class C2Controller {
	private C2Service c2;
	private LoginService ls;
	private HttpServletRequest request;
	private D2Service d2;
	
	@Autowired
	public C2Controller(C2Service c2, LoginService ls, HttpServletRequest request, D2Service d2) {
		this.c2 = c2;
		this.ls = ls;
		this.request = request;
		this.d2 = d2;
	}
	
	
//	거래처
	@RequestMapping("/c21")
	public String clientList(Model model, String type, String word, String comcode_code) {
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
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
	@ResponseBody
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
	public String createClient(String comcode_code, Erp_ClientVO vo, Model model) {
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		vo.setComcode_no(comcode_no);
		
		c2.createClient(vo);
		
		return "redirect:/c/c2/c21?comcode_code="+comcode_code;
	}
	
	@RequestMapping("/c21/updateForm")
	public String updateForm(Model model, Erp_ClientVO vo, String type, String word, String comcode_code) {
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
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
		
		Map<String, Object> clmap = c2.selectClientb4(vo.getClient_no());
		
		model.addAttribute("list", list);
		model.addAttribute("inmap", clmap);
		
		return ViewPath.C2 + "/c21/inputClient";
	}
	
	@RequestMapping("/c21/update")
	@Transactional
	public String updateClient(Model model, Erp_ClientVO vo, String comcode_code) {
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		vo.setComcode_no(comcode_no);
		
		c2.updateClient(vo);
		
		return "redirect:/c/c2/c21/updateForm?comcode_code="+comcode_code+"&client_no="+vo.getClient_no();
	}
	
	@RequestMapping("/c21/delete")
	@Transactional
	public String deleteClient(Model model, Erp_ClientVO vo, String comcode_code) {
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		c2.deleteClient(vo.getClient_no());
		
		return "redirect:/c/c2/c21?comcode_code="+comcode_code;
	}
	
	@RequestMapping(value = "/c21/registeredno", produces = "application/text;charset=utf8")
	@ResponseBody
	public String registeredno(String client_registeredno) {
		try {
			if(client_registeredno == "") {
				return "공백은 허용되지 않습니다";
			}
			c2.getClNo(client_registeredno);
			
			return "이미 존재하는 사업자등록번호입니다.";
		}catch(NullPointerException e) {
			return "사용 가능한 사업자등록번호입니다.";
		}
	}
	
	@RequestMapping("/c21/btsubctgr")
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
		
		return ViewPath.WINDOW + "/c/c2/c21/btsubctgr";
	}
	
	@RequestMapping("/c21/btsubctgrAjax")
	@ResponseBody
	public List<Erp_BusinesstypeVO> searchbsAjax(String btype, String bword) {
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
		
		return list;
	}
	
	@RequestMapping("/c21/cslist")
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
		
		return ViewPath.WINDOW + "/c/c2/c21/cslist";
	}
	
	@RequestMapping("/c21/ctlist")
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
		
		return ViewPath.WINDOW + "/c/c2/c21/ctlist";
	}
	
	@RequestMapping("/c21/ctlistAjax")
	@ResponseBody
	public List<Erp_CountryVO> searchctAjax(String ctype, String cword) {
		if(ctype == null || cword == null) {
			ctype = null;
			cword = null;
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("ctype", ctype);
		map.put("cword", cword);
		
		List<Erp_CountryVO> list = c2.countryList(map);
		
		return list;
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
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
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
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		if(vo.getReceivable_collect() == "") {
			vo.setReceivable_collect("99990101");
		}
		
		vo.setComcode_no(comcode_no);
		double tax = vo.getReceivable_price() * 0.1;
		
		vo.setReceivable_tax((int)tax);
		
		int total = vo.getReceivable_price() + vo.getReceivable_tax();
		
		vo.setReceivable_total(total);
		
		c2.createReceivable(vo);
		
		Erp_ClosingVO cvo = new Erp_ClosingVO();
		cvo.setDebtor_no(132);
		cvo.setCreditor_no(181);
		cvo.setClosing_code(vo.getReceivable_cino());
		cvo.setClosing_debtor(vo.getReceivable_total());
		cvo.setClosing_creditor(vo.getReceivable_total());
		cvo.setComcode_no(comcode_no);
		cvo.setCtgr_no(36);
		c2.createClosing(cvo);
		
		Map<String, Object> dmap = c2.getBsNo(3);
		Map<String, Object> cmap = c2.getBsNo(6);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("bs3_amount", vo.getReceivable_total());
		map.put("bs3_no", dmap.get("bs3_no"));
		map.put("bs2_no", dmap.get("bsno2"));
		map.put("bs1_no", dmap.get("bs1_no"));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		map.put("bs3_amount", (-vo.getReceivable_total()));
		map.put("bs3_no", cmap.get("bs3_no"));
		map.put("bs2_no", cmap.get("bsno2"));
		map.put("bs1_no", cmap.get("bs1_no"));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
			
		return "redirect:/c/c2/c22?comcode_code="+comcode_code;
	}
	
	@RequestMapping("/c22/updateForm")
	public String updateFormR(String comcode_code, Model model, Erp_ReceivableVO vo, String type, String word) {
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
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
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		Map<String, Object> imap = c2.selectReceivable(vo.getReceivable_no());
		
		double tax = vo.getReceivable_price() * 0.1;
		vo.setReceivable_tax((int)tax);
		
		int total = vo.getReceivable_price() + (int)tax;
		vo.setReceivable_total(total);
		
		c2.updateReceivable(vo);
		
		int cno = c2.getClosingNo(vo.getReceivable_cino());
		
		Erp_ClosingVO cvo = new Erp_ClosingVO();
		cvo.setDebtor_no(132);
		cvo.setCreditor_no(181);
		cvo.setClosing_code(vo.getReceivable_cino());
		cvo.setClosing_debtor(vo.getReceivable_total());
		cvo.setClosing_creditor(vo.getReceivable_total());
		cvo.setClosing_no(cno);
		c2.updateClosing(cvo);
		
		Map<String, Object> map = new HashMap<>();
		
		
		Map<String, Object> dmap = c2.getBsNo(3);
		Map<String, Object> cmap = c2.getBsNo(6);
		
		map.put("bs3_amount", (-(int)imap.get("receivable_total")));
		map.put("bs3_no", dmap.get("bs3_no"));
		map.put("bs2_no", dmap.get("bsno2"));
		map.put("bs1_no", dmap.get("bs1_no"));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		map.put("bs3_amount", (int)imap.get("receivable_total"));
		map.put("bs3_no", cmap.get("bs3_no"));
		map.put("bs2_no", cmap.get("bsno2"));
		map.put("bs1_no", cmap.get("bs1_no"));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		map.put("bs3_amount", vo.getReceivable_total());
		map.put("bs3_no", dmap.get("bs3_no"));
		map.put("bs2_no", dmap.get("bsno2"));
		map.put("bs1_no", dmap.get("bs1_no"));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		map.put("bs3_amount", (-vo.getReceivable_total()));
		map.put("bs3_no", cmap.get("bs3_no"));
		map.put("bs2_no", cmap.get("bsno2"));
		map.put("bs1_no", cmap.get("bs1_no"));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		return "redirect:/c/c2/c22/updateForm?comcode_code="+comcode_code+"&receivable_no="+vo.getReceivable_no();
	}
	
	@RequestMapping("/c22/delete")
	public String deleteReceivable(String comcode_code, Model model, Erp_ReceivableVO vo) {
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		Erp_BondbillsVO bvo = c2.getBillsTotal(vo.getReceivable_no());
		
		int total = vo.getReceivable_total() - bvo.getBondbills_total();
		
		c2.deleteBills(vo.getReceivable_no());
		
		int cno = c2.getClosingNo(vo.getReceivable_cino());
		
		c2.deleteClosing(cno);
		
		c2.deleteReceive(vo.getReceivable_no());
		
		Map<String, Object> map = new HashMap<>();
		
		Map<String, Object> dmap = c2.getBsNo(3);
		Map<String, Object> cmap = c2.getBsNo(6);
		
		map.put("bs3_amount", (-total));
		map.put("bs3_no", dmap.get("bs3_no"));
		map.put("bs2_no", dmap.get("bsno2"));
		map.put("bs1_no", dmap.get("bs1_no"));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		map.put("bs3_amount", total);
		map.put("bs3_no", cmap.get("bs3_no"));
		map.put("bs2_no", cmap.get("bsno2"));
		map.put("bs1_no", cmap.get("bs1_no"));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		return "redirect:/c/c2/c22?comcode_code="+comcode_code;
	}
	
	
//	수금
	@RequestMapping("/c22/inputBondbills")
	public String inputBondbills(String comcode_code, Model model, Erp_BondbillsVO vo, String type, String word) {
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
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
		Map<String, Object> rmap = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		if(vo.getReceivable_no() == 0) {
			list = c2.bondbillsList(map);
		}else {
			map.put("receivable_no", vo.getReceivable_no());
			rmap = c2.selectReceivable(vo.getReceivable_no());
			list = c2.receiveBondbills(map);
		}
		
		model.addAttribute("rmap", rmap);
		model.addAttribute("list", list);
		model.addAttribute("dlist", dlist);
		model.addAttribute("clist", clist);
		
		return ViewPath.C2 + "/c22/inputBondbills";
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
	@RequestMapping("/c22/billsAjax2")
	@ResponseBody
	public List<Map<String, Object>> billsAjax2(String comcode_code, String type, String word){
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
		
		list = c2.bondbillsList(map);
		
		return list;
	}
	
	@RequestMapping("/c22/createBondbills")
	@Transactional
	public String createBondbills(String comcode_code, String bs3_no1, String bs3_no2, Model model, 
			Erp_BondbillsVO vo, String receivable_cino, String debtor_no, String creditor_no) {
		
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
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
		
		Map<String, Object> inmap = c2.selectReceivable(vo.getReceivable_no());
		Erp_BondbillsVO bills = c2.getBillsTotal(vo.getReceivable_no());
		
		if(bills.getBondbills_total() == (int)inmap.get("receivable_total")) {
			Erp_ReceivableVO rvo = new Erp_ReceivableVO();
			rvo.setReceivable_no(vo.getReceivable_no());
			rvo.setReceivable_collected(1);
			c2.finishCollect(rvo);
		}
		
		Erp_ClosingVO cvo = new Erp_ClosingVO();
		cvo.setClosing_code(vo.getBondbills_code());
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
		
		return "redirect:/c/c2/c22/inputBondbills?comcode_code="+comcode_code+"&receivable_no="+vo.getReceivable_no();
	}
	
	@RequestMapping(value="/c22/billsTotalCheck",produces = "application/text;charset=utf8")
	@ResponseBody
	public String billsTotalCheck(Erp_ReceivableVO vo, String total) {
		Map<String, Object> inmap = c2.selectReceivable(vo.getReceivable_no());
		Erp_BondbillsVO bills = c2.getBillsTotal(vo.getReceivable_no());
		if(bills.getBondbills_total() + Integer.parseInt(total) > (int)inmap.get("receivable_total")) {
			
			return "총 채권 금액을 초과합니다. 다시 입력해주세요.";
		}else {
			
			return "";
		}
	}
	
	@RequestMapping("/c22/updateFormB")
	public String updateFormB(String comcode_code, Model model, Erp_BondbillsVO vo, String type, String word, 
			String bs3_no1, String bs3_no2) {
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
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
		
		Map<String, Object> rmap = new HashMap<>();
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		if(vo.getReceivable_no() == 0) {
			list = c2.bondbillsList(map);
		}else {
			map.put("receivable_no", vo.getReceivable_no());
			rmap = c2.selectReceivable(vo.getReceivable_no());
			list = c2.receiveBondbills(map);
		}
		
		Map<String, Object> inmap = c2.selectBondbills(vo.getBondbills_no()); 
		
		model.addAttribute("rmap", rmap);
		model.addAttribute("bs3_no1", bs3_no1);
		model.addAttribute("bs3_no2", bs3_no2);
		model.addAttribute("inmap", inmap);
		model.addAttribute("list", list);
		model.addAttribute("dlist", dlist);
		model.addAttribute("clist", clist);
		
		return ViewPath.C2 + "/c22/inputBondbills";
	}
	
	@RequestMapping("/c22/updateBondbills")
	@Transactional
	public String updateBonbills(String comcode_code, Model model, Erp_BondbillsVO vo, 
			String bs3_no11, String bs3_no21, String bs3_no12, String bs3_no22,
			String receivable_cino, String debtor_no, String creditor_no) {
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
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
		
		Map<String, Object> inmap = c2.selectReceivable(vo.getReceivable_no());
		Erp_BondbillsVO bills = c2.getBillsTotal(vo.getReceivable_no());
		
		if(bills.getBondbills_total() == (int)inmap.get("receivable_total")) {
			Erp_ReceivableVO rvo = new Erp_ReceivableVO();
			rvo.setReceivable_no(vo.getReceivable_no());
			rvo.setReceivable_collected(1);
			c2.finishCollect(rvo);
		}
		
		Erp_ClosingVO cvo = new Erp_ClosingVO();
		cvo.setClosing_code(vo.getBondbills_code());
		cvo.setDebtor_no(deptno);
		cvo.setCreditor_no(creditno);
		cvo.setClosing_debtor(vo.getBondbills_total());
		cvo.setClosing_creditor(vo.getBondbills_total());
		cvo.setClosing_no(c2.getClosingNo(vo.getBondbills_code()));
		
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
		
		return "redirect:/c/c2/c22/updateFormB?bs3_no1="+bs3_no12+"&bs3_no2="+bs3_no22+"&receivable_no="+vo.getReceivable_no()+"&comcode_code="+comcode_code+"&bondbills_no="+vo.getBondbills_no();
	}
	
	@RequestMapping("/c22/deleteBondbills")
	@Transactional
	public String deleteBondbills(String comcode_code, Model model, Erp_BondbillsVO vo, 
			String bs3_no1, String bs3_no2) {
		int b1 = 0;
		int b2 = 0;
		
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
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
		
		int cno = c2.getClosingNo(vo.getBondbills_code());
		
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
		
		return "redirect:/c/c2/c22/inputBondbills?comcode_code="+comcode_code+"&receivable_no="+vo.getReceivable_no();
	}
	
	@RequestMapping(value="/c22/getUniqueCIno", produces = "application/text;charset=utf8")
	@ResponseBody
	public String getUniqueCIno(String receivable_cino) {
		try {
			if(receivable_cino == "") {
				return "공백은 허용되지 않습니다";
			}
			c2.getUniqueCIno(receivable_cino);
			
			return "이미 존재하는 코드입니다.";
		}catch(NullPointerException e) {
			return "사용 가능한 코드입니다.";
		}
	}
	@RequestMapping(value="/c22/getUniqueCode", produces = "application/text;charset=utf8")
	@ResponseBody
	public String getUniqueCode(String receivable_code) {
		try {
			if(receivable_code == "") {
				return "공백은 허용되지 않습니다";
			}
			c2.getUniqueCode(receivable_code);
			
			return "이미 존재하는 코드입니다.";
		}catch(NullPointerException e) {
			return "사용 가능한 코드입니다.";
		}
	}
	
	@RequestMapping(value="/c22/getBondbillsCode", produces = "application/text;charset=utf8")
	@ResponseBody
	public String getBondbillsCode(String bondbills_code) {
		try {
			if(bondbills_code == "") {
				return "공백은 허용되지 않습니다";
			}
			c2.getBondbillsCode(bondbills_code);
			
			return "이미 존재하는 코드입니다.";
		}catch(NullPointerException e) {
			return "사용 가능한 코드입니다.";
		}
	}
	
	@RequestMapping("/c22/receivableList")
	public String receivableList(String comcode_code, Model model, String type, String word) {
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
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
		
		model.addAttribute("list", rlist);
		
		return ViewPath.WINDOW + "c/c2/c22/receivableList";
	}
	
	
//	반품
	@RequestMapping("/c23/inputReturn")
	public String inputReturn(String comcode_code, Model model, String type, String word) {
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
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
	public String createReturn(Erp_ReturnVO vo, String comcode_code, Model model) {
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
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
		cvo.setClosing_debtor(vo.getReturn_total()*vo.getReturn_qty());
		cvo.setClosing_creditor(vo.getReturn_total()*vo.getReturn_qty());
		cvo.setComcode_no(comcode_no);
		cvo.setCtgr_no(37);
		cvo.setDebtor_no(134);
		cvo.setCreditor_no(133);
		
		c2.createClosing(cvo);
		
		Map<String, Object> dmap = c2.getBsNo(6);
		Map<String, Object> cmap = c2.getBsNo(1);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("bs3_amount", vo.getReturn_total()*vo.getReturn_qty());
		map.put("bs3_no", dmap.get("bs3_no"));
		map.put("bs2_no", dmap.get("bsno2"));
		map.put("bs1_no", dmap.get("bs1_no"));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		map.put("bs3_amount", (-vo.getReturn_total()*vo.getReturn_qty()));
		map.put("bs3_no", cmap.get("bs3_no"));
		map.put("bs2_no", cmap.get("bsno2"));
		map.put("bs1_no", cmap.get("bs1_no"));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		return "redirect:/c/c2/c23/inputReturn?comcode_code="+comcode_code;
	}
	
	@RequestMapping("/c23/updateForm")
	public String updateFormRt(String comcode_code, Model model, Erp_ReturnVO vo, String type, String word) {
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
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
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
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
		cvo.setClosing_debtor(vo.getReturn_total()*vo.getReturn_qty());
		cvo.setClosing_creditor(vo.getReturn_total()*vo.getReturn_qty());
		cvo.setDebtor_no(134);
		cvo.setCreditor_no(133);
		cvo.setClosing_no(cno);
		c2.updateClosing(cvo);
		
		Map<String, Object> map = new HashMap<>();
		
		Map<String, Object> dmap = c2.getBsNo(6);
		Map<String, Object> cmap = c2.getBsNo(1);
		
		map.put("bs3_amount", (-(int)inmap.get("return_total")*(int)inmap.get("return_qty")));
		map.put("bs3_no", dmap.get("bs3_no"));
		map.put("bs2_no", dmap.get("bsno2"));
		map.put("bs1_no", dmap.get("bs1_no"));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		map.put("bs3_amount", (int)inmap.get("return_total")*(int)inmap.get("return_qty"));
		map.put("bs3_no", cmap.get("bs3_no"));
		map.put("bs2_no", cmap.get("bsno2"));
		map.put("bs1_no", cmap.get("bs1_no"));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		map.put("bs3_amount", vo.getReturn_total()*vo.getReturn_qty());
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		map.put("bs3_amount", (-vo.getReturn_total()*vo.getReturn_qty()));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		return "redirect:/c/c2/c23/inputReturn?comcode_code="+comcode_code;
	}
	
	@RequestMapping("/c23/delete")
	@Transactional
	public String deleteReturn(Erp_ReturnVO vo, Model model, String comcode_code) {
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		int cno = c2.getClosingNo(vo.getReturn_code());
		
		c2.deleteClosing(cno);
		
		c2.deleteReturn(vo.getReturn_no());
		
		Map<String, Object> map = new HashMap<>();
		
		Map<String, Object> dmap = c2.getBsNo(6);
		Map<String, Object> cmap = c2.getBsNo(1);
		
		map.put("bs3_amount", (-vo.getReturn_total()*vo.getReturn_qty()));
		map.put("bs3_no", dmap.get("bs3_no"));
		map.put("bs2_no", dmap.get("bsno2"));
		map.put("bs1_no", dmap.get("bs1_no"));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		map.put("bs3_amount", vo.getReturn_total()*vo.getReturn_qty());
		map.put("bs3_no", cmap.get("bs3_no"));
		map.put("bs2_no", cmap.get("bsno2"));
		map.put("bs1_no", cmap.get("bs1_no"));
		
		c2.updateBs3Amount(map);
		c2.updateBs2Amount(map);
		c2.updateBs1Amount(map);
		
		return "redirect:/c/c2/c23/inputReturn?comcode_code="+comcode_code;
	}
	
	@RequestMapping("/c23/goodsreturn")
	public String goodsreturn(String comcode_code, String btype, String bnword, Model model){
		Map<String, Object> map = new HashMap<>();
		
		if(btype == null || bnword == null) {
			btype = null;
			bnword = null;
		}
		
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		map.put("btype", btype);
		map.put("bnword", bnword);
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> list = c2.goodsReturn(map);
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "/c/c2/c23/goodsList";
	}
	@RequestMapping("/c23/goodsreturnajax")
	@ResponseBody
	public List<Map<String, Object>> goodsreturnajax(String comcode_code, String btype, String bnword){
		Map<String, Object> map = new HashMap<>();
		
		if(btype == null || bnword == null) {
			btype = null;
			bnword = null;
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		map.put("btype", btype);
		map.put("bnword", bnword);
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> list = c2.goodsReturn(map);
		
		return list;
	}
	
	@RequestMapping(value="/c23/returncode", produces = "application/text;charset=utf8")
	@ResponseBody
	public String returncode(String return_code) {
		try {
			if(return_code == "") {
				return "공백은 허용되지 않습니다";
			}
			c2.getReturnCode(return_code);
			
			return "이미 존재하는 코드입니다.";
		}catch(NullPointerException e) {
			return "사용 가능한 코드입니다.";
		}
	}
	
	
//	국내영업매출
	@RequestMapping("/c25/inputLocalSales")
	public String inputLocalSales(Model model, String comcode_code, String type, String word) {
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
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
	
	@RequestMapping("/c25/addForm")
	public String addLocalSales(Model model, String comcode_code) {
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		List<Erp_Bs3VO> dlist = c2.ctgrDebtor(39);
		List<Erp_Bs3VO> clist = c2.ctgrCreditor(39);
		List<Erp_SettletypeVO> settleList = c2.getSettleList();
		
		model.addAttribute("settleList", settleList);
		model.addAttribute("dlist", dlist);
		model.addAttribute("clist", clist);
		
		return ViewPath.C2 + "/c25/selectForm";
	}
	
	@RequestMapping("/c25/createLocalSales")
	@Transactional
	public String createLocalSales(Erp_LocalsalesVO vo, String comcode_code, Model model, 
			String bs3_no1, String bs3_no2, String debtor_no, String creditor_no, 
			Erp_SalesgoodsVO svo) {
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
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
		
		int sum = 0;
		int qty = 0;
		
		List<Erp_SalesgoodsVO> sglist = svo.getSglist();
		for(Erp_SalesgoodsVO sgvo : sglist) {
			sgvo.setSalesgoods_code(vo.getLocalsales_cino());
			sum += sgvo.getSalesgoods_price() * sgvo.getSalesgoods_qty();
			c2.inputSalesGoods(sgvo);
			
			Erp_GoodslotVO glvo = new Erp_GoodslotVO();
			glvo.setGoodslot_no(sgvo.getGoodslot_no());
			glvo.setGoodslot_qty(sgvo.getSalesgoods_qty());
			c2.updateLotQtySub(glvo);
			
			Erp_GoodsVO gvo = new Erp_GoodsVO();
			gvo.setGoods_no(sgvo.getGoods_no());
			gvo.setGoods_stockqty(sgvo.getSalesgoods_qty());
			int gs = c2.updateGoodsSub(gvo);
			
			qty += sgvo.getSalesgoods_qty();
			
		}
		
		double tax = sum * 0.1;
		int total = (int)tax + sum;
		
		vo.setLocalsales_qty(qty);
		vo.setComcode_no(comcode_no);
		vo.setLocalsales_price(sum);
		vo.setLocalsales_tax((int)tax);
		vo.setLocalsales_total(total);
		
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
		
		return "redirect:/c/c2/c25/inputLocalSales?comcode_code="+comcode_code;
	}
	
	@RequestMapping("/c25/updateForm")
	public String updateFormL(Model model, String comcode_code, Erp_LocalsalesVO vo, String type, String word) {
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
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
		
		List<Map<String, Object>> slist = c2.getSalesGoods(vo.getLocalsales_cino());
		
		List<Erp_Bs3VO> dlist = c2.ctgrDebtor(39);
		List<Erp_Bs3VO> clist = c2.ctgrCreditor(39);
		List<Erp_SettletypeVO> settleList = c2.getSettleList();
		
		Map<String, Object> inmap = c2.selectLocalSales(vo.getLocalsales_no());
		
		model.addAttribute("settleList", settleList);
		model.addAttribute("dlist", dlist);
		model.addAttribute("clist", clist);
		model.addAttribute("slist", slist);
		model.addAttribute("inmap", inmap);
		
		return ViewPath.C2 + "/c25/selectForm";
	}
	
	@RequestMapping("/c25/update")
	@Transactional
	public String updateLocalSales(Model model, String comcode_code, Erp_LocalsalesVO vo, 
			String bs3_no11, String bs3_no21, String bs3_no12, String bs3_no22, 
			String debtor_no, String creditor_no, 
			Erp_SalesgoodsVO svo) {
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
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
		
		List<Erp_SalesgoodsVO> sglist = svo.getSglist();
		List<Erp_SalesgoodsVO> sglist1 = svo.getSglist1();
		List<Map<String, Object>> sgmap = c2.getSalesGoods(vo.getLocalsales_cino());
		
		int qty = 0;
		int sum = 0;
		int i = 0;
		
		if(sglist1 != null) {
			for(Erp_SalesgoodsVO sgvo : sglist1) {
				Erp_GoodsVO gvo = new Erp_GoodsVO();
				Erp_GoodslotVO glvo = new Erp_GoodslotVO();
				
				gvo.setGoods_no((int)sgmap.get(i).get("goods_no"));
				gvo.setGoods_stockqty((int)sgmap.get(i).get("salesgoods_qty"));
				c2.updateGoodsOne(gvo);
				gvo.setGoods_no((int)sgmap.get(i).get("goods_no"));
				gvo.setGoods_stockqty(sgvo.getSalesgoods_qty());
				c2.updateGoodsSub(gvo);
				
				glvo.setGoodslot_qty((int)sgmap.get(i).get("salesgoods_qty"));
				glvo.setGoodslot_no(sgvo.getGoodslot_no());
				c2.updateLotQtyOne(glvo);
				glvo.setGoodslot_qty(sgvo.getSalesgoods_qty());
				glvo.setGoodslot_no(sgvo.getGoodslot_no());
				c2.updateLotQtySub(glvo);
				
				sum += sgvo.getSalesgoods_price() * sgvo.getSalesgoods_qty();
				qty += sgvo.getSalesgoods_qty();
				
				sgvo.setSalesgoods_code(vo.getLocalsales_cino());
				c2.updateSGNo(sgvo);
				
				i += 1;
			}
		}
		
		if(sglist != null) {
			for(Erp_SalesgoodsVO sgvo : sglist) {
				Erp_GoodsVO gvo = new Erp_GoodsVO();
				Erp_GoodslotVO glvo = new Erp_GoodslotVO();
				
				sgvo.setSalesgoods_code(vo.getLocalsales_cino());
				sum += sgvo.getSalesgoods_price() * sgvo.getSalesgoods_qty();
				c2.inputSalesGoods(sgvo);
				
				glvo.setGoodslot_no(sgvo.getGoodslot_no());
				glvo.setGoodslot_qty(sgvo.getSalesgoods_qty());
				c2.updateLotQtySub(glvo);
				
				gvo.setGoods_no(sgvo.getGoods_no());
				gvo.setGoods_stockqty(sgvo.getSalesgoods_qty());
				c2.updateGoodsSub(gvo);
				
				qty += sgvo.getSalesgoods_qty();
				
				i += 1;
			}
		}
		
		double tax = sum * 0.1;
		int total = (int)tax + sum;
		
		vo.setLocalsales_tax((int)tax);
		vo.setLocalsales_total(total);
		vo.setLocalsales_price(sum);
		vo.setLocalsales_qty(qty);
		
		c2.updateLocalSales(vo);
		
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
		
		String code = URLEncoder.encode(vo.getLocalsales_cino());
		
		return "redirect:/c/c2/c25/updateForm?comcode_code="+comcode_code+"&localsales_no="+vo.getLocalsales_no()+"&localsales_cino="+code;
	}
	
	@RequestMapping("/c25/delete")
	@Transactional
	public String deleteLocalSales(Model model, String comcode_code, Erp_LocalsalesVO vo, 
			String bs3_no1, String bs3_no2) {
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
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
		
		int cno = c2.getClosingNo(vo.getLocalsales_cino());
		
		c2.deleteClosing(cno);
		
		c2.deleteSGCode(vo.getLocalsales_cino());
		
		c2.deleteLocalSales(vo.getLocalsales_no());
		
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
		
		return "redirect:/c/c2/c25/inputLocalSales?comcode_code="+comcode_code;
	}
	
	@RequestMapping(value="/c25/localcino", produces = "application/text;charset=utf8")
	@ResponseBody
	public String localcino(String localsales_code) {
		try {
			if(localsales_code == "") {
				return "공백은 허용되지 않습니다";
			}
			c2.getLocasCino(localsales_code);
			
			return "이미 존재하는 번호입니다.";
		}catch(NullPointerException e) {
			return "사용 가능한 번호입니다.";
		}
	}
	
	@RequestMapping("/c25/deleteGoods")
	@Transactional
	@ResponseBody
	public List<Map<String, Object>> deleteLocalGoods(Erp_SalesgoodsVO vo, String localsales_cino){
		String closing_code = localsales_cino;
		
		Erp_GoodslotVO glvo = new Erp_GoodslotVO();
		Erp_GoodsVO gvo = new Erp_GoodsVO();
		
		glvo.setGoodslot_qty(vo.getSalesgoods_qty());
		glvo.setGoodslot_no(vo.getGoodslot_no());
		c2.updateLotQtyOne(glvo);
		
		gvo.setGoods_stockqty(vo.getSalesgoods_qty());
		gvo.setGoods_no(vo.getGoods_no());
		c2.updateGoodsOne(gvo);
		
		Erp_LocalsalesVO lvo = new Erp_LocalsalesVO();
		
		int sum = vo.getSalesgoods_qty() * vo.getSalesgoods_price();
		
		double tax = sum * 0.1;
		
		int total = sum + (int)tax;
		
		lvo.setLocalsales_price(sum);
		lvo.setLocalsales_tax((int)tax);
		lvo.setLocalsales_total(total);
		lvo.setLocalsales_cino(localsales_cino);
		
		c2.updateLocalPrice(lvo);
		
		Map<String, Object> closing = d2.getClosingCode(closing_code);
		
		Map<String, Object> dmap = d2.getBsNo((int)closing.get("bs3_no1"));
		Map<String, Object> cmap = d2.getBsNo((int)closing.get("bs3_no2"));
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("bs3_amount", (-total));
		map.put("bs1_no", dmap.get("bs1_no"));
		map.put("bs2_no", dmap.get("bsno2"));
		map.put("bs3_no", dmap.get("bs3_no"));
		
		d2.updateBs1Amount(map);
		d2.updateBs2Amount(map);
		d2.updateBs3Amount(map);
		
		map.put("bs3_amount", total);
		map.put("bs1_no", cmap.get("bs1_no"));
		map.put("bs2_no", cmap.get("bsno2"));
		map.put("bs3_no", cmap.get("bs3_no"));
		
		d2.updateBs1Amount(map);
		d2.updateBs2Amount(map);
		d2.updateBs3Amount(map);
		
		Erp_ClosingVO cvo = new Erp_ClosingVO();
		cvo.setClosing_creditor(total);
		cvo.setClosing_debtor(total);
		cvo.setClosing_no(d2.getClosingNo(closing_code));
		d2.updateClosingPrice(cvo);
		
		c2.deleteSGNo(vo.getSalesgoods_no());
		
		List<Map<String, Object>> list = c2.getSalesGoods(closing_code);
		
		if(list.isEmpty()) {
			list = null;
		}
		
		return list;
	}
	
	@RequestMapping("/c25/goodsList")
	public String goodsList(String btype, String bnword, String comcode_code, Model model, String i) {
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		if(btype == null || bnword == null) {
			btype = null;
			bnword = null;
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("comcode_no", comcode_no);
		map.put("btype", btype);
		map.put("bnword", bnword);
		
		List<Map<String, Object>> list = c2.goodsLotList(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		model.addAttribute("list", list);
		model.addAttribute("i", i);
		
		return ViewPath.WINDOW + "c/c2/c25/goodsList";
	}
	@RequestMapping("/c25/goodsList1")
	public String goodsList1(String btype, String bnword, String comcode_code, Model model, String i) {
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		if(btype == null || bnword == null) {
			btype = null;
			bnword = null;
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("comcode_no", comcode_no);
		map.put("btype", btype);
		map.put("bnword", bnword);
		
		List<Map<String, Object>> list = c2.goodsLotList(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		model.addAttribute("list", list);
		model.addAttribute("i", i);
		
		return ViewPath.WINDOW + "c/c2/c25/goodsList1";
	}
	
	@RequestMapping("/c25/goodsListAjax")
	@ResponseBody
	public List<Map<String, Object>> goodsListAjax(String btype, String bnword, String comcode_code) {
		
		int comcode_no = ls.comNo(comcode_code);
		
		if(btype == null || bnword == null) {
			btype = null;
			bnword = null;
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("comcode_no", comcode_no);
		map.put("btype", btype);
		map.put("bnword", bnword);
		
		List<Map<String, Object>> list = c2.goodsLotList(map);
		
		return list;
	}
	
	@RequestMapping("/c25/clList")
	public String clList(String comcode_code, Model model, String type, String word) {
		Map<String, Object> map = new HashMap<>();
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		int comcode_no = ls.comNo(comcode_code);
		
		map.put("comcode_no", comcode_no);
		map.put("type", type);
		map.put("word", word);
		
		List<Map<String, Object>> list = d2.clientList(map);
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "c/c2/c25/clList";
	}
	
	@RequestMapping("/c25/clListAjax")
	@ResponseBody
	public List<Map<String, Object>> clListAjax(String comcode_code, String type, String word) {
		Map<String, Object> map = new HashMap<>();
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		int comcode_no = ls.comNo(comcode_code);
		
		map.put("comcode_no", comcode_no);
		map.put("type", type);
		map.put("word", word);
		
		List<Map<String, Object>> list = d2.clientList(map);
		
		return list;
	}
	
}
