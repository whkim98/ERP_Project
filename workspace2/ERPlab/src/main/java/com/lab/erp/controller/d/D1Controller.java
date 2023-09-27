package com.lab.erp.controller.d;

import java.util.HashMap;

import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lab.erp.common.ViewPath;
import com.lab.erp.service.a.A4Service;
import com.lab.erp.service.d.D1Service;
import com.lab.erp.service.d.D2Service;
import com.lab.erp.service.login.LoginService;
import com.lab.erp.vo.b.b1.Erp_Bs3VO;
import com.lab.erp.vo.b.b1.Erp_ClosingVO;
import com.lab.erp.vo.c.Erp_ClientVO;
import com.lab.erp.vo.d.d1.Erp_BomVO;
import com.lab.erp.vo.d.d1.Erp_ConnectrequestVO;
import com.lab.erp.vo.d.d1.Erp_DefectiveVO;
import com.lab.erp.vo.d.d1.Erp_EvaluationVO;
import com.lab.erp.vo.d.d1.Erp_EvaluemngVO;
import com.lab.erp.vo.d.d1.Erp_InvenlotVO;
import com.lab.erp.vo.d.d1.Erp_LotconnevVO;
import com.lab.erp.vo.d.d1.Erp_PedVO;
import com.lab.erp.vo.d.d1.Erp_PedworkVO;
import com.lab.erp.vo.d.d1.Erp_ProductVO;
import com.lab.erp.vo.d.d1.Erp_ProinventoryVO;
import com.lab.erp.vo.d.d1.Erp_RequestproductVO;
import com.lab.erp.vo.d.d1.Erp_WorktypeVO;
import com.lab.erp.vo.d.d6.Erp_GoodsVO;
import com.lab.erp.vo.d.d6.Erp_GoodslevVO;
import com.lab.erp.vo.d.d6.Erp_GoodslotVO;
import com.lab.erp.vo.d.d6.Erp_GoodsstVO;

import jakarta.servlet.http.HttpServletRequest;

@RequestMapping("/d/d1")
@Controller
public class D1Controller {
	private LoginService ls;
	private D1Service d1;
	private HttpServletRequest request;
	private A4Service a4;
	private D2Service d2;
	
	@Autowired
	public D1Controller(LoginService ls, D1Service d1, HttpServletRequest request, A4Service a4, D2Service d2) {
		this.ls = ls;
		this.d1 = d1;
		this.request = request;
		this.a4 = a4;
		this.d2 = d2;
	}
	
//	생산의뢰 requestproduct
	@RequestMapping("/d12/inputRequestProduct")
	public String inputRequestProduct(String type, String word, String comcode_code, Model model) {
		if(type == null || word == null) {
			type = null;
			word = null;
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
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> list = d1.requestProductList(map);
		
		model.addAttribute("list", list);
		
		return ViewPath.D1 + "/d12/inputRequestProduct";
		
	}
	
	@RequestMapping("/d12/requestProductAjax")
	@ResponseBody
	public List<Map<String, Object>> requestProductAjax(String type, String word, String comcode_code) {
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> list = d1.requestProductList(map);
		
		if(list.isEmpty()) {
			list = null;
		}
		
		return list;
		
	}
	
	@RequestMapping("/d12/addRequestProduct")
	public String re(Model model, String comcode_code) {
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
		
		List<Map<String, Object>> sortkind = d1.sortkind();
		
		model.addAttribute("sortkind", sortkind);
		return ViewPath.D1 + "/d12/selectRequestProduct";
	}
	
	@RequestMapping("/d12/updateForm")
	public String updateFormRP(Model model, Erp_RequestproductVO vo, String comcode_code) {
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
		
		Map<String, Object> inmap = d1.selectRequestProduct(vo.getRequestproduct_no());
		List<Map<String, Object>> glist = d1.selectRequestGoods(vo.getRequestproduct_no());
		List<Map<String, Object>> sortkind = d1.sortkind();
		
		model.addAttribute("sortkind", sortkind);
		model.addAttribute("inmap", inmap);
		model.addAttribute("glist", glist);
		
		return ViewPath.D1 + "/d12/selectRequestProduct";
	}
	
	@RequestMapping("/d12/createRequestProduct")
	@Transactional
	public String createRequestProduct(Erp_RequestproductVO vo, Erp_ConnectrequestVO crlist1, String comcode_code, Model model) {
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
		
		d1.createRequestProduct(vo);
		
		int rpno = d1.getRequestProductNo(vo.getRequestproduct_code());
		List<Erp_ConnectrequestVO> cvo = crlist1.getCrlist1();
		
		for(int i = 0; i < crlist1.getCrlist1().size(); i++) {
			crlist1.getCrlist1().get(i).setRequestproduct_no(rpno);
		}
		
		for(Erp_ConnectrequestVO crvo : cvo) {
			int customer = crvo.getGoods_customerprice() * 3;
			crvo.setGoodslot_price(customer);
			d1.createConnectRequest(crvo);
		}
		
		return "redirect:/d/d1/d12/inputRequestProduct?comcode_code="+comcode_code;
	}
	
	@RequestMapping("/d12/update")
	@Transactional
	public String updateRequestProduct(Erp_RequestproductVO vo, Erp_ConnectrequestVO crlist, Erp_ConnectrequestVO crlist1, String comcode_code, Model model) {
		
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
		
		d1.updateRequestProduct(vo);
		
		List<Erp_ConnectrequestVO> cvo = crlist.getCrlist();
		
		if(cvo != null) {
			for(Erp_ConnectrequestVO crvo : cvo) {
				d1.updateConnectRequest(crvo);
			}
		}
		
		List<Erp_ConnectrequestVO> cvo1 = crlist1.getCrlist1();
		
		if(cvo1 == null) {
			return "redirect:/d/d1/d12/updateForm?comcode_code="+comcode_code+"&requestproduct_no="+vo.getRequestproduct_no();
		}else {
			for(int i = 0; i < crlist1.getCrlist1().size(); i++) {
				crlist1.getCrlist1().get(i).setRequestproduct_no(vo.getRequestproduct_no());
			}
			for(Erp_ConnectrequestVO crvo : cvo1) {
				d1.createConnectRequest(crvo);
			}
			return "redirect:/d/d1/d12/updateForm?comcode_code="+comcode_code+"&requestproduct_no="+vo.getRequestproduct_no();
		}
	}
	
	@RequestMapping("/d12/delete")
	@Transactional
	public String deleteRequestProduct(Erp_RequestproductVO vo, String comcode_code, Model model) {
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
		
		d1.deleteConnectRequestNo(vo.getRequestproduct_no());
		
		d1.deleteRequestProduct(vo.getRequestproduct_no());
		
		return "redirect:/d/d1/d12/inputRequestProduct?comcode_code="+comcode_code;
	}
	
	@RequestMapping("/d12/deleteGoods")
	@ResponseBody
	public List<Map<String, Object>> selectRequestProductGoods(Erp_RequestproductVO vo, Erp_ConnectrequestVO cvo){
		d1.deleteConnectRequest(cvo.getConnectrequest_no());
		
		List<Map<String, Object>> list = d1.selectRequestGoods(vo.getRequestproduct_no());
		
		return list;
	}
	
	@RequestMapping("/d12/goodsList")
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
		
		List<Map<String, Object>> list = d1.goodsListd1(map);
		
		model.addAttribute("list", list);
		model.addAttribute("i", i);
		
		return ViewPath.WINDOW + "d/d1/d12/goodsList";
	}
	@RequestMapping("/d12/goodsList1")
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
		
