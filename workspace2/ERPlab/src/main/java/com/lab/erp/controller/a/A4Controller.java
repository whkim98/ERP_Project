package com.lab.erp.controller.a;

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
import com.lab.erp.service.a.A3Service;
import com.lab.erp.service.a.A4Service;
import com.lab.erp.service.login.LoginService;
import com.lab.erp.vo.a.a4.Erp_ImkindVO;
import com.lab.erp.vo.a.a4.Erp_InvestmentVO;
import com.lab.erp.vo.a.a4.Erp_LoanVO;
import com.lab.erp.vo.b.b1.Erp_Bs3VO;
import com.lab.erp.vo.b.b1.Erp_ClosingVO;
import com.lab.erp.vo.b.b2.Erp_AccountVO;
import com.lab.erp.vo.c.Erp_ClientVO;
import com.lab.erp.vo.login.Erp_TeamVO;

@Controller
@RequestMapping("/a/a4")
public class A4Controller {
	private A4Service a4;
	private A3Service a3;
	private LoginService ls;
	
	@Autowired
	public A4Controller(A4Service a4, A3Service a3, LoginService ls) {
		this.a4 = a4;
		this.a3 = a3;
		this.ls = ls;
	}
	
//	a41
	@RequestMapping("/a41")
	public String inputLoan(String type, String word, Model model, String comcode_code) {
		Map<String, Object> map = new HashMap<>();
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		int ctgr = 8;
		int comcode_no = ls.comNo(comcode_code);
		
		map.put("comcode_no", comcode_no);
		map.put("ctgr_no", ctgr);
		map.put("word", word);
		map.put("type", type);
		
		List<Map<String, Object>> list = a4.investmentList(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		List<Erp_Bs3VO> dlist = a4.ctgrDebtor(ctgr);
		List<Erp_Bs3VO> clist = a4.ctgrCreditor(ctgr);
		List<Erp_Bs3VO> blist = a4.bs3List();
		
		model.addAttribute("dlist", dlist);
		model.addAttribute("clist", clist);
		model.addAttribute("blist", blist);
		model.addAttribute("list", list);
		
		return ViewPath.A4 + "/a41/inputLoan";
	}
	
	@RequestMapping("/a41/content")
	public String contentI(Erp_InvestmentVO vo, String bs3_no1, String bs3_no2, Model model, String type, String word, String comcode_code) {
		Map<String, Object> map = new HashMap<>();
		int b1 = 0;
		int b2 = 0;
		
		if(bs3_no1 != null) {
			b1 = Integer.parseInt(bs3_no1);
		}
		if(bs3_no2 != null) {
			b2 = Integer.parseInt(bs3_no2);
		}
		
		map.put("investment_no", vo.getInvestment_no());
		map.put("bs3_no1", b1);
		map.put("bs3_no2", b2);
		
		Map<String, Object> inmap = a4.selectInvestment(map);
		
		Map<String, Object> map1 = new HashMap<>();
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		int comcode_no = ls.comNo(comcode_code);
		int ctgr = 8;
		
		map1.put("comcode_no", comcode_no);
		map1.put("ctgr_no", ctgr);
		map1.put("word", word);
		map1.put("type", type);
		
		List<Map<String, Object>> list = a4.investmentList(map1);
		if(list.isEmpty()) {
			list = null;
		}
		
		Erp_ClientVO cvo = a4.selectClient((int)inmap.get("client_no"));
		Erp_AccountVO avo = a4.selectAccount((int)inmap.get("account_no"));
		
		model.addAttribute("cvo", cvo);
		model.addAttribute("avo", avo);
		model.addAttribute("list", list);
		
		model.addAttribute("inmap", inmap);
		
		return ViewPath.A4 + "/a41/content";
	}
	
	@RequestMapping("/a41/createLoan")
	@Transactional
	public String createLoan(Erp_InvestmentVO vo, Model model, String bs3_no1, String bs3_no2, String comcode_code) {
		int b1 = 0;
		int b2 = 0;
		
		if(vo.getInvestment_start().equals("")) {
			vo.setInvestment_start(null);
		}
		if(vo.getInvestment_end().equals("")) {
			vo.setInvestment_end(null);
		}
		
		if(bs3_no1 != null) {
			b1 = Integer.parseInt(bs3_no1);
		}
		if(bs3_no2 != null) {
			b2 = Integer.parseInt(bs3_no2);
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		vo.setComcode_no(comcode_no);
		
		int insert = a4.createInvestment(vo);
		
		if(insert == 0) {
			String msg = "등록 실패";
			String url = "/a/a4/a41?comcode_code="+comcode_code;
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}else {
			int ctgr = 8;
			
			Erp_ClosingVO cvo = new Erp_ClosingVO();
			cvo.setClosing_code(vo.getInvestment_code());
			cvo.setClosing_debtor(vo.getInvestment_price());
			cvo.setClosing_creditor(vo.getInvestment_price());
			cvo.setComcode_no(vo.getComcode_no());
			cvo.setDebtor_no(vo.getDebtor_no());
			cvo.setCreditor_no(vo.getCreditor_no());
			cvo.setCtgr_no(ctgr);
			
			int closing = a4.createClosing(cvo);
			if(closing == 0) {
				int delete = a4.deleteInvestment(vo.getInvestment_no());
				if(delete != 0) {
					String msg = "등록 실패";
					String url = "redirect:/a/a4/a41?comcode_code="+comcode_code;
					model.addAttribute("msg", msg);
					model.addAttribute("url", url);
					return ViewPath.RESULT + "loginresult";
				}
			}else {
				Map<String, Object> dmap = a4.getBsNo(b1);
				Map<String, Object> cmap = a4.getBsNo(b2);
				
				Map<String, Object> map = new HashMap<>();
				map.put("bs3_amount", vo.getInvestment_price());
				map.put("bs3_no", dmap.get("bs3_no"));
				map.put("bs2_no", dmap.get("bsno2"));
				map.put("bs1_no", dmap.get("bs1_no"));
				
				a4.updateBs3Amount(map);
				a4.updateBs2Amount(map);
				a4.updateBs1Amount(map);
				
				map.put("bs3_amount", vo.getInvestment_price());
				map.put("bs3_no", cmap.get("bs3_no"));
				map.put("bs2_no", cmap.get("bsno2"));
				map.put("bs1_no", cmap.get("bs1_no"));
				
				a4.updateBs3Amount(map);
				a4.updateBs2Amount(map);
				a4.updateBs1Amount(map);
			}
			
			return "redirect:/a/a4/a41?comcode_code="+comcode_code;
		}
	}
	
	@RequestMapping("/a41/updateForm")
	public String updateFormI(Erp_InvestmentVO vo, String bs3_no1, String bs3_no2, Model model, String type, String word, String comcode_code) {
		Map<String, Object> map = new HashMap<>();
		int b1 = 0;
		int b2 = 0;
		
		if(bs3_no1 != null) {
			b1 = Integer.parseInt(bs3_no1);
		}
		if(bs3_no2 != null) {
			b2 = Integer.parseInt(bs3_no2);
		}
		
		map.put("investment_no", vo.getInvestment_no());
		map.put("bs3_no1", b1);
		map.put("bs3_no2", b2);
		
		Map<String, Object> inmap = a4.selectInvestment(map);
		
		Map<String, Object> map1 = new HashMap<>();
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		int ctgr = 8;
		int comcode_no = ls.comNo(comcode_code);
		
		map1.put("comcode_no", comcode_no);	
		map1.put("ctgr_no", ctgr);
		map1.put("word", word);
		map1.put("type", type);
		
		List<Map<String, Object>> list = a4.investmentList(map1);
		if(list.isEmpty()) {
			list = null;
		}
		
		List<Erp_Bs3VO> dlist = a4.ctgrDebtor(ctgr);
		List<Erp_Bs3VO> clist = a4.ctgrCreditor(ctgr);
		List<Erp_Bs3VO> blist = a4.bs3List();
		
		Erp_ClientVO cvo = a4.selectClient((int)inmap.get("client_no"));
		Erp_AccountVO avo = a4.selectAccount((int)inmap.get("account_no"));
		
		model.addAttribute("cvo", cvo);
		model.addAttribute("avo", avo);
		
		model.addAttribute("dlist", dlist);
		model.addAttribute("clist", clist);
		model.addAttribute("blist", blist);
		
		model.addAttribute("list", list);
		
		model.addAttribute("inmap", inmap);
		
		model.addAttribute("bs3_no1", bs3_no1);
		model.addAttribute("bs3_no2", bs3_no2);
		
		return ViewPath.A4 + "/a41/inputLoan";
	}
	
	@RequestMapping("/a41/update")
	@Transactional
	public String updateInvestment(Erp_InvestmentVO vo, Model model, String bs3_no11, String bs3_no21, String bs3_no12, String bs3_no22, String comcode_code) {
		Erp_ClosingVO cvo = new Erp_ClosingVO();
		Map<String, Object> map = new HashMap<>();
		map.put("investment_no", vo.getInvestment_no());
		
		if(vo.getInvestment_start().equals("")) {
			vo.setInvestment_start(null);
		}
		if(vo.getInvestment_end().equals("")) {
			vo.setInvestment_end(null);
		}
		
		int b11 = 0;
		int b21 = 0;
		int b12 = 0;
		int b22 = 0;
		
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
		
		int comcode_no = ls.comNo(comcode_code);
		
		map.put("bs3_no1", b11);
		map.put("bs3_no2", b21);
		Map<String, Object> imap = a4.selectInvestment(map);
		Map<String, Object> dmap = a4.getBsNo(b11);
		Map<String, Object> cmap = a4.getBsNo(b21);
		
		map.put("bs3_amount", (-(int)imap.get("investment_price")));
		map.put("bs3_no", dmap.get("bs3_no"));
		map.put("bs2_no", dmap.get("bsno2"));
		map.put("bs1_no", dmap.get("bs1_no"));
		
		int s = a4.updateBs3Amount(map);
		int ss = a4.updateBs2Amount(map);
		int sss = a4.updateBs1Amount(map);
		
		map.put("bs3_amount", (-(int)imap.get("investment_price")));
		map.put("bs3_no", cmap.get("bs3_no"));
		map.put("bs2_no", cmap.get("bsno2"));
		map.put("bs1_no", cmap.get("bs1_no"));
		
		a4.updateBs3Amount(map);
		a4.updateBs2Amount(map);
		a4.updateBs1Amount(map);
		
		vo.setComcode_no(comcode_no);
		int update = a4.updateInvestment(vo);
		
		map.put("bs3_no1", b12);
		map.put("bs3_no2", b22);
		
		imap = a4.selectInvestment(map);
		dmap = a4.getBsNo(b12);
		cmap = a4.getBsNo(b22);
		
		map.put("bs3_amount", vo.getInvestment_price());
		
		s = a4.updateBs3Amount(map);
		ss = a4.updateBs2Amount(map);
		sss = a4.updateBs1Amount(map);
		
		map.put("bs3_amount", vo.getInvestment_price());
		map.put("bs3_no", dmap.get("bs3_no"));
		map.put("bs2_no", dmap.get("bsno2"));
		map.put("bs1_no", dmap.get("bs1_no"));
		
		a4.updateBs3Amount(map);
		a4.updateBs2Amount(map);
		a4.updateBs1Amount(map);
		
		String msg = null;
		String url = null;
		
		if(update != 0) {
			cvo.setClosing_no((int)imap.get("closing_no"));
			cvo.setClosing_code(vo.getInvestment_code());
			cvo.setClosing_debtor(vo.getInvestment_price());
			cvo.setClosing_creditor(vo.getInvestment_price());
			cvo.setComcode_no(vo.getComcode_no());
			cvo.setDebtor_no(vo.getDebtor_no());
			cvo.setCreditor_no(vo.getCreditor_no());
			
			int cupdate = a4.updateClosing(cvo);
			if(cupdate != 0) {
				return "redirect:/a/a4/a41/updateForm?bs3_no1="+b12+"&bs3_no2="+b22+"&investment_no="+vo.getInvestment_no()+"&comcode_code="+comcode_code;
			}else {
				msg = "수정 실패";
				url = "/a/a4/a41/updateForm?bs3_no1="+b12+"&bs3_no2="+b22+"&investment_no="+vo.getInvestment_no()+"&comcode_code="+comcode_code;
			}
		}else {
			msg = "수정 실패";
			url = "/a/a4/a41/updateForm?bs3_no1="+b11+"&bs3_no2="+b21+"&investment_no="+vo.getInvestment_no()+"&comcode_code="+comcode_code;
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return ViewPath.RESULT + "loginresult";
	}
	
	@RequestMapping("/a41/delete")
	@Transactional
	public String deleteInvestment(int investment_no, String bs3_no1, String bs3_no2, Model model, String comcode_code) {
		Map<String, Object> map = new HashMap<>();
		map.put("investment_no", investment_no);
		
		int b1 = 0;
		int b2 = 0;
		
		if(bs3_no1 != null) {
			b1 = Integer.parseInt(bs3_no1);
		}
		if(bs3_no2 != null) {
			b2 = Integer.parseInt(bs3_no2);
		}
		map.put("bs3_no1", b1);
		map.put("bs3_no2", b2);
		Map<String, Object> imap = a4.selectInvestment(map);
		
		int delete = a4.deleteInvestment(investment_no);
		
		String url = null;
		String msg = null;
		
		if(delete != 0) {
				
			int cdelete = a4.deleteClosing((int)imap.get("closing_no"));
			if(cdelete != 0) {
				Map<String, Object> dmap = a4.getBsNo(b1);
				Map<String, Object> cmap = a4.getBsNo(b2);
				
				map.put("bs3_amount", (-(int)imap.get("investment_price")));
				map.put("bs3_no", dmap.get("bs3_no"));
				map.put("bs2_no", dmap.get("bsno2"));
				map.put("bs1_no", dmap.get("bs1_no"));
				
				a4.updateBs3Amount(map);
				a4.updateBs2Amount(map);
				a4.updateBs1Amount(map);
				
				map.put("bs3_no", cmap.get("bs3_no"));
				map.put("bs2_no", cmap.get("bsno2"));
				map.put("bs1_no", cmap.get("bs1_no"));
				
				a4.updateBs3Amount(map);
				a4.updateBs2Amount(map);
				a4.updateBs1Amount(map);
				return "redirect:/a/a4/a41?comcode_code="+comcode_code;
			}else {
				msg = "삭제 실패";
				url = "/a/a4/a41/updateForm?bs3_no1="+bs3_no1+"&bs3_no2="+bs3_no2+"&investment_no="+investment_no+"&comcode_code="+comcode_code;
				return ViewPath.RESULT + "loginresult";
			}
		}else {
			msg = "삭제 실패";
			url = "/a/a4/a41/updateForm?bs3_no1="+bs3_no1+"&bs3_no2="+bs3_no2+"&investment_no="+investment_no+"&comcode_code="+comcode_code;
			model.addAttribute("url", url);
			model.addAttribute("msg", msg);
			return ViewPath.RESULT + "loginresult";
		}
	}
	
	
//	a42
	@RequestMapping("/a42")
	public String inputLease(String type, String word, Model model, String comcode_code) {
		Map<String, Object> map = new HashMap<>();
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		int ctgr = 9;
		int comcode_no = ls.comNo(comcode_code);
		
		map.put("comcode_no", comcode_no);
		map.put("ctgr_no", ctgr);
		map.put("word", word);
		map.put("type", type);
		
		List<Map<String, Object>> list = a4.investmentList(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		List<Erp_Bs3VO> dlist = a4.ctgrDebtor(ctgr);
		List<Erp_Bs3VO> clist = a4.ctgrCreditor(ctgr);
		List<Erp_Bs3VO> blist = a4.bs3List();
		
		model.addAttribute("dlist", dlist);
		model.addAttribute("clist", clist);
		model.addAttribute("blist", blist);
		
		model.addAttribute("list", list);
		
		return ViewPath.A4 + "/a42/inputLease";
	}
	
	@RequestMapping("/a42/content")
	public String contentL(Erp_InvestmentVO vo, String bs3_no1, String bs3_no2, Model model, String type, String word, String comcode_code) {
		Map<String, Object> map = new HashMap<>();
		int b1 = 0;
		int b2 = 0;
		
		if(bs3_no1 != null) {
			b1 = Integer.parseInt(bs3_no1);
		}
		if(bs3_no2 != null) {
			b2 = Integer.parseInt(bs3_no2);
		}
		
		map.put("investment_no", vo.getInvestment_no());
		map.put("bs3_no1", b1);
		map.put("bs3_no2", b2);
		
		Map<String, Object> inmap = a4.selectInvestment(map);
		
		Map<String, Object> map1 = new HashMap<>();
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		int ctgr = 9;
		int comcode_no = ls.comNo(comcode_code);
		
		map1.put("comcode_no", comcode_no);
		map1.put("ctgr_no", ctgr);
		map1.put("word", word);
		map1.put("type", type);
		
		List<Map<String, Object>> list = a4.investmentList(map1);
		if(list.isEmpty()) {
			list = null;
		}
		
		Erp_ClientVO cvo = a4.selectClient((int)inmap.get("client_no"));
		Erp_AccountVO avo = a4.selectAccount((int)inmap.get("account_no"));
		
		model.addAttribute("cvo", cvo);
		model.addAttribute("avo", avo);
		
		model.addAttribute("list", list);
		
		model.addAttribute("inmap", inmap);
		
		return ViewPath.A4 + "/a42/content";
	}
	
	@RequestMapping("/a42/createLease")
	public String createLease(Erp_InvestmentVO vo, Model model, String bs3_no1, String bs3_no2, String comcode_code) {
		int b1 = 0;
		int b2 = 0;
		
		if(vo.getInvestment_start().equals("")) {
			vo.setInvestment_start(null);
		}
		if(vo.getInvestment_end().equals("")) {
			vo.setInvestment_end(null);
		}
		
		if(bs3_no1 != null) {
			b1 = Integer.parseInt(bs3_no1);
		}
		if(bs3_no2 != null) {
			b2 = Integer.parseInt(bs3_no2);
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		vo.setComcode_no(comcode_no);
		
		int insert = a4.createInvestment(vo);
		
		if(insert == 0) {
			String msg = "등록 실패";
			String url = "/a/a4/a42?comcode_code="+comcode_code;
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}else {
			int ctgr = 9;
			
			Erp_ClosingVO cvo = new Erp_ClosingVO();
			cvo.setClosing_code(vo.getInvestment_code());
			cvo.setClosing_debtor(vo.getInvestment_price());
			cvo.setClosing_creditor(vo.getInvestment_price());
			cvo.setComcode_no(vo.getComcode_no());
			cvo.setDebtor_no(vo.getDebtor_no());
			cvo.setCreditor_no(vo.getCreditor_no());
			cvo.setCtgr_no(ctgr);
			
			int closing = a4.createClosing(cvo);
			if(closing == 0) {
				int delete = a4.deleteInvestment(vo.getInvestment_no());
				if(delete != 0) {
					String msg = "등록 실패";
					String url = "redirect:/a/a4/a42?comcode_code="+comcode_code;
					model.addAttribute("msg", msg);
					model.addAttribute("url", url);
					return ViewPath.RESULT + "loginresult";
				}
			}else {
				Map<String, Object> dmap = a4.getBsNo(b1);
				Map<String, Object> cmap = a4.getBsNo(b2);
				
				Map<String, Object> map = new HashMap<>();
				map.put("bs3_amount", vo.getInvestment_price());
				map.put("bs3_no", dmap.get("bs3_no"));
				map.put("bs2_no", dmap.get("bsno2"));
				map.put("bs1_no", dmap.get("bs1_no"));
				
				a4.updateBs3Amount(map);
				a4.updateBs2Amount(map);
				a4.updateBs1Amount(map);
				
				map.put("bs3_amount", vo.getInvestment_price());
				map.put("bs3_no", cmap.get("bs3_no"));
				map.put("bs2_no", cmap.get("bsno2"));
				map.put("bs1_no", cmap.get("bs1_no"));
				
				a4.updateBs3Amount(map);
				a4.updateBs2Amount(map);
				a4.updateBs1Amount(map);
			}
			
			return "redirect:/a/a4/a42?comcode_code="+comcode_code;
		}
	}
	
	@RequestMapping("/a42/updateForm")
	public String updateFormL(Erp_InvestmentVO vo, String bs3_no1, String bs3_no2, Model model, String type, String word, String comcode_code) {
		Map<String, Object> map = new HashMap<>();
		int b1 = 0;
		int b2 = 0;
		
		if(bs3_no1 != null) {
			b1 = Integer.parseInt(bs3_no1);
		}
		if(bs3_no2 != null) {
			b2 = Integer.parseInt(bs3_no2);
		}
		
		map.put("investment_no", vo.getInvestment_no());
		map.put("bs3_no1", b1);
		map.put("bs3_no2", b2);
		
		Map<String, Object> inmap = a4.selectInvestment(map);
		
		Map<String, Object> map1 = new HashMap<>();
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		int ctgr = 9;
		int comcode_no = ls.comNo(comcode_code);
			
		map1.put("comcode_no", comcode_no);
		map1.put("ctgr_no", ctgr);
		map1.put("word", word);
		map1.put("type", type);
		
		List<Map<String, Object>> list = a4.investmentList(map1);
		if(list.isEmpty()) {
			list = null;
		}
		
		List<Erp_Bs3VO> dlist = a4.ctgrDebtor(ctgr);
		List<Erp_Bs3VO> clist = a4.ctgrCreditor(ctgr);
		List<Erp_Bs3VO> blist = a4.bs3List();
		
		Erp_ClientVO cvo = a4.selectClient((int)inmap.get("client_no"));
		Erp_AccountVO avo = a4.selectAccount((int)inmap.get("account_no"));
		
		model.addAttribute("cvo", cvo);
		model.addAttribute("avo", avo);
		
		model.addAttribute("dlist", dlist);
		model.addAttribute("clist", clist);
		model.addAttribute("blist", blist);
		
		model.addAttribute("list", list);
		
		model.addAttribute("inmap", inmap);
		
		model.addAttribute("bs3_no1", bs3_no1);
		model.addAttribute("bs3_no2", bs3_no2);
		
		return ViewPath.A4 + "/a42/updateForm";
	}
	
	@RequestMapping("/a42/update")
	public String updateLease(Erp_InvestmentVO vo, Model model, String bs3_no11, String bs3_no21, String bs3_no12, String bs3_no22, String comcode_code) {
		Erp_ClosingVO cvo = new Erp_ClosingVO();
		Map<String, Object> map = new HashMap<>();
		map.put("investment_no", vo.getInvestment_no());
		
		if(vo.getInvestment_start().equals("")) {
			vo.setInvestment_start(null);
		}
		if(vo.getInvestment_end().equals("")) {
			vo.setInvestment_end(null);
		}
		
		int b11 = 0;
		int b21 = 0;
		int b12 = 0;
		int b22 = 0;
		
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
		
		int comcode_no = ls.comNo(comcode_code);
		
		map.put("bs3_no1", b11);
		map.put("bs3_no2", b21);
		Map<String, Object> imap = a4.selectInvestment(map);
		Map<String, Object> dmap = a4.getBsNo(b11);
		Map<String, Object> cmap = a4.getBsNo(b21);
		
		map.put("bs3_amount", (-(int)imap.get("investment_price")));
		System.out.println("수정 전 금액 : " + imap.get("investment_price"));
		map.put("bs3_no", dmap.get("bs3_no"));
		map.put("bs2_no", dmap.get("bsno2"));
		map.put("bs1_no", dmap.get("bs1_no"));
		
		int s = a4.updateBs3Amount(map);
		int ss = a4.updateBs2Amount(map);
		int sss = a4.updateBs1Amount(map);
		
		map.put("bs3_amount", (-(int)imap.get("investment_price")));
		map.put("bs3_no", cmap.get("bs3_no"));
		map.put("bs2_no", cmap.get("bsno2"));
		map.put("bs1_no", cmap.get("bs1_no"));
		
		a4.updateBs3Amount(map);
		a4.updateBs2Amount(map);
		a4.updateBs1Amount(map);
		
		vo.setComcode_no(comcode_no);
		int update = a4.updateInvestment(vo);
		
		map.put("bs3_no1", b12);
		map.put("bs3_no2", b22);
		
		imap = a4.selectInvestment(map);
		dmap = a4.getBsNo(b12);
		cmap = a4.getBsNo(b22);
		
		map.put("bs3_amount", vo.getInvestment_price());
		
		s = a4.updateBs3Amount(map);
		ss = a4.updateBs2Amount(map);
		sss = a4.updateBs1Amount(map);
		
		map.put("bs3_amount", vo.getInvestment_price());
		map.put("bs3_no", dmap.get("bs3_no"));
		map.put("bs2_no", dmap.get("bsno2"));
		map.put("bs1_no", dmap.get("bs1_no"));
		
		a4.updateBs3Amount(map);
		a4.updateBs2Amount(map);
		a4.updateBs1Amount(map);
		
		String msg = null;
		String url = null;
		
		if(update != 0) {
			cvo.setClosing_no((int)imap.get("closing_no"));
			cvo.setClosing_code(vo.getInvestment_code());
			cvo.setClosing_debtor(vo.getInvestment_price());
			cvo.setClosing_creditor(vo.getInvestment_price());
			cvo.setComcode_no(vo.getComcode_no());
			cvo.setDebtor_no(vo.getDebtor_no());
			cvo.setCreditor_no(vo.getCreditor_no());
			
			int cupdate = a4.updateClosing(cvo);
			if(cupdate != 0) {
				msg = "일마감까지 수정 성공";
				url = "/a/a4/a42/updateForm?bs3_no1="+b12+"&bs3_no2="+b22+"&investment_no="+vo.getInvestment_no()+"&comcode_code="+comcode_code;
			}else {
				msg = "일마감 수정 실패";
				url = "/a/a4/a42/updateForm?bs3_no1="+b12+"&bs3_no2="+b22+"&investment_no="+vo.getInvestment_no()+"&comcode_code="+comcode_code;
			}
		}else {
			msg = "수정 실패";
			url = "/a/a4/a42/updateForm?bs3_no1="+b11+"&bs3_no2="+b21+"&investment_no="+vo.getInvestment_no()+"&comcode_code="+comcode_code;
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return ViewPath.RESULT + "loginresult";
	}
	
	@RequestMapping("/a42/delete")
	public String deleteLease(int investment_no, String bs3_no1, String bs3_no2, Model model, String comcode_code) {
		Map<String, Object> map = new HashMap<>();
		map.put("investment_no", investment_no);
		
		int b1 = 0;
		int b2 = 0;
		
		if(bs3_no1 != null) {
			b1 = Integer.parseInt(bs3_no1);
		}
		if(bs3_no2 != null) {
			b2 = Integer.parseInt(bs3_no2);
		}
		map.put("bs3_no1", b1);
		map.put("bs3_no2", b2);
		Map<String, Object> imap = a4.selectInvestment(map);
		
		int delete = a4.deleteInvestment(investment_no);
		
		String url = null;
		String msg = null;
		
		if(delete != 0) {
				
			int cdelete = a4.deleteClosing((int)imap.get("closing_no"));
			if(cdelete != 0) {
				Map<String, Object> dmap = a4.getBsNo(b1);
				Map<String, Object> cmap = a4.getBsNo(b2);
				
				map.put("bs3_amount", (-(int)imap.get("investment_price")));
				map.put("bs3_no", dmap.get("bs3_no"));
				map.put("bs2_no", dmap.get("bsno2"));
				map.put("bs1_no", dmap.get("bs1_no"));
				
				a4.updateBs3Amount(map);
				a4.updateBs2Amount(map);
				a4.updateBs1Amount(map);
				
				map.put("bs3_no", cmap.get("bs3_no"));
				map.put("bs2_no", cmap.get("bsno2"));
				map.put("bs1_no", cmap.get("bs1_no"));
				
				a4.updateBs3Amount(map);
				a4.updateBs2Amount(map);
				a4.updateBs1Amount(map);
				return "redirect:/a/a4/a42?comcode_code="+comcode_code;
			}else {
				msg = "삭제 실패";
				url = "/a/a4/a42/updateForm?bs3_no1="+bs3_no1+"&bs3_no2="+bs3_no2+"&investment_no="+investment_no+"&comcode_code="+comcode_code;
				return ViewPath.RESULT + "loginresult";
			}
		}else {
			msg = "삭제 실패";
			url = "/a/a4/a42/updateForm?bs3_no1="+bs3_no1+"&bs3_no2="+bs3_no2+"&investment_no="+investment_no+"&comcode_code="+comcode_code;
			model.addAttribute("url", url);
			model.addAttribute("msg", msg);
			return ViewPath.RESULT + "loginresult";
		}
	}
	
	
//	조회 및 ajax
	@RequestMapping("/searcht")
	public String searcht(Model model, String type, String word) {
		Map<String, Object> map = new HashMap<>();
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		map.put("type", type);
		map.put("word", word);
		
		List<Erp_TeamVO> list = a3.teamList(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "a/a4/teamList";
	}
	
	@RequestMapping("/searchim")
	public String searchim(Model model) {
		List<Erp_ImkindVO> list = a4.imkindList();
		if(list.isEmpty()) {
			list = null;
		}
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "a/a4/imList";
	}
	
	@RequestMapping("/acList")
	public String acList(String comcode_code, Model model, String type, String word, String team_code) {
		Map<String, Object> map = new HashMap<>();
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		int comcode_no = ls.comNo(comcode_code);
		
		map.put("team_code", team_code);
		map.put("comcode_no", comcode_no);
		map.put("type", type);
		map.put("word", word);
		
		List<Map<String, Object>> list = a4.accountList(map);
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "a/a4/acList";
	}
	
	@RequestMapping("/clList")
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
		
		List<Map<String, Object>> list = a4.clientList(map);
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "a/a4/clList";
	}
	
	@RequestMapping("/imkind")
	@ResponseBody
	public Erp_ImkindVO imkind(String imkind_name) {
		try {
			Erp_ImkindVO vo = a4.searchim(imkind_name);
			System.out.println(imkind_name);
			
			return vo;
		}catch(Exception e) {
			return null;
		}
	}
	
	@RequestMapping("/team")
	@ResponseBody
	public Erp_TeamVO team(String team_name) {
		try {
			Erp_TeamVO vo = a3.teamName(team_name);
			
			return vo;
		}catch(Exception e) {
			return null;
		}
	}
	
	@RequestMapping("/searchcl")
	@ResponseBody
	public Erp_ClientVO searchcl(String client_name, String comcode_code) {
		try {
			Map<String, Object> map = new HashMap<>();
			
			int comcode_no = ls.comNo(comcode_code);
			
			map.put("comcode_no", comcode_no);
			map.put("client_name", client_name);
			
			Erp_ClientVO vo = a4.searchcl(map);
			
			return vo;
		}catch(Exception e) {
			return null;
		}
	}
	
	@RequestMapping(value="/imcode", produces = "application/text;charset=utf8")
	@ResponseBody
	public String imcode(String investment_code){
		try {
			int imcode = a4.getImCode(investment_code);
			
			return "이미 존재하는 코드입니다.";
		}catch(NullPointerException e) {
			return "사용 가능한 코드입니다.";
		}
	}
	
}
