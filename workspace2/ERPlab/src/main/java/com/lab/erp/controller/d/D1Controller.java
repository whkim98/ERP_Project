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
import org.springframework.web.bind.annotation.ResponseBody;

import com.lab.erp.common.ViewPath;
import com.lab.erp.service.a.A4Service;
import com.lab.erp.service.d.D1Service;
import com.lab.erp.service.login.LoginService;
import com.lab.erp.vo.b.b1.Erp_Bs3VO;
import com.lab.erp.vo.b.b1.Erp_ClosingVO;
import com.lab.erp.vo.c.Erp_ClientVO;
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
	
	@Autowired
	public D1Controller(LoginService ls, D1Service d1, HttpServletRequest request, A4Service a4) {
		this.ls = ls;
		this.d1 = d1;
		this.request = request;
		this.a4 = a4;
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
		
		for(Erp_ConnectrequestVO crvo : cvo) {
			d1.updateConnectRequest(crvo);
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
	
	
//	작업지시서 ped
	@RequestMapping("/d13/inputPed")
	public String inputPed(String type, String word, String comcode_code, Model model) {
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
		
		List<Map<String, Object>> list = d1.pedList(map);
		List<Map<String, Object>> sortkind = d1.sortkind();
		
		model.addAttribute("sortkind", sortkind);
		model.addAttribute("list", list);
		
		return ViewPath.D1 + "/d13/inputPed";
	}
	
	@RequestMapping("/d13/addPed")
	public String addPed(Model model, String comcode_code, Erp_RequestproductVO vo) {
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
		List<Map<String, Object>> glist = d1.selectRequestGoods(vo.getRequestproduct_no());
		List<Erp_WorktypeVO> wlist = d1.workTypeList();
		
		model.addAttribute("requestproduct_no", vo.getRequestproduct_no());
		model.addAttribute("wlist", wlist);
		model.addAttribute("sortkind", sortkind);
		model.addAttribute("glist" ,glist);
		
		return ViewPath.D1 + "/d13/test";
	}
	
	@RequestMapping("/d13/updateForm")
	public String updateFormPed(String comcode_code, Erp_PedVO vo, String type, String word, Model model) {
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
		
		List<Map<String, Object>> list = d1.pedList(map);
		Map<String, Object> inmap = d1.selectPed(vo.getPed_no());
		List<Map<String, Object>> plist = d1.selectPedGoods(vo.getPed_no());
		List<Map<String, Object>> glist = d1.selectRequestGoods(vo.getRequestproduct_no());
		List<Map<String, Object>> sortkind = d1.sortkind();
		List<Erp_WorktypeVO> wlist = d1.workTypeList();
		
		model.addAttribute("wlist", wlist);
		model.addAttribute("sortkind", sortkind);
		model.addAttribute("glist", glist);
		model.addAttribute("list", list);
		model.addAttribute("inmap", inmap);
		model.addAttribute("plist", plist);
		
		return ViewPath.D1 + "/d13/test";
	}
	
	@RequestMapping("/d13/createPed")
	@Transactional
	public String createPed(Erp_PedVO vo, String comcode_code, Model model, Erp_WorktypeVO wlist, Erp_ConnectrequestVO crlist1, Erp_ConnectrequestVO crlist) {
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
		
		d1.createPed(vo);
		
		Erp_PedworkVO pvo = new Erp_PedworkVO();
		
		List<Erp_PedworkVO> pwlist = pvo.getPwlist();
		
		List<Erp_WorktypeVO> wtlist = wlist.getWlist();
		for(int i = 0; i < wtlist.size(); i++) {
			pwlist.get(i).setWorktype_no(wtlist.get(i).getWorktype_no());
		}
		
		if(crlist1 != null) {
			List<Erp_ConnectrequestVO> cvo1 = crlist1.getCrlist1();
			for(Erp_ConnectrequestVO crvo : cvo1) {
				d1.createConnectRequest(crvo);
			}
		}
		
		List<Map<String, Object>> glist = d1.selectRequestGoods(vo.getRequestproduct_no());
		for(int i = 0; i < glist.size(); i++) {
			pwlist.get(i).setConnectrequest_no((int)glist.get(i).get("connectrequest_no"));
			pwlist.get(i).setPed_no(d1.getPedNo(vo));
			d1.createPedWork(pwlist.get(i));
		}
		
		return "redirect:/d/d1/d13/inputPed?comcode_code="+comcode_code;
	}
	
	@RequestMapping("/d13/update")
	@Transactional
	public String updatePed(Erp_PedVO vo, String comcode_code, Model model, Erp_WorktypeVO wlist, Erp_ConnectrequestVO crlist1, Erp_ConnectrequestVO crlist, Erp_PedworkVO pvo) {
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
		
		d1.updatePed(vo);
		
		List<Erp_PedworkVO> pwlist = pvo.getPwlist();
		
		List<Erp_ConnectrequestVO> cvo = crlist.getCrlist();
		for(Erp_ConnectrequestVO crvo : cvo) {
			d1.updateConnectRequest(crvo);
		}
		
		if(crlist1 != null) {
			List<Erp_ConnectrequestVO> cvo1 = crlist1.getCrlist1();
			for(Erp_ConnectrequestVO crvo : cvo1) {
				d1.createConnectRequest(crvo);
			}
		}
		
		for(Erp_PedworkVO pp : pwlist) {
			d1.updatePedWork(pp);
		}
		
		return "redirect:/d/d1/d13/updateForm?comcode_code="+comcode_code+"&requestproduct_no="+vo.getRequestproduct_no()+"&ped_no="+vo.getPed_no();
	}
	
	@RequestMapping("/d13/delete")
	@Transactional
	public String deletePed(Erp_PedVO vo, String comcode_code, Model model) {
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
		
		d1.deletePed(vo.getPed_no());
		
		d1.deletePedWorkNo(vo.getPed_no());
		
		return "redirect:/d/d1/d13/inputPed?comcode_code="+comcode_code;
	}
	
	
//	생산 / 제조 
	@RequestMapping("/d11/inputProduct")
	public String inputProduct(String comcode_code, String type, String word, Model model) {
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
		
		
		return "redirect:/d/d1/d11/inputProduct?comcode_code"+comcode_code;
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
		
		d1.deleteProduct(vo.getProduct_no());
		
		int cno = d1.getClosingNo(vo.getProduct_code());
		
		d1.deleteClosing(cno);
		
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
	
//	@RequestMapping("/d/d11/inputGoods")
//	public String inputGoods() {
//		
//	}
	
	
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
		
		List<Map<String, Object>> list = d1.evaluationList(map);
		List<Map<String, Object>> glist = d1.selectEvGoods(vo.getEvaluation_no());
		Map<String, Object> inmap = d1.selectEvaluation(vo.getEvaluation_no());
		
		model.addAttribute("list", list);
		model.addAttribute("glist", glist);
		model.addAttribute("inmap", inmap);
		
		return "/d14/inputEvaluation";
	}
	
	@RequestMapping("/d14/createEvaluation")
	public String createEvaluation(Erp_EvaluationVO vo, String comcode_code, Model model, 
			String[] lotconnev_qty, String[] lotconnev_rest, String[] goodslot_no) {
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
		
		d1.createEvaluation(vo);
		
		for(int i = 0; i < goodslot_no.length; i++) {
			Erp_LotconnevVO lvo = new Erp_LotconnevVO();
			
			lvo.setEvaluation_no(vo.getEvaluation_no());
			lvo.setGoodslot_no(Integer.parseInt(goodslot_no[i]));
			lvo.setLotconnev_qty(Integer.parseInt(lotconnev_qty[i]));
			lvo.setLotconnev_rest(Integer.parseInt(lotconnev_rest[i]));
			
			d1.createLotEv(lvo);
		}
		
		return "redirect:/d/d14/inputEvaluation?comcode_code="+comcode_code;
	}
	
	@RequestMapping("/d14/update")
	public String updateEvaluation(Erp_EvaluationVO vo, String comcode_code, Model model, 
			String[] lotconnev_qty, String[] lotconnev_rest, String[] goodslot_no, String[] lotconnev_no) {
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
		
		for(int i = 0; i < goodslot_no.length; i++) {
			Erp_LotconnevVO lvo = new Erp_LotconnevVO();
			
			lvo.setLotconnev_no(Integer.parseInt(lotconnev_no[i]));
			lvo.setEvaluation_no(vo.getEvaluation_no());
			lvo.setGoodslot_no(Integer.parseInt(goodslot_no[i]));
			lvo.setLotconnev_qty(Integer.parseInt(lotconnev_qty[i]));
			lvo.setLotconnev_rest(Integer.parseInt(lotconnev_rest[i]));
			
			d1.updateLotEv(lvo);
		}
		
		return "redirect:/d/d14/updateForm?comcode_code="+comcode_code+"&evaluation_no="+vo.getEvaluation_no();
	}
	
	@RequestMapping("/d14/delete")
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
		
		d1.deleteEvaluation(vo.getEvaluation_no());
		
		d1.deleteLotEvNo(vo.getEvaluation_no());
		
		return "redirect:/d/d14/inputEvaluation?comcode_code="+comcode_code;
	}
	
	
//	불량 분석
	@RequestMapping("/d16/inputDefective")
	public String inputDefective(String comcode_code, String type, String word, Model model) {
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
		
		return ViewPath.D1 + "/d16/inputDefective";
	}
	
	@RequestMapping("/d16/updateForm")
	public String updateFormDF(String comcode_code, String type, String word, Model model, Erp_DefectiveVO vo) {
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
		Map<String, Object> inmap = d1.selectDefective(vo.getDefactive_no());
		
		model.addAttribute("list", list);
		model.addAttribute("inmap", inmap);
		
		return ViewPath.D1 + "/d16/inputDefective";
	}
	
	@RequestMapping("/d16/createDefective")
	public String createDefective(String comcode_code, Model model, Erp_DefectiveVO vo) {
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
		
		d1.createDefective(vo);
		
		return "redirect:/d/d1/d16/inputDefective?comcode_code="+comcode_code;
	}
	
	@RequestMapping("/d16/update")
	public String updateDefective(String comcode_code, Model model, Erp_DefectiveVO vo) {
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
		
		d1.updateDefective(vo);
		
		return "redirect:/d/d1/d16/updateForm?comcode_code="+comcode_code+"&defective_no="+vo.getDefactive_no();
	}
	
	@RequestMapping("/d16/delete")
	public String deleteDefective(String comcode_code, Model model, Erp_DefectiveVO vo) {
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
		
		d1.deleteDefective(vo.getDefactive_no());
		
		return "redirect:/d/d1/d16/inputDefective?comcode_code="+comcode_code;
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
		
		model.addAttribute("list", list);
		
		return ViewPath.D1 + "/d15/inputEvaluemng";
	}
	
	@RequestMapping("/d15/updateForm")
	public String updateFormMG(String comcode_code, String type, String word, Model model, Erp_EvaluemngVO vo) {
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
		Map<String, Object> inmap = d1.selectEvaluation(vo.getEvaluation_no());
		
		model.addAttribute("list", list);
		model.addAttribute("inmap", inmap);
		
		return ViewPath.D1 + "/d15/inputEvaluemng";
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
		
		return "redirect:/d/d1/d15/updateForm?comcode_code="+comcode_code+"&evaluation_no="+vo.getEvaluation_no();
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
		
		List<Map<String, Object>> list = d1.proinvenList(map);
		Map<String, Object> inmap = d1.selectPro(vo.getProinventory_no());
		
		model.addAttribute("list", list);
		model.addAttribute("inmap", inmap);
		
		return ViewPath.D1 + "/d17/inputProinventory";
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
	
	@RequestMapping("/d17/createProinventory")
	public String createProinventory(Erp_ProinventoryVO vo, String comcode_code, Model model) {
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
		
		return "redirect:/d/d1/d17/inputProinventory?comcode_code="+comcode_code;
	}
	
	@RequestMapping("/d17/update")
	public String updateProinventory(Erp_ProinventoryVO vo, String comcode_code, Model model) {
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
		
		return "redirect:/d/d1/d17/updateForm?comcode_code="+comcode_code+"&proinventory_no="+vo.getProinventory_no();
	}
	
	@RequestMapping("/d17/delete")
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
	
	@RequestMapping("/d17/inputGoods")
	public String inputGoods(Model model, String type, String word, Erp_ProinventoryVO vo) {
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("proinventory_no", vo.getProinventory_no());
		
		List<Map<String, Object>> list = d1.selectProInven(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		List<Map<String, Object>> sortkind = d1.sortkind();
		List<Erp_GoodslevVO> goodslev = d1.goodslev();
		
		model.addAttribute("list", list);
		model.addAttribute("sortkind", sortkind);
		model.addAttribute("goodslev", goodslev);
		
		return ViewPath.D1 + "/d17/inputGoods";
	}
	
	@RequestMapping("/d17/updateFormGoods")
	public String updateFormGoods(Erp_GoodslotVO glvo, Model model, String type, String word, Erp_ProinventoryVO vo) {
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("proinventory_no", vo.getProinventory_no());
		
		List<Map<String, Object>> list = d1.selectProInven(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		Map<String, Object> inmap = d1.selectProinventoryGoods(glvo.getGoodslot_no());
		
		List<Map<String, Object>> sortkind = d1.sortkind();
		List<Erp_GoodslevVO> goodslev = d1.goodslev();
		
		model.addAttribute("list", list);
		model.addAttribute("sortkind", sortkind);
		model.addAttribute("goodslev", goodslev);
		model.addAttribute("inmap", inmap);
		
		return ViewPath.D1 + "/d17/inputGoods";
	}
	
	@RequestMapping("/d17/createGoods")
	@Transactional
	public String createGoods(Erp_GoodslotVO glvo, Erp_GoodsstVO gtvo, 
			Erp_GoodsVO gvo, String comcode_code, Model model, Erp_InvenlotVO ivo) {
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
		
		gvo.setComcode_no(comcode_no);
		
		d1.createGoodsst(gtvo);
		
		int goodsstno = d1.goodsstno(gtvo);
		
		gvo.setGoodsst_no(goodsstno);
		
		d1.createGoods(gvo);
		
		int goodsno = d1.goodsno(gvo.getGoods_code());
		
		glvo.setGoods_no(goodsno);
		
		d1.createGoodsLot(glvo);
		
		ivo.setGoodslot_no(d1.goodslotno(glvo));
		
		d1.createInvenLot(ivo);
		
		return "redirect:/d/d1/d17/inputGoods?comcode_code="+comcode_code;
	}
	
	@RequestMapping("/d17/updateGoods")
	@Transactional
	public String updateGoods(Erp_GoodslotVO glvo, Erp_GoodsstVO gtvo, 
			Erp_GoodsVO gvo, String comcode_code, Model model, Erp_InvenlotVO ivo) {
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
		
		d1.updateGoods(gvo);
		d1.updateGoodsLot(glvo);
		d1.updateGoodsst(gtvo);
		d1.updateInvenLot(ivo);
		
		return "redirect:/d/d1/d17/updateFormGoods?comcode_code="+comcode_code;
	}
	
	@RequestMapping("/d17/deleteGoods")
	@Transactional
	public String deleteGoods(Erp_GoodslotVO glvo, Erp_GoodsstVO gtvo, 
			Erp_GoodsVO gvo, String comcode_code, Model model, Erp_InvenlotVO ivo) {
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
		
		d1.deleteGoodsLot(glvo.getGoodslot_no());
		d1.deleteGoods(gvo.getGoods_no());
		d1.deleteGoodsst(gtvo.getGoodsst_no());
		d1.deleteInvenLot(ivo.getInvenlot_no());
		
		return "redirect:/d/d1/d17/inputGoods?comcode_code="+comcode_code+"&proinventory_no="+ivo.getProinventory_no();
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
	@RequestMapping("/d12/clList1")
	public String clList1(String comcode_code, Model model, String type, String word, String i) {
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
		model.addAttribute("i",i);
		
		return ViewPath.WINDOW + "d/d1/d12/clList1";
	}
	@RequestMapping("/d12/clList2")
	public String clList2(String comcode_code, Model model, String type, String word, String i) {
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
		model.addAttribute("i",i);
		
		return ViewPath.WINDOW + "d/d1/d12/clList2";
	}
	@RequestMapping("/d12/clList3")
	public String clList3(String comcode_code, Model model, String type, String word, String i) {
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
		model.addAttribute("i",i);
		
		return ViewPath.WINDOW + "d/d1/d12/clList3";
	}
	@RequestMapping("/d12/clList4")
	public String clList4(String comcode_code, Model model, String type, String word, String i) {
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
		model.addAttribute("i",i);
		
		return ViewPath.WINDOW + "d/d1/d12/clList4";
	}
	
	@RequestMapping("/d12/getRequestCode")
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
	
}