		List<Map<String, Object>> list = d1.goodsListd1(map);
		
		model.addAttribute("list", list);
		model.addAttribute("i", i);
		
		return ViewPath.WINDOW + "d/d1/d12/goodsList1";
	}
	
	@RequestMapping("/d12/goodsListAjax")
	@ResponseBody
	public List<Map<String, Object>> goodsListAjaxd12(String btype, String bnword, String comcode_code) {
		
		int comcode_no = ls.comNo(comcode_code);
		
		if(btype == null || bnword == null) {
			btype = null;
			bnword = null;
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("comcode_no", comcode_no);
		map.put("btype", btype);
		map.put("bnword", bnword);
		
		List<Map<String, Object>> list = d1.goodsListd1(map);
		
		return list;
	}
	
	
	
//	생산 / 제조 
	@RequestMapping("/d11/inputProduct")
	public String inputProduct(@RequestParam("comcode_code") String comcode_code, String type, String word, Model model) {
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
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> list = d1.productList(map);
		List<Erp_Bs3VO> dlist = d1.ctgrDebtor(47);
		List<Erp_Bs3VO> clist = d1.ctgrCreditor(47);
		
		model.addAttribute("list", list);
		model.addAttribute("dlist", dlist);
		model.addAttribute("clist", clist);
		
		return ViewPath.D1 + "/d11/inputProduct";
	}
	
	@RequestMapping("/d11/productAjax")
	@ResponseBody
	public List<Map<String, Object>> productAjax(String comcode_code, String type, String word) {
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> list = d1.productList(map);
		
		return list;
	}
	
	@RequestMapping("/d11/addProduct")
	public String addProduct(Model model) {
		List<Erp_Bs3VO> dlist = d1.ctgrDebtor(47);
		List<Erp_Bs3VO> clist = d1.ctgrCreditor(47);
		
		model.addAttribute("dlist", dlist);
		model.addAttribute("clist", clist);
		
		return ViewPath.D1 + "/d11/selectProduct";
	}
	
	@RequestMapping("/d11/updateForm")
	public String updateFormPRO(String comcode_code, Erp_ProductVO vo, Model model, String type, String word) {
		Map<String, Object> inmap = d1.selectProduct(vo.getProduct_no());
		
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
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> list = d1.productList(map);
		List<Erp_Bs3VO> dlist = d1.ctgrDebtor(47);
		List<Erp_Bs3VO> clist = d1.ctgrCreditor(47);
		Map<String, Object> cmap = d1.getClosingCode(vo.getProduct_code());
		
		model.addAttribute("cmap", cmap);
		model.addAttribute("inmap", inmap);
		model.addAttribute("list", list);
		model.addAttribute("dlist", dlist);
		model.addAttribute("clist", clist);
		
		return ViewPath.D1 + "/d11/inputProduct";
	}
	
	@RequestMapping("/d11/goodsAjax")
	@ResponseBody
	public List<Map<String, Object>> goodsAjax(Erp_ProductVO vo){
		List<Map<String, Object>> list = d1.selectRequestGoods(vo.getRequestproduct_no());
		
		if(list.isEmpty()) {
			list = null;
		}
		
		return list;
	}
	
	@RequestMapping("/d11/createProduct")
	@Transactional
	public String createProduct(Erp_ProductVO vo, String bs3_no1, String bs3_no2, String debtor_no, String creditor_no,
			String comcode_code, Model model) {
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
		
		d1.createProduct(vo);
		
		int debtno = 0;
		int creditno = 0;
		int b1 = 0;
		int b2 = 0;
		
		if(debtor_no == "") {
			debtno = 0;
		}else {
			debtno = Integer.parseInt(debtor_no);
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
		
		Erp_ClosingVO cvo = new Erp_ClosingVO();
		
		cvo.setClosing_code(vo.getProduct_code());
		cvo.setClosing_creditor(vo.getProduct_totalbudget());
		cvo.setClosing_debtor(vo.getProduct_totalbudget());
		cvo.setDebtor_no(debtno);
		cvo.setCreditor_no(creditno);
		cvo.setCtgr_no(47);
		cvo.setComcode_no(comcode_no);
		
		d1.createClosing(cvo);
		
		Map<String, Object> map = new HashMap<>();
		Map<String, Object> dmap = d1.getBsNo(b1);
		Map<String, Object> cmap = d1.getBsNo(b2);
		
		map.put("bs3_amount", vo.getProduct_totalbudget());
		map.put("bs1_no", dmap.get("bs1_no"));
		map.put("bs2_no", dmap.get("bsno2"));
		map.put("bs3_no", dmap.get("bs3_no"));
		
		d1.updateBs1Amount(map);
		d1.updateBs2Amount(map);
		d1.updateBs3Amount(map);
		
		map.put("bs3_amount", (-vo.getProduct_totalbudget()));
		map.put("bs1_no", cmap.get("bs1_no"));
		map.put("bs2_no", cmap.get("bsno2"));
		map.put("bs3_no", cmap.get("bs3_no"));
		
		d1.updateBs1Amount(map);
		d1.updateBs2Amount(map);
		d1.updateBs3Amount(map);
		
		System.out.println("coed = "+comcode_code);
		
		return "redirect:/d/d1/d11/inputProduct?comcode_code="+comcode_code;
	}
	
	@RequestMapping(value="/d11/update", produces = "application/text;charset=utf8")
	@Transactional
	public String updateProduct(String bs3_no11, String bs3_no21, String bs3_no12, String bs3_no22, 
			String debtor_no, String creditor_no, Model model, String comcode_code, Erp_ProductVO vo) {
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
		
		Map<String, Object> imap = d1.selectProduct(vo.getProduct_no());
		
		int debtno = 0;
		int creditno = 0;
		int b11 = 0;
		int b21 = 0;
		int b12 = 0;
		int b22 = 0;
		
		if(debtor_no == "") {
			debtno = 0;
		}else {
			debtno = Integer.parseInt(debtor_no);
		}
		if(creditor_no == "") {
			creditno = 0;
		}else {
			creditno = Integer.parseInt(creditor_no);
		}
		if(bs3_no11 == "") {
			b11 = 0;
		}else {
			b11 = Integer.parseInt(bs3_no11);
		}
		if(bs3_no21 == "") {
			b21 = 0;
		}else {
			b21 = Integer.parseInt(bs3_no21);
		}
		if(bs3_no12 == "") {
			b12 = b11;
		}else {
			b12 = Integer.parseInt(bs3_no12);
		}
		if(bs3_no22 == "") {
			b22 = b21;
		}else {
			b22 = Integer.parseInt(bs3_no22);
		}
		
		d1.updateProduct(vo);
		
		int cno = d1.getClosingNo(vo.getProduct_code());
		
		Erp_ClosingVO cvo = new Erp_ClosingVO();
		
		cvo.setClosing_code(vo.getProduct_code());
		cvo.setClosing_debtor(vo.getProduct_totalbudget());
		cvo.setClosing_debtor(vo.getProduct_totalbudget());
		cvo.setClosing_no(cno);
		cvo.setDebtor_no(debtno);
		cvo.setCreditor_no(creditno);
		
		d1.updateClosing(cvo);
		
		Map<String, Object> map = new HashMap<>();
		Map<String, Object> dmap = d1.getBsNo(b11);
		Map<String, Object> cmap = d1.getBsNo(b21);
		
		
		map.put("bs3_amount", (-(int)imap.get("product_totalbudget")));
		map.put("bs1_no", dmap.get("bs1_no"));
		map.put("bs2_no", dmap.get("bsno2"));
		map.put("bs3_no", dmap.get("bs3_no"));
		
		d1.updateBs1Amount(map);
		d1.updateBs2Amount(map);
		d1.updateBs3Amount(map);
		
		map.put("bs3_amount", (int)imap.get("product_totalbudget"));
		map.put("bs1_no", cmap.get("bs1_no"));
		map.put("bs2_no", cmap.get("bsno2"));
		map.put("bs3_no", cmap.get("bs3_no"));
		
		d1.updateBs1Amount(map);
		d1.updateBs2Amount(map);
		d1.updateBs3Amount(map);
		
		
		dmap = d1.getBsNo(b12);
		cmap = d1.getBsNo(b22);
		
		map.put("bs3_amount", vo.getProduct_totalbudget());
		map.put("bs1_no", dmap.get("bs1_no"));
		map.put("bs2_no", dmap.get("bsno2"));
		map.put("bs3_no", dmap.get("bs3_no"));
		
		d1.updateBs1Amount(map);
		d1.updateBs2Amount(map);
		d1.updateBs3Amount(map);
		
		map.put("bs3_amount", (-vo.getProduct_totalbudget()));
		map.put("bs1_no", cmap.get("bs1_no"));
		map.put("bs2_no", cmap.get("bsno2"));
		map.put("bs3_no", cmap.get("bs3_no"));
		
		d1.updateBs1Amount(map);
		d1.updateBs2Amount(map);
		d1.updateBs3Amount(map);
		
		String code = URLEncoder.encode(vo.getProduct_code());
		
		return "redirect:/d/d1/d11/updateForm?comcode_code="+comcode_code+"&product_no="+vo.getProduct_no()+"&product_code="+code;
	}
	
	@RequestMapping("/d11/delete")
	@Transactional
	public String deleteProduct(String bs3_no1, String bs3_no2, Model model, String comcode_code, Erp_ProductVO vo) {
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
		
		int cno = d1.getClosingNo(vo.getProduct_code());
		
		d1.deleteClosing(cno);
		
		d1.deleteProduct(vo.getProduct_no());
		
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
		
		Map<String, Object> map = new HashMap<>();
		Map<String, Object> dmap = d1.getBsNo(b1);
		Map<String, Object> cmap = d1.getBsNo(b2);
		
		map.put("bs3_amount", (-vo.getProduct_totalbudget()));
		map.put("bs1_no", dmap.get("bs1_no"));
		map.put("bs2_no", dmap.get("bsno2"));
		map.put("bs3_no", dmap.get("bs3_no"));
		
		d1.updateBs1Amount(map);
		d1.updateBs2Amount(map);
		d1.updateBs3Amount(map);
		
		map.put("bs3_amount", vo.getProduct_totalbudget());
		map.put("bs1_no", cmap.get("bs1_no"));
		map.put("bs2_no", cmap.get("bsno2"));
		map.put("bs3_no", cmap.get("bs3_no"));
		
		d1.updateBs1Amount(map);
		d1.updateBs2Amount(map);
		d1.updateBs3Amount(map);
		
		return "redirect:/d/d1/d11/inputProduct?comcode_code="+comcode_code;
	}
	
	@RequestMapping("/d11/employee")
	public String employee(String comcode_code, Model model, String type, String word) {
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
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> list = d1.employee(map);
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "d/d1/d11/employee";
	}
	
	@RequestMapping("/d11/employeeAjax")
	@ResponseBody
	public List<Map<String, Object>> employeeAjax(String comcode_code, String type, String word) {
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> list = d1.employee(map);
		
		return list;
	}
	
	@RequestMapping("/d11/requestproduct")
	public String requestproduct(String comcode_code, String type, String word, Model model) {
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
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> list = d1.requestProductList(map);
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "d/d1/d11/requestproduct";
	}
	
	@RequestMapping("/d11/requestproductAjax")
	@ResponseBody
	public List<Map<String, Object>> requestproductAjax(String comcode_code, String type, String word) {
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> list = d1.requestProductList(map);
		
		return list;
	}
	
	@RequestMapping(value="/d11/getProductCode", produces = "application/text;charset=utf8")
	@ResponseBody
	public String getProductCode(String product_code) {
		try {
			
			if(product_code == "") {
				return "공백은 허용되지 않습니다.";
			}
			
			int no = d1.getProductCode(product_code);
			
			return "이미 존재하는 코드입니다.";
		}catch(Exception e) {
			return "사용 가능한 코드입니다.";
		}
	}
	
	@RequestMapping(value="/d11/getLotNo", produces = "application/text;charset=utf8")
	@ResponseBody
	public String getLotNo(String goodslot_lot) {
		try {
			
			if(goodslot_lot == "") {
				return "공백은 허용되지 않습니다.";
			}
			
			String no = d1.getLotNo1(goodslot_lot);
			if(no == null) {
				throw new Exception();
			}
			
			return "이미 존재하는 로트입니다.";
		}catch(Exception e) {
			return "사용 가능한 로트입니다.";
		}
	}
	
	@RequestMapping(value="/d11/checkRequest", produces = "application/text;charset=utf8")
	@ResponseBody
	public String checkRequest(Erp_RequestproductVO vo) {
		try {
			
			Map<String, Object> map = d1.selectRequestProduct(vo.getRequestproduct_no());
			if(map == null) {
				return "생산 가능한 의뢰입니다.";
			}
			
			return "이미 해당 의뢰에 대한 생산이 등록되어있습니다.";
		}catch(Exception e) {
			return "생산 가능한 의뢰입니다.";
		}
	}
	
	
	
//	생산 실적 관리
	@RequestMapping("/d14/inputEvaluation")
	public String inputEvaluation(String comcode_code, String type, String word, Model model) {
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
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);	
		
		List<Map<String, Object>> list = d1.evaluationList(map);
		
		model.addAttribute("list", list);
		
		return ViewPath.D1 + "/d14/inputEvaluation";
	}
	
	@RequestMapping("/d14/evAjax")
	@ResponseBody
	public List<Map<String, Object>> evAjax(String comcode_code, String type, String word, Model model) {
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);	
		
		List<Map<String, Object>> list = d1.evaluationList(map);
		
		return list;
	}
	
	@RequestMapping("/d14/updateForm")
	public String updateFormEV(String comcode_code, Erp_EvaluationVO vo, String type, String word, Model model) {
		if(type == null || word == null) {
			type = null;
			word = null;
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
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);	
		
		System.out.println("no = " + vo.getEvaluation_no());
		
		List<Map<String, Object>> list = d1.evaluationList(map);
		Map<String, Object> inmap = d1.selectEvaluation(vo.getEvaluation_no());
		List<Map<String, Object>> dlist = d1.defectivePro(vo.getRequestproduct_no());
		
		model.addAttribute("dlist", dlist);
		model.addAttribute("list", list);
		model.addAttribute("inmap", inmap);
		
		return ViewPath.D1 + "/d14/inputEvaluation";
	}
	
	@RequestMapping("/d14/goodsAjax")
	@ResponseBody
	public List<Map<String, Object>> lotAjax(Erp_ProductVO vo){
		List<Map<String, Object>> list = d1.selectRequestGoods(vo.getRequestproduct_no());
		
		if(list.isEmpty()) {
			list = null;
		}
		
		return list;
	}
	
	@RequestMapping("/d14/defective")
	public String defective(String comcode_code, Model model, String type, String word) {
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
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);	
		
		List<Map<String, Object>> list = d1.defectiveList(map);
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "d/d1/d14/defective";
	}
	
	@RequestMapping("/d14/createEvaluation")
	@Transactional
	public String createEvaluation(Erp_EvaluationVO vo, String comcode_code, Model model, 
			String[] defective_comment, String[] defective_number, Erp_ProductVO pvo, 
			String[] lotconnev_qty) {
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
		
		d1.createEvaluation(vo);
		
		List<Map<String, Object>> list = d1.selectRequestGoods(vo.getRequestproduct_no());
		Map<String, Object> map = d1.selectProduct(pvo.getProduct_no());
		
		int lotqty = 0;
		
		
		for(int i = 0; i < list.size(); i++) {
			Erp_GoodslotVO lvo = new Erp_GoodslotVO();
			Erp_GoodsVO gvo = new Erp_GoodsVO();
			int lotprice = (int)list.get(i).get("goodslot_price");
			double tax = lotprice * 0.1;
			int total = lotprice + (int)tax;
			if(lotconnev_qty[i] != "") {
				lotqty = Integer.parseInt(lotconnev_qty[i]);
			}else {
				lotqty = 0;
			}
			
			try {
				int goodsno = d1.goodsno((String)list.get(i).get("goods_code"));
				
				gvo.setGoods_no(goodsno);
				gvo.setGoods_stockqty(lotqty);
				d2.updateGoodsOne(gvo);
				
			}catch(Exception e) {
				gvo.setGoods_code((String)list.get(i).get("goods_code"));
				gvo.setGoods_barcode((String)list.get(i).get("goods_barcode"));
				gvo.setGoods_customerprice((int)list.get(i).get("goods_customerprice"));
				gvo.setGoods_description((String)list.get(i).get("goods_description"));
				gvo.setGoods_name((String)list.get(i).get("goods_name"));
				gvo.setGoods_stockqty(lotqty);
				gvo.setGoodskind_no((int)list.get(i).get("goodskind_no"));
				gvo.setGoodslev_no(1);
				
				Erp_GoodsstVO gtvo = new Erp_GoodsstVO();
				gtvo.setGoodsst_ea((int)list.get(i).get("goodsst_ea"));
				gtvo.setGoodsst_package((String)list.get(i).get("goodsst_package"));
				gtvo.setGoodsst_size((String)list.get(i).get("goodsst_size"));
				gtvo.setGoodsst_spec((String)list.get(i).get("goodsst_spec"));
				gtvo.setGoodsst_unit((String)list.get(i).get("goodsst_unit"));
				d1.createGoodsst(gtvo);
				int gtno = d1.goodsstno(null);
				
				gvo.setGoodsst_no(gtno);
				gvo.setClient_no1((int)list.get(i).get("client_no1"));
				gvo.setClient_no2((int)list.get(i).get("client_no2"));
				gvo.setComcode_no(comcode_no);
				
				d1.createGoods(gvo);
			}
			int goodsno = d1.goodsno((String)list.get(i).get("goods_code"));
			
			lvo.setGoodslot_qty(lotqty);
			lvo.setGoodslot_lot(pvo.getProduct_lot());
			lvo.setGoods_no(goodsno);
			lvo.setGoodslot_price(lotprice);
			lvo.setGoodslot_tax((int)tax);
			lvo.setGoodslot_total(total);
			lvo.setGoodslot_expiry("9999-01-01");
			
			d1.createGoodsLot(lvo);
			
		}
		
		List<Integer> glno = d1.getLotNo(pvo.getProduct_lot());
		for(int i = 0; i < defective_number.length; i++) {
			Erp_DefectiveVO dvo = new Erp_DefectiveVO();
			
			dvo.setComcode_no(comcode_no);
			dvo.setDefective_comment(defective_comment[i]);
			dvo.setDefective_number(Integer.parseInt(defective_number[i]));
			dvo.setGoodslot_no(glno.get(i));
			dvo.setRequestproduct_no(vo.getRequestproduct_no());
			
			d1.createDefective(dvo);
			
			if(lotconnev_qty[i] != null) {
				lotqty = Integer.parseInt(lotconnev_qty[i]);
			}else {
				lotqty = 0;
			}
			Erp_LotconnevVO lcvo = new Erp_LotconnevVO();
			lcvo.setEvaluation_no(d1.getEvalueationNo());
			lcvo.setGoodslot_no(glno.get(i));
			lcvo.setLotconnev_qty(lotqty);
			
			d1.createLotEv(lcvo);
		}
		
		return "redirect:/d/d1/d14/inputEvaluation?comcode_code="+comcode_code;
	}
	
	@RequestMapping("/d14/update")
	@Transactional
	public String updateEvaluation(Erp_EvaluationVO vo, String comcode_code, Model model, 
			String[] defective_comment, String[] defective_number, String[] lotconnev_qty, 
			Erp_ProductVO pvo) {
		Map<String, Object> imap = d1.selectProduct(pvo.getProduct_no());
		
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
		
		d1.updateEvaluation(vo);
		
		List<Map<String, Object>> depro = d1.defectivePro(vo.getRequestproduct_no());
		
		for(int i = 0; i < defective_comment.length; i++) {
			Erp_DefectiveVO dvo = new Erp_DefectiveVO();
			
			dvo.setDefective_no((int)depro.get(i).get("defective_no"));
			dvo.setDefective_comment(defective_comment[i]);
			if(defective_number[i] != null) {
				dvo.setDefective_number(Integer.parseInt(defective_number[i]));
			}else {
				dvo.setDefective_number(0);
			}
			
			d1.updateDefective(dvo);
		}
		
		List<Map<String, Object>> list = d1.selectRequestGoods(vo.getRequestproduct_no());
		
		List<Map<String, Object>> lclist = d1.selectEvGoods(vo.getEvaluation_no());
		
		int lotqty = 0;
		List<Integer> glno = d1.getLotNo((String)imap.get("product_lot"));
		for(int i = 0; i < list.size(); i++) {
			Erp_GoodslotVO lvo = new Erp_GoodslotVO();
			Erp_GoodsVO gvo = new Erp_GoodsVO();
			
			if(lotconnev_qty[i] != null) {
				lotqty = Integer.parseInt(lotconnev_qty[i]);
			}else {
				lotqty = 0;
			}
			
			int goodsno = d1.goodsno((String)list.get(i).get("goods_code"));
			gvo.setGoods_no(goodsno);
			gvo.setGoods_stockqty((int)lclist.get(i).get("goodslot_qty"));
			d2.updateGoodsSub(gvo);
			
			gvo.setGoods_stockqty(lotqty);
			d2.updateGoodsOne(gvo);
			
			lvo.setGoodslot_no(glno.get(i));
			lvo.setGoodslot_qty(lotqty);
			
			d1.updateLotQty(lvo);
			
			Erp_LotconnevVO lcvo = new Erp_LotconnevVO();
			lcvo.setLotconnev_no((int)lclist.get(i).get("lotconnev_no"));
			lcvo.setLotconnev_qty(lotqty);
			
			d1.updateLotEv(lcvo);
		}
		
		return "redirect:/d/d1/d14/updateForm?comcode_code="+comcode_code+"&evaluation_no="+vo.getEvaluation_no()+"&requestproduct_no="+vo.getRequestproduct_no();
	}
	
	@RequestMapping("/d14/delete")
	@Transactional
	public String deleteEvaluation(Erp_EvaluationVO vo, String comcode_code, Model model) {
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
		
		d1.deleteEvmng(vo.getEvaluation_no());
		
		d1.deleteProAll(vo.getRequestproduct_no());
		
		d1.deleteLotEvNo(vo.getEvaluation_no());
		
		d1.deleteEvaluation(vo.getEvaluation_no());
		
		return "redirect:/d/d1/d14/inputEvaluation?comcode_code="+comcode_code;
	}
	
	@RequestMapping("/d14/employee")
	public String employee1(String comcode_code, Model model, String type, String word) {
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
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> list = d1.employee(map);
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "d/d1/d14/employee";
	}
	
	@RequestMapping("/d14/selectProduct")
	public String selectProduct(String comcode_code, String type, String word, Model model) {
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
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> list = d1.productList(map);
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "d/d1/d14/selectProduct";
	}
	
	@RequestMapping("/d14/selectProductAjax")
	@ResponseBody
	public List<Map<String, Object>> selectProductAjax(String comcode_code, String type, String word) {
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> list = d1.productList(map);
		
		return list;
	}
	
	@RequestMapping(value="/d14/checkProduct",produces = "application/text;charset=utf8")
	@ResponseBody
	public String checkProduct(Erp_ProductVO vo) {
		try {
			Map<String,Object> map = d1.checkProduct(vo.getProduct_no());
			if(map == null) {
				return "평가 가능한 생산입니다.";
			}
			return "이미 평가가 완료된 생산입니다.";
		}catch(Exception e) {
			e.printStackTrace();
			return "평가 가능한 생산입니다.";
		}
	}
	
	
	
//	작업 실적 관리
	@RequestMapping("/d15/inputEvaluemng")
	public String inputEvaluemng(String comcode_code, String type, String word, Model model) {
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
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);	
		
		List<Map<String, Object>> list = d1.evmngList(map);
		if(list.isEmpty()) {
			list = d1.evaluationList(map);
		}
		
		model.addAttribute("list", list);
		
		return ViewPath.D1 + "/d15/inputEvaluemng";
	}
	
	@RequestMapping("/d15/inputEvAjax")
	@ResponseBody
	public List<Map<String, Object>> inputEvAjax(String comcode_code, String type, String word){
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);	
		
		List<Map<String, Object>> list = d1.evmngList(map);
		
		return list;
	}
	
	@RequestMapping("/d15/add")
	public String addForm15(String comcode_code, String type, String word, Model model) {
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
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);	
		
		List<Map<String, Object>> list = d1.evaluationList(map);
		
		model.addAttribute("list", list);
		
		return ViewPath.D1 + "/d15/inputEvaluemng";
	}
	
	@RequestMapping("/d15/updateForm")
	public String updateFormMG(String comcode_code, String type, String word, Model model, Erp_EvaluemngVO vo, Erp_EvaluationVO evo) {
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
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);	
		
		List<Integer> ev = d1.getEvaluemng(vo.getEvaluation_no());
		
		if(ev.isEmpty() || vo.getEvaluemng_no() == 0) {
			List<Map<String, Object>> list = d1.evaluationList(map);
			Map<String, Object> imap = d1.selectEvaluation(vo.getEvaluation_no());
			List<Map<String, Object>> dlist = d1.defectivePro(evo.getRequestproduct_no());
			model.addAttribute("dlist", dlist);
			model.addAttribute("list", list);
			model.addAttribute("imap", imap);
			return ViewPath.D1 + "/d15/inputEvaluemng";
		}else {
			List<Map<String, Object>> list = d1.evmngList(map);
			Map<String, Object> inmap = d1.selectEvmng(vo.getEvaluemng_no());
			List<Map<String, Object>> dlist = d1.defectivePro(evo.getRequestproduct_no());
			model.addAttribute("dlist", dlist);
			model.addAttribute("list", list);
			model.addAttribute("inmap", inmap);
			return ViewPath.D1 + "/d15/inputEvaluemng";
		}
		
	}
	
	@RequestMapping("/d15/createEvaluemng")
	public String createEvaluemng(String comcode_code, Erp_EvaluemngVO vo, Model model) {
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
		
		d1.createEvaluemng(vo);
		
		return "redirect:/d/d1/d15/inputEvaluemng?comcode_code="+comcode_code;
	}
	
	@RequestMapping("/d15/update")
	public String updateEvaluemng(String comcode_code, Erp_EvaluemngVO vo, Model model) {
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
		
		d1.updateEvaluemng(vo);
		
		return "redirect:/d/d1/d15/updateForm?comcode_code="+comcode_code+"&evaluation_no="+vo.getEvaluation_no()+"&evaluemng_no="+vo.getEvaluemng_no();
	}
	
	@RequestMapping("/d15/delete")
	public String deleteEvaluemng(String comcode_code, Erp_EvaluemngVO vo, Model model) {
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
		
		d1.deleteEvaluemng(vo.getEvaluemng_no());
		
		return "redirect:/d/d1/d15/inputEvaluemng?comcode_code="+comcode_code;
	}
	
	
//	공정 재고 관리
	@RequestMapping("/d17/inputProinventory")
	public String inputProinventory(String comcode_code, Model model, String type, String word) {
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
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> list = d1.proinvenList(map);
		
		model.addAttribute("list", list);
		
		return ViewPath.D1 + "/d17/inputProinventory";
	}
	
	@RequestMapping("/d17/add")
	public String addInven(String comcode_code, Model model) {
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
		
		return ViewPath.D1 + "/d17/inputGoods";
	}
	
	@RequestMapping("/d17/updateForm")
	public String updateFormPI(String comcode_code, Model model, String type, String word, Erp_ProinventoryVO vo) {
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
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		map.put("proinventory_no", vo.getProinventory_no());
		
		Map<String, Object> inmap = d1.selectPro(vo.getProinventory_no());
		List<Map<String, Object>> plist = d1.selectProInven(map);
		
		model.addAttribute("plist", plist);
		model.addAttribute("inmap", inmap);
		
		return ViewPath.D1 + "/d17/inputGoods";
	}
	
	@RequestMapping("/d17/selectProInven")
	@ResponseBody
	public List<Map<String, Object>> selectProInven(Erp_ProinventoryVO vo, String type, String word){
		Map<String, Object> map = new HashMap<>();
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		map.put("type", type);
		map.put("word", word);
		map.put("proinventory_no", vo.getProinventory_no());
		
		List<Map<String, Object>> list = d1.selectProInven(map);
		
		if(list.isEmpty()) {
			list = null;
		}
		
		return list;
	}
	
	@RequestMapping("/d17/coList")
	public String coList(String comcode_code, Model model) {
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
		
		Map<String, Object> map = new HashMap<>();
		
		int comcode_no = ls.comNo(comcode_code);
		
		map.put("comcode_no", comcode_no);
		
		List<Map<String, Object>> list = d1.coList(map);
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "d/d1/d17/coList";
	}
	
	@RequestMapping("/d17/coListAjax")
	@ResponseBody
	public List<Map<String, Object>> coListAjax(String comcode_code, String type, String word) {
		Map<String, Object> map = new HashMap<>();
		
		int comcode_no = ls.comNo(comcode_code);
		
		map.put("comcode_no", comcode_no);
		map.put("type", type);
		map.put("word", word);
		
		List<Map<String, Object>> list = d1.coList(map);
		
		return list;
	}
	
	@RequestMapping("/d17/piListAjax")
	@ResponseBody
	public List<Map<String, Object>> piListAjax(String comcode_code, String type, String word) {
		Map<String, Object> map = new HashMap<>();
		
		int comcode_no = ls.comNo(comcode_code);
		
		map.put("comcode_no", comcode_no);
		map.put("type", type);
		map.put("word", word);
		
		List<Map<String, Object>> list = d1.proinvenList(map);
		
		return list;
	}
	
	@RequestMapping("/d17/createProinventory")
	@Transactional
	public String createProinventory(Erp_ProinventoryVO vo, String comcode_code, Model model, Erp_InvenlotVO ivo) {
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
		
		d1.createProInven(vo);
		
		List<Erp_InvenlotVO> crlist = ivo.getCrlist();
		
		for(Erp_InvenlotVO ilvo : crlist) {
			ilvo.setProinventory_no(d1.getProNo());
			d1.createInvenLot(ilvo);
		}
		
		return "redirect:/d/d1/d17/inputProinventory?comcode_code="+comcode_code;
	}
	
	@RequestMapping("/d17/update")
	@Transactional
	public String updateProinventory(Erp_ProinventoryVO vo, String comcode_code, Model model, Erp_InvenlotVO ivo) {
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
		
		d1.updateProInven(vo);
		
		List<Erp_InvenlotVO> crlist = ivo.getCrlist();
		List<Erp_InvenlotVO> crlist1 = ivo.getCrlist1();
		
		if(crlist != null) {
			for(Erp_InvenlotVO ilvo : crlist) {
				ilvo.setProinventory_no(vo.getProinventory_no());
				d1.createInvenLot(ilvo);
			}
		}
		
		if(crlist1 != null) {
			for(Erp_InvenlotVO ilvo : crlist1) {
				ilvo.setProinventory_no(vo.getProinventory_no());
				d1.updateInvenLot(ilvo);
			}
		}
		
		return "redirect:/d/d1/d17/updateForm?comcode_code="+comcode_code+"&proinventory_no="+vo.getProinventory_no();
	}
	
	@RequestMapping("/d17/delete")
	@Transactional
	public String deleteProinventory(Erp_ProinventoryVO vo, String comcode_code, Model model) {
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
		
		d1.deleteInvenPro(vo.getProinventory_no());
		
		d1.deleteProInven(vo.getProinventory_no());
		
		return "redirect:/d/d1/d17/inputProinventory?comcode_code="+comcode_code;
	}
	
	@RequestMapping("/d17/deleteGoods")
	@ResponseBody
	public List<Map<String, Object>> deleteGoods(Erp_InvenlotVO ivo, String type, String word) {
		d1.deleteInvenLot(ivo.getInvenlot_no());
		
		Map<String, Object> map = new HashMap<>();
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		map.put("type", type);
		map.put("word", word);
		map.put("proinventory_no", ivo.getProinventory_no());
		
		List<Map<String, Object>> list = d1.selectProInven(map);
		
		if(list.isEmpty()) {
			list = null;
		}
		
		return list;
	}
	
	@RequestMapping("/d17/goodsList")
	public String goodsList17(String type, String word, String comcode_code, Model model, String i) {
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
		
		map.put("comcode_no", comcode_no);
		map.put("btype", type);
		map.put("bnword", word);
		
		List<Map<String, Object>> list = d1.goodsListd17(map);
		
		model.addAttribute("list", list);
		model.addAttribute("i", i);
		
		return ViewPath.WINDOW + "d/d1/d17/goodsList";
	}
	@RequestMapping("/d17/goodsList1")
	public String goodsList117(String type, String word, String comcode_code, Model model, String i) {
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
		
		map.put("comcode_no", comcode_no);
		map.put("btype", type);
		map.put("bnword", word);
		
		List<Map<String, Object>> list = d1.goodsListd17(map);
		
		model.addAttribute("list", list);
		model.addAttribute("i", i);
		
		return ViewPath.WINDOW + "d/d1/d17/goodsList1";
	}
	
	@RequestMapping("/d17/goodsList17ajax")
	@ResponseBody
	public List<Map<String, Object>> goodsList17ajax(String type, String word, String comcode_code) {
		int comcode_no = ls.comNo(comcode_code);
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("comcode_no", comcode_no);
		map.put("type", type);
		map.put("word", word);
		
		List<Map<String, Object>> list = d1.goodsListd17(map);
		
		return list;
	}
	
	@RequestMapping("/d12/searchcl")
	@ResponseBody
	public Map<String, Object> searchcl(String client_name, String comcode_code) {
		try {
			Map<String, Object> map = new HashMap<>();
			
			int comcode_no = ls.comNo(comcode_code);
			
			map.put("comcode_no", comcode_no);
			map.put("client_name", client_name);
			
			Map<String, Object> vo = d1.searchcl(map);
			
			return vo;
		}catch(Exception e) {
			return null;
		}
	}
	
	@RequestMapping("/d12/searchcli")
	@ResponseBody
	public Map<String, Object> searchcli(String client_name, String comcode_code, String i) {
		try {
			Map<String, Object> map = new HashMap<>();
			
			int comcode_no = ls.comNo(comcode_code);
			
			map.put("comcode_no", comcode_no);
			map.put("client_name", client_name);
			
			request.setAttribute("i", i);
			
			Map<String, Object> vo = d1.searchcl(map);
			
			return vo;
		}catch(Exception e) {
			return null;
		}
	}
	
	@RequestMapping("/d12/searchecode")
	@ResponseBody
	public Map<String, Object> searchecode(String employee1_code) {
		try {
			
			Map<String, Object> vo = d1.searchecode(employee1_code);
			
			return vo;
		}catch(Exception e) {
			return null;
		}
	}
	
	@RequestMapping("/d12/clList")
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
		
		return ViewPath.WINDOW + "d/d1/d12/clList";
	}
	
	@RequestMapping("/d12/clListAjax")
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
		
		List<Map<String, Object>> list = a4.clientList(map);
		
		return list;
	}
	
	@RequestMapping(value="/d12/getRequestCode", produces = "application/text;charset=utf8")
	@ResponseBody
	public String getRequestCode(String requestproduct_code) {
		try {
			if(requestproduct_code == "") {
				return "공백은 허용되지 않습니다";
			}
			int code = d1.getRequestProductNo(requestproduct_code);
			
			return "이미 존재하는 코드입니다.";
		}catch(NullPointerException e) {
			return "사용 가능한 코드입니다.";
		}
	}
	
	
//	bom
	@RequestMapping("/d18/inputBom")
	public String inputBom(Model model, String type, String word, String comcode_code) {
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
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		map.put("goodssort_name1", "상품");
		map.put("goodssort_name2", "반제품");
		
		List<Map<String, Object>> list = d1.itemList(map);
		
		model.addAttribute("list", list);
		
		return ViewPath.D1 + "/d18/inputBom";
	}
	
	@RequestMapping("/d18/bomAjax")
	@ResponseBody
	public List<Map<String, Object>> bomAjax(String type, String word, Erp_GoodsVO vo) {
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("goods_no", vo.getGoods_no());
		
		List<Map<String, Object>> blist = d1.bomList(map);
		
		if(blist.isEmpty()) {
			blist = null;
		}
		
		return blist;
	}
	
	@RequestMapping("/d18/addForm")
	public String addBom(String comcode_code, Model model) {
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
		
		return ViewPath.D1 + "/d18/selectForm";
	}
	
	@RequestMapping("/d18/updateForm")
	public String updateFormBom(Erp_GoodsVO vo, Model model, String type, String word, String comcode_code) {
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
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("goods_no", vo.getGoods_no());
		
		Map<String, Object> inmap = d1.selectItem(vo.getGoods_no());
		
		List<Map<String, Object>> blist = d1.bomList(map);
		if(blist.isEmpty()) {
			blist = null;
		}
		
		model.addAttribute("inmap", inmap);
		model.addAttribute("blist", blist);
		
		return ViewPath.D1 + "/d18/selectForm";
	}
	
	@RequestMapping("/d18/createBom")
	@Transactional
	public String createBom(Erp_BomVO vo, String comcode_code, Model model, String goods_no) {
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
		
		List<Erp_BomVO> blist = vo.getBlist();
		
		if(blist != null) {
			for(Erp_BomVO bvo : blist) {
				bvo.setComcode_no(comcode_no);
				bvo.setGoods_no1(Integer.parseInt(goods_no));
				
				d1.createBom(bvo);
			}
		}
		
		return "redirect:/d/d1/d18/inputBom?comcode_code="+comcode_code;
	}
	
	@RequestMapping("/d18/update")
	@Transactional
	public String updateBom(Erp_BomVO vo, String comcode_code, Model model, String goods_no) {
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
		
		List<Erp_BomVO> blist = vo.getBlist();
		List<Erp_BomVO> blist1 = vo.getBlist1();
		
		if(blist != null) {
			for(Erp_BomVO bvo : blist) {
				bvo.setComcode_no(comcode_no);
				bvo.setGoods_no1(Integer.parseInt(goods_no));
				
				d1.createBom(bvo);
			}
		}
		
		if(blist1 != null) {
			for(Erp_BomVO bvo : blist1) {
				d1.updateBom(bvo);
			}
		}
		
		return "redirect:/d/d1/d18/updateForm?comcode_code="+comcode_code+"&goods_no="+Integer.parseInt(goods_no);
	}
	
	@RequestMapping("/d18/deleteBom")
	@ResponseBody
	@Transactional
	public List<Map<String, Object>> deleteBom(Erp_BomVO vo, Erp_GoodsVO gvo, String type, String word) {
		d1.deleteBom(vo.getBom_no());
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("goods_no", gvo.getGoods_no());
		
		List<Map<String, Object>> blist = d1.bomList(map);
		
		return blist;
	}
	
	@RequestMapping("/d18/itemList")
	public String itemList(Model model, String comcode_code) {
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
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", null);
		map.put("word", null);
		map.put("comcode_no", comcode_no);
		map.put("goodssort_name1", "상품");
		map.put("goodssort_name2", "반제품");
		
		List<Map<String, Object>> list = d1.itemList(map);
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "d/d1/d18/itemList";
	}
	
	@RequestMapping("/d18/itemListAjax")
	@ResponseBody
	public List<Map<String, Object>> itemListAjax(String comcode_code, String type, String word) {
		
		int comcode_no = ls.comNo(comcode_code);
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		map.put("goodssort_name1", "원자재");
		map.put("goodssort_name2", "부자재");
		
		List<Map<String, Object>> list = d1.itemList(map);
		
		return list;
	}
	
	@RequestMapping("/d18/itemListAjaxF")
	@ResponseBody
	public List<Map<String, Object>> itemListAjaxF(String comcode_code, String type, String word) {
		System.out.println(comcode_code);
		
		int comcode_no = ls.comNo(comcode_code);
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		System.out.println(type);
		System.out.println(word);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		map.put("goodssort_name1", "상품");
		map.put("goodssort_name2", "반제품");
		
		List<Map<String, Object>> list = d1.itemList(map);
		
		return list;
	}
	
	@RequestMapping("/d18/goodsList")
	public String goodsListd18(String type, String word, String comcode_code, Model model, String i) {
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
		map.put("goodssort_name1", "원자재");
		map.put("goodssort_name2", "부자재");
		
		List<Map<String, Object>> list = d1.itemList(map);
		
		model.addAttribute("list", list);
		model.addAttribute("i", i);
		
		return ViewPath.WINDOW + "d/d1/d18/goodsList";
	}
	@RequestMapping("/d18/goodsList1")
	public String goodsListd181(String type, String word, String comcode_code, Model model, String i) {
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
		map.put("goodssort_name1", "원자재");
		map.put("goodssort_name2", "부자재");
		
		List<Map<String, Object>> list = d1.itemList(map);
		
		model.addAttribute("list", list);
		model.addAttribute("i", i);
		
		return ViewPath.WINDOW + "d/d1/d18/goodsList1";
	}
	
	@RequestMapping("/d18/goodsListAjax")
	public List<Map<String, Object>> itemListAjaxd18(String type, String word, String comcode_code) {
		
		int comcode_no = ls.comNo(comcode_code);
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		map.put("goodssort_name1", "원자재");
		map.put("goodssort_name2", "부자재");
		
		List<Map<String, Object>> list = d1.itemList(map);
		
		return list;
	}
	
}
