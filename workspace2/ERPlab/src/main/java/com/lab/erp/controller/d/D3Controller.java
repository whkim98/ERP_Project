package com.lab.erp.controller.d;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lab.erp.common.ViewPath;
import com.lab.erp.service.a.A3Service;
import com.lab.erp.service.c.C2Service;
import com.lab.erp.service.d.D1Service;
import com.lab.erp.service.d.D2Service;
import com.lab.erp.service.login.LoginService;
import com.lab.erp.vo.b.b1.Erp_Bs3VO;
import com.lab.erp.vo.b.b1.Erp_ClosingVO;
import com.lab.erp.vo.d.d2.Erp_InvenconnectVO;
import com.lab.erp.vo.d.d2.Erp_InventoryVO;
import com.lab.erp.vo.d.d2.Erp_OrderVO;
import com.lab.erp.vo.d.d2.Erp_OrderconnectVO;
import com.lab.erp.vo.d.d2.Erp_ProducttestVO;
import com.lab.erp.vo.d.d2.Erp_PtkindVO;
import com.lab.erp.vo.d.d2.Erp_PurchaseVO;
import com.lab.erp.vo.d.d2.Erp_PurchaseconnectVO;
import com.lab.erp.vo.d.d6.Erp_GoodsVO;
import com.lab.erp.vo.d.d6.Erp_GoodslotVO;
import com.lab.erp.vo.login.Erp_TeamVO;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("d/d3")
public class D3Controller {
	private D2Service d2;
	private D1Service d1;
	private HttpServletRequest request;
	private LoginService ls;
	private C2Service c2;
	private A3Service a3;
	
	public D3Controller(D2Service d2, HttpServletRequest request, LoginService ls, D1Service d1, C2Service c2, A3Service a3) {
		this.d2 = d2;
		this.request = request;
		this.ls = ls;
		this.d1 = d1;
		this.c2 = c2;
		this.a3 = a3;
	}
	
	
//	Order
	@RequestMapping("/d31/inputOrder")
	public String inputOrder(String comcode_code, String type, String word, Model model) {
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
		map.put("order_type", 0);
		
		List<Map<String, Object>> list = d2.orderList(map);
		
		model.addAttribute("list", list);
		
		return ViewPath.D3 + "/d31/inputOrder";
	}
	
	@RequestMapping("/d31/inputOrderAjax")
	@ResponseBody
	public List<Map<String, Object>> inputOrderAjax(String type, String word, String comcode_code) {
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		map.put("order_type", 0);
		
		List<Map<String, Object>> list = d2.orderList(map);
		
		return list;
	}
	
	@RequestMapping("/d31/updateForm")
	public String updateFormO(Erp_OrderVO ovo, Model model) {
		Map<String, Object> inmap = d2.selectOrder(ovo.getOrder_no());
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("goodssort_name1", "상품");
		map.put("goodssort_name2", "반제품");
		map.put("order_no", ovo.getOrder_no());
		
		List<Map<String, Object>> list = d2.selectOrderGoods(map);
		List<Erp_Bs3VO> dlist = d2.ctgrDebtor(54);
		List<Erp_Bs3VO> clist = d2.ctgrCreditor(54);
		Map<String, Object> cmap = d2.getClosingCode(ovo.getOrder_code());
		Map<String, Object> cl = c2.selectClientb4((int)inmap.get("client_no"));
		
		model.addAttribute("dlist", dlist);
		model.addAttribute("clist", clist);
		model.addAttribute("cmap", cmap);
		model.addAttribute("inmap", inmap);
		model.addAttribute("list", list);
		model.addAttribute("cl", cl);
		
		return ViewPath.D3 + "/d31/selectForm";
	}
	
	@RequestMapping("/d31/addForm")
	public String addOrder(Model model, String comcode_code) {
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
		
		List<Erp_Bs3VO> dlist = d2.ctgrDebtor(54);
		List<Erp_Bs3VO> clist = d2.ctgrCreditor(54);
		
		model.addAttribute("dlist", dlist);
		model.addAttribute("clist", clist);
		
		return ViewPath.D3 + "/d31/selectForm";
	}
	
	@RequestMapping("/d31/createOrder")
	@Transactional
	public String createOrder(Erp_OrderVO vo, String comcode_code, Erp_OrderconnectVO ovo, Model model, 
			String debtor_no, String creditor_no, String bs3_no1, String bs3_no2) {
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
		
		List<Erp_OrderconnectVO> oclist = ovo.getOclist();
		int sum = 0;
		
		for(Erp_OrderconnectVO ocvo : oclist) {
			sum += ocvo.getOrderconnect_price() * ocvo.getOrderconnect_qty();
		}
		
		double tax = sum * 0.1;
		int total = sum + (int)tax;
		
		vo.setOrder_price(sum);
		vo.setOrder_tax((int)tax);
		vo.setOrder_total(total);
		vo.setComcode_no(comcode_no);
		vo.setCtgr_no(54);
		
		d2.createOrder(vo);
		
		int ono = d2.getOrderNo(vo.getOrder_code());
		
		for(Erp_OrderconnectVO ocvo : oclist) {
			ocvo.setOrder_no(ono);
			d2.createOrderConnect(ocvo);
		}
		
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
		cvo.setClosing_code(vo.getOrder_code());
		cvo.setClosing_debtor(total);
		cvo.setClosing_creditor(total);
		cvo.setComcode_no(comcode_no);
		cvo.setDebtor_no(debtno);
		cvo.setCreditor_no(creditno);
		cvo.setCtgr_no(54);
		
		d2.createClosing(cvo);
		
		Map<String, Object> map = new HashMap<>();
		Map<String, Object> dmap = d2.getBsNo(b1);
		Map<String, Object> cmap = d2.getBsNo(b2);
		
		map.put("bs3_amount", total);
		map.put("bs1_no", dmap.get("bs1_no"));
		map.put("bs2_no", dmap.get("bsno2"));
		map.put("bs3_no", dmap.get("bs3_no"));
		
		d2.updateBs1Amount(map);
		d2.updateBs2Amount(map);
		d2.updateBs3Amount(map);
		
		map.put("bs3_amount", (-total));
		map.put("bs1_no", cmap.get("bs1_no"));
		map.put("bs2_no", cmap.get("bsno2"));
		map.put("bs3_no", cmap.get("bs3_no"));
		
		d2.updateBs1Amount(map);
		d2.updateBs2Amount(map);
		d2.updateBs3Amount(map);
		
		return "redirect:/d/d3/d31/updateForm?order_no="+ono+"&order_code="+vo.getOrder_code();
	}
	
	@RequestMapping("/d31/update")
	@Transactional
	public String updateOrder(Erp_OrderVO vo, Erp_OrderconnectVO ovo, Model model, 
			String debtor_no, String creditor_no, String bs3_no11, String bs3_no21, String bs3_no12, String bs3_no22) {
		Map<String, Object> inmap = d2.selectOrder(vo.getOrder_no());
		
		List<Erp_OrderconnectVO> oclist = ovo.getOclist();
		List<Erp_OrderconnectVO> oclist1 = ovo.getOclist1();
		int sum = 0;
		
		if(oclist1 != null) {
			for(Erp_OrderconnectVO ocvo : oclist1) {
				sum += ocvo.getOrderconnect_price() * ocvo.getOrderconnect_qty();
				ocvo.setOrder_no(vo.getOrder_no());
				d2.updateOrderConnect(ocvo);
			}
		}
		
		if(oclist != null) {
			for(Erp_OrderconnectVO ocvo : oclist) {
				sum += ocvo.getOrderconnect_price() * ocvo.getOrderconnect_qty();
				ocvo.setOrder_no(vo.getOrder_no());
				d2.createOrderConnect(ocvo);
			}
		}
		
		vo.setOrder_price(sum);
		double tax = sum * 0.1;
		
		vo.setOrder_tax((int)tax);
		int total = sum + (int)tax;
		
		vo.setOrder_total(total);
		
		d2.updateOrder(vo);
		
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
		
		int cno = d2.getClosingNo(vo.getOrder_code());
		
		Erp_ClosingVO cvo = new Erp_ClosingVO();
		
		cvo.setClosing_code(vo.getOrder_code());
		cvo.setClosing_debtor(total);
		cvo.setClosing_creditor(total);
		cvo.setDebtor_no(debtno);
		cvo.setCreditor_no(creditno);
		cvo.setClosing_no(cno);
		
		d2.updateClosing(cvo);
		
		Map<String, Object> map = new HashMap<>();
		Map<String, Object> dmap = d2.getBsNo(b11);
		Map<String, Object> cmap = d2.getBsNo(b21);
		
		
		map.put("bs3_amount", (-(int)inmap.get("order_total")));
		map.put("bs1_no", dmap.get("bs1_no"));
		map.put("bs2_no", dmap.get("bsno2"));
		map.put("bs3_no", dmap.get("bs3_no"));
		
		d2.updateBs1Amount(map);
		d2.updateBs2Amount(map);
		d2.updateBs3Amount(map);
		
		map.put("bs3_amount", (int)inmap.get("order_total"));
		map.put("bs1_no", cmap.get("bs1_no"));
		map.put("bs2_no", cmap.get("bsno2"));
		map.put("bs3_no", cmap.get("bs3_no"));
		
		d2.updateBs1Amount(map);
		d2.updateBs2Amount(map);
		d2.updateBs3Amount(map);
		
		
		dmap = d2.getBsNo(b12);
		cmap = d2.getBsNo(b22);
		
		map.put("bs3_amount", total);
		map.put("bs1_no", dmap.get("bs1_no"));
		map.put("bs2_no", dmap.get("bsno2"));
		map.put("bs3_no", dmap.get("bs3_no"));
		
		d2.updateBs1Amount(map);
		d2.updateBs2Amount(map);
		d2.updateBs3Amount(map);
		
		map.put("bs3_amount", (-total));
		map.put("bs1_no", cmap.get("bs1_no"));
		map.put("bs2_no", cmap.get("bsno2"));
		map.put("bs3_no", cmap.get("bs3_no"));
		
		d2.updateBs1Amount(map);
		d2.updateBs2Amount(map);
		d2.updateBs3Amount(map);
		
		return "redirect:/d/d3/d31/updateForm?order_no="+vo.getOrder_no()+"&order_code="+vo.getOrder_code();
	}
	
	@RequestMapping("/d31/delete")
	@Transactional
	public String deleteOrder(Erp_OrderVO vo, String comcode_code, Model model, String bs3_no1, String bs3_no2) {
		Map<String, Object> inmap = d2.selectOrder(vo.getOrder_no());
		
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
		
		Map<String, Object> map = new HashMap<>();
		Map<String, Object> dmap = d2.getBsNo(b1);
		Map<String, Object> cmap = d2.getBsNo(b2);
		
		
		map.put("bs3_amount", (-(int)inmap.get("order_total")));
		map.put("bs1_no", dmap.get("bs1_no"));
		map.put("bs2_no", dmap.get("bsno2"));
		map.put("bs3_no", dmap.get("bs3_no"));
		
		d2.updateBs1Amount(map);
		d2.updateBs2Amount(map);
		d2.updateBs3Amount(map);
		
		map.put("bs3_amount", (int)inmap.get("order_total"));
		map.put("bs1_no", cmap.get("bs1_no"));
		map.put("bs2_no", cmap.get("bsno2"));
		map.put("bs3_no", cmap.get("bs3_no"));
		
		d2.updateBs1Amount(map);
		d2.updateBs2Amount(map);
		d2.updateBs3Amount(map);
		
		d2.deleteOrderConnectAll(vo.getOrder_no());
		
		int cno = d2.getClosingNo(vo.getOrder_code());
		
		d2.deleteClosing(cno);
		
		d2.deleteOrder(vo.getOrder_no());
		
		return "redirect:/d/d3/d31/inputOrder?comcode_code="+comcode_code;
	}
	
	@RequestMapping("/d31/deleteGoods")
	@ResponseBody
	public List<Map<String, Object>> deleteOrderGoods(Erp_OrderconnectVO vo, String order_code){
		String closing_code = order_code;
		
		Erp_OrderVO ovo = new Erp_OrderVO();
		
		int sum = vo.getOrderconnect_price() * vo.getOrderconnect_qty();
		
		double tax = sum * 0.1;
		
		int total = sum + (int)tax;
		
		ovo.setOrder_price(sum);
		ovo.setOrder_tax((int)tax);
		ovo.setOrder_total(total);
		ovo.setOrder_no(vo.getOrder_no());
		
		d2.updateOrderPrice(ovo);
		
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
		
		d2.deleteOrderConnect(vo.getOrderconnect_no());
		
		map.put("order_no", vo.getOrder_no());
		map.put("goodssort_name1", "상품");
		map.put("goodssort_name2", "반제품");
		
		List<Map<String, Object>> list = d2.selectOrderGoods(map);
		
		if(list.isEmpty()) {
			list = null;
		}
		
		return list;
	}
	
	@RequestMapping("/d31/coList")
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
		
		return ViewPath.WINDOW + "d/d2/d21/coList";
	}
	
	@RequestMapping("/d31/coListAjax")
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
	
	@RequestMapping("/d31/searchcl")
	@ResponseBody
	public Map<String, Object> searchcl(String client_name, String comcode_code) {
		try {
			Map<String, Object> map = new HashMap<>();
			
			int comcode_no = ls.comNo(comcode_code);
			
			map.put("comcode_no", comcode_no);
			map.put("client_name", client_name);
			
			Map<String, Object> vo = d2.searchcld2(map);
			
			return vo;
		}catch(Exception e) {
			return null;
		}
	}
	@RequestMapping("/d31/team")
	@ResponseBody
	public Erp_TeamVO team(String team_name) {
		try {
			Erp_TeamVO vo = a3.teamName(team_name);
			
			return vo;
		}catch(Exception e) {
			return null;
		}
	}
	
	@RequestMapping("/d31/clList")
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
		
		return ViewPath.WINDOW + "d/d2/d21/clList";
	}
	
	@RequestMapping("/d31/goodsList")
	public String goodsList(String btype, String bnword, String comcode_code, Model model, String i, String client_name) {
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
		
		map.put("client_name", client_name);
		map.put("goodssort_name1", "상품");
		map.put("goodssort_name2", "반제품");
		map.put("comcode_no", comcode_no);
		map.put("btype", btype);
		map.put("bnword", bnword);
		
		List<Map<String, Object>> list = d2.selectClient2Goods(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		model.addAttribute("list", list);
		model.addAttribute("i", i);
		model.addAttribute("client_name", client_name);
		
		return ViewPath.WINDOW + "d/d2/d21/goodsList";
	}
	@RequestMapping("/d31/goodsList1")
	public String goodsList1(String btype, String bnword, String comcode_code, Model model, String i, String client_name) {
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
		
		map.put("client_name", client_name);
		map.put("goodssort_name1", "상품");
		map.put("goodssort_name2", "반제품");
		map.put("comcode_no", comcode_no);
		map.put("btype", btype);
		map.put("bnword", bnword);
		
		List<Map<String, Object>> list = d2.selectClient2Goods(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		model.addAttribute("list", list);
		model.addAttribute("i", i);
		model.addAttribute("client_name", client_name);
		
		return ViewPath.WINDOW + "d/d2/d21/goodsList1";
	}
	
	@RequestMapping("/d31/goodsListAjax")
	@ResponseBody
	public List<Map<String, Object>> goodsListAjax(String btype, String bnword, String comcode_code, Model model, String client_name) {
		
		int comcode_no = ls.comNo(comcode_code);
		
		if(btype == null || bnword == null) {
			btype = null;
			bnword = null;
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("client_name", client_name);
		map.put("goodssort_name1", "상품");
		map.put("goodssort_name2", "반제품");
		map.put("comcode_no", comcode_no);
		map.put("btype", btype);
		map.put("bnword", bnword);
		
		List<Map<String, Object>> list = d2.selectClient2Goods(map);
		
		return list;
	}
	
	@RequestMapping(value="/d31/getOrderCode", produces = "application/text;charset=utf8")
	@ResponseBody
	public String getOrderCode(String order_code) {
		try {
			
			if(order_code == "") {
				return "공백은 허용되지 않습니다.";
			}
			
			int no = d2.getOrderNo(order_code);
			
			return "이미 존재하는 코드입니다.";
		}catch(Exception e) {
			return "사용 가능한 코드입니다.";
		}
	}
	
	
	
//	Purchase
	@RequestMapping("/d32/inputPurchase")
	public String inputPurchase(String comcode_code, String type, String word, Model model) {
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
		map.put("purchase_type", 0);
		
		List<Map<String, Object>> list = d2.purchaseList(map);
		
		model.addAttribute("list", list);
		
		return ViewPath.D3 + "/d32/inputPurchase";
	}
	
	@RequestMapping("/d32/inputPurchaseAjax")
	@ResponseBody
	public List<Map<String, Object>> inputPurchaseAjax(String comcode_code, String type, String word) {
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		map.put("purchase_type", 0);
		
		List<Map<String, Object>> list = d2.purchaseList(map);
		
		return list;
	}
	
	@RequestMapping("/d32/updateForm")
	public String updateFormPC(Erp_PurchaseVO vo, Model model) {
		List<Erp_Bs3VO> dlist = d2.ctgrDebtor(55);
		List<Erp_Bs3VO> clist = d2.ctgrCreditor(55);
		Map<String, Object> cmap = d2.getClosingCode(vo.getPurchase_code());
		Map<String, Object> inmap = d2.selectPurchase(vo.getPurchase_no());
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("goodssort_name1", "상품");
		map.put("goodssort_name2", "반제품");
		map.put("purchase_no", vo.getPurchase_no());
		
		List<Map<String, Object>> list = d2.selectPurchaseGoods(map);
		
		Map<String, Object> cl = c2.selectClientb4((int)inmap.get("client_no"));
		
		model.addAttribute("list", list);
		model.addAttribute("dlist", dlist);
		model.addAttribute("clist", clist);
		model.addAttribute("inmap", inmap);
		model.addAttribute("cmap", cmap);
		model.addAttribute("cl", cl);
		
		return ViewPath.D3 + "/d32/selectForm";
	}
	
	@RequestMapping("/d32/addForm")
	public String addPurchase(Model model) {
		List<Erp_Bs3VO> dlist = d2.ctgrDebtor(55);
		List<Erp_Bs3VO> clist = d2.ctgrCreditor(55);
		
		model.addAttribute("dlist", dlist);
		model.addAttribute("clist", clist);
		
		return ViewPath.D3 + "/d32/selectForm";
	}
	
	@RequestMapping("/d32/createPurchase")
	@Transactional
	public String createPurchase(Erp_PurchaseVO vo, Erp_PurchaseconnectVO pvo, String comcode_code, Model model, 
			String debtor_no, String creditor_no, String bs3_no1, String bs3_no2, String[] goods_no) {
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
		
		List<Erp_PurchaseconnectVO> plist = pvo.getPlist();
		
		int sum = 0;
		int i = 0;
		
		for(Erp_PurchaseconnectVO pcvo : plist) {
			sum += pcvo.getPurchaseconnect_price() * pcvo.getPurchaseconnect_number();
			Erp_GoodslotVO gl = new Erp_GoodslotVO();
			gl.setGoodslot_qty(pcvo.getPurchaseconnect_number());
			gl.setGoodslot_no(pcvo.getGoodslot_no());
			d2.updateLotQtyOne(gl);
			
			Erp_GoodsVO gvo = new Erp_GoodsVO();
			gvo.setGoods_no(Integer.parseInt(goods_no[i]));
			gvo.setGoods_stockqty(pcvo.getPurchaseconnect_number());
			d2.updateGoodsOne(gvo);
			i += 1;
		}
		
		
		double tax = sum * 0.1;
		int total = sum + (int)tax;
		
		vo.setPurchase_price(sum);
		vo.setPurchase_tax((int)tax);
		vo.setPurchase_total(total);
		vo.setComcode_no(comcode_no);
		vo.setCtgr_no(55);
		
		d2.createPurchase(vo);
		
		int pno = d2.getPurchaseNo(vo.getPurchase_code());
		
		for(Erp_PurchaseconnectVO pcvo : plist) {
			pcvo.setPurchase_no(pno);
			d2.createPurchaseConnect(pcvo);
		}
		
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
		cvo.setClosing_code(vo.getPurchase_code());
		cvo.setClosing_debtor(total);
		cvo.setClosing_creditor(total);
		cvo.setComcode_no(comcode_no);
		cvo.setDebtor_no(debtno);
		cvo.setCreditor_no(creditno);
		cvo.setCtgr_no(55);
		
		d2.createClosing(cvo);
		
		Map<String, Object> map = new HashMap<>();
		Map<String, Object> dmap = d2.getBsNo(b1);
		Map<String, Object> cmap = d2.getBsNo(b2);
		
		map.put("bs3_amount", total);
		map.put("bs1_no", dmap.get("bs1_no"));
		map.put("bs2_no", dmap.get("bsno2"));
		map.put("bs3_no", dmap.get("bs3_no"));
		
		d2.updateBs1Amount(map);
		d2.updateBs2Amount(map);
		d2.updateBs3Amount(map);
		
		map.put("bs3_amount", (-total));
		map.put("bs1_no", cmap.get("bs1_no"));
		map.put("bs2_no", cmap.get("bsno2"));
		map.put("bs3_no", cmap.get("bs3_no"));
		
		d2.updateBs1Amount(map);
		d2.updateBs2Amount(map);
		d2.updateBs3Amount(map);
		
		return "redirect:/d/d3/d32/updateForm?purchase_no="+pno+"&purchase_code="+vo.getPurchase_code();
	}
	
	@RequestMapping("/d32/update")
	@Transactional
	public String updatePurchase(String debtor_no, String creditor_no, String bs3_no11, String bs3_no21, String bs3_no12, String bs3_no22, 
			Erp_PurchaseVO vo, Erp_PurchaseconnectVO pvo, Model model, String[] goods_no) {
		int i = 0;
		
		Map<String, Object> inmap = d2.selectPurchase(vo.getPurchase_no());
		
		List<Erp_PurchaseconnectVO> plist = pvo.getPlist();
		List<Erp_PurchaseconnectVO> plist1 = pvo.getPlist1();
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("goodssort_name1", "상품");
		map.put("goodssort_name2", "반제품");
		map.put("purchase_no", vo.getPurchase_no());
		
		List<Map<String, Object>> sp = d2.selectPurchaseGoods(map);
		if(sp != null) {
			for(Map<String, Object> ss : sp) {
				Erp_GoodslotVO gl = new Erp_GoodslotVO();
				gl.setGoodslot_qty((int)ss.get("purchaseconnect_number"));
				gl.setGoodslot_no((int)ss.get("goodslot_no"));
				d2.updateLotQtySub(gl);
				
				Erp_GoodsVO gvo = new Erp_GoodsVO();
				gvo.setGoods_no(Integer.parseInt(goods_no[i]));
				gvo.setGoods_stockqty((int)ss.get("purchaseconnect_number"));
				d2.updateGoodsSub(gvo);
				i += 1;
			}
		}
		
		int sum = 0;
		
		i = 0;
		
		if(plist1 != null) {
			for(Erp_PurchaseconnectVO pcvo : plist1) {
				sum += pcvo.getPurchaseconnect_price() * pcvo.getPurchaseconnect_number();
				pcvo.setPurchase_no(vo.getPurchase_no());
				d2.updatePurchaseConnect(pcvo);
				Erp_GoodslotVO gl = new Erp_GoodslotVO();
				gl.setGoodslot_qty(pcvo.getPurchaseconnect_number());
				gl.setGoodslot_no(pcvo.getGoodslot_no());
				d2.updateLotQtyOne(gl);
				
				Erp_GoodsVO gvo = new Erp_GoodsVO();
				gvo.setGoods_no(Integer.parseInt(goods_no[i]));
				gvo.setGoods_stockqty(pcvo.getPurchaseconnect_number());
				d2.updateGoodsOne(gvo);
				i += 1;
			}
		}
		
		if(plist != null) {
			for(Erp_PurchaseconnectVO pcvo : plist) {
				sum += pcvo.getPurchaseconnect_price() * pcvo.getPurchaseconnect_number();
				pcvo.setPurchase_no(vo.getPurchase_no());
				d2.createPurchaseConnect(pcvo);
				Erp_GoodslotVO gl = new Erp_GoodslotVO();
				gl.setGoodslot_qty(pcvo.getPurchaseconnect_number());
				gl.setGoodslot_no(pcvo.getGoodslot_no());
				d2.updateLotQtyOne(gl);
				
				Erp_GoodsVO gvo = new Erp_GoodsVO();
				gvo.setGoods_no(Integer.parseInt(goods_no[i]));
				gvo.setGoods_stockqty(pcvo.getPurchaseconnect_number());
				d2.updateGoodsOne(gvo);
				i += 1;
			}
		}
		
		int creditno = 0;
		
		if(creditor_no == "") {
			creditno = 0;
		}else {
			creditno = Integer.parseInt(creditor_no);
		}
		
		double tax = sum * 0.1;
		int total = sum + (int)tax;
		
		vo.setPurchase_price(sum);
		vo.setPurchase_tax((int)tax);
		vo.setPurchase_total(total);
		vo.setCreditor_no(creditno);
		
		d2.updatePurchase(vo);
		
		int debtno = 0;
		int b11 = 0;
		int b21 = 0;
		int b12 = 0;
		int b22 = 0;
		
		if(debtor_no == "") {
			debtno = 0;
		}else {
			debtno = Integer.parseInt(debtor_no);
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
		
		int cno = d2.getClosingNo(vo.getPurchase_code());
		
		Erp_ClosingVO cvo = new Erp_ClosingVO();
		cvo.setClosing_code(vo.getPurchase_code());
		cvo.setClosing_no(cno);
		cvo.setClosing_creditor(total);
		cvo.setClosing_debtor(total);
		cvo.setDebtor_no(debtno);
		cvo.setCreditor_no(creditno);
		
		d2.updateClosing(cvo);
		
		map = new HashMap<>();
		Map<String, Object> dmap = d2.getBsNo(b11);
		Map<String, Object> cmap = d2.getBsNo(b21);
		
		
		map.put("bs3_amount", (-(int)inmap.get("purchase_total")));
		map.put("bs1_no", dmap.get("bs1_no"));
		map.put("bs2_no", dmap.get("bsno2"));
		map.put("bs3_no", dmap.get("bs3_no"));
		
		d2.updateBs1Amount(map);
		d2.updateBs2Amount(map);
		d2.updateBs3Amount(map);
		
		map.put("bs3_amount", (int)inmap.get("purchase_total"));
		map.put("bs1_no", cmap.get("bs1_no"));
		map.put("bs2_no", cmap.get("bsno2"));
		map.put("bs3_no", cmap.get("bs3_no"));
		
		d2.updateBs1Amount(map);
		d2.updateBs2Amount(map);
		d2.updateBs3Amount(map);
		
		
		dmap = d2.getBsNo(b12);
		cmap = d2.getBsNo(b22);
		
		map.put("bs3_amount", total);
		map.put("bs1_no", dmap.get("bs1_no"));
		map.put("bs2_no", dmap.get("bsno2"));
		map.put("bs3_no", dmap.get("bs3_no"));
		
		d2.updateBs1Amount(map);
		d2.updateBs2Amount(map);
		d2.updateBs3Amount(map);
		
		map.put("bs3_amount", (-total));
		map.put("bs1_no", cmap.get("bs1_no"));
		map.put("bs2_no", cmap.get("bsno2"));
		map.put("bs3_no", cmap.get("bs3_no"));
		
		d2.updateBs1Amount(map);
		d2.updateBs2Amount(map);
		d2.updateBs3Amount(map);
		
		return "redirect:/d/d3/d32/updateForm?purchase_no="+vo.getPurchase_no()+"&purchase_code="+vo.getPurchase_code();
	}
	
	@RequestMapping("/d32/delete")
	@Transactional
	public String deletePurchase(Erp_PurchaseVO vo, String comcode_code, Model model, String bs3_no1, String bs3_no2) {
		Map<String, Object> inmap = d2.selectPurchase(vo.getPurchase_no());
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("goodssort_name1", "상품");
		map.put("goodssort_name2", "반제품");
		map.put("purchase_no", vo.getPurchase_no());
		
		List<Map<String, Object>> sp = d2.selectPurchaseGoods(map);
		if(sp != null) {
			for(Map<String, Object> ss : sp) {
				Erp_GoodslotVO gl = new Erp_GoodslotVO();
				gl.setGoodslot_qty((int)ss.get("purchaseconnect_number"));
				gl.setGoodslot_no((int)ss.get("goodslot_no"));
				d2.updateLotQtySub(gl);
				
				Erp_GoodsVO gvo = new Erp_GoodsVO();
				gvo.setGoods_no((int)ss.get("goods_no"));
				gvo.setGoods_stockqty((int)ss.get("purchaseconnect_number"));
				d2.updateGoodsSub(gvo);
			}
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
		
		map = new HashMap<>();
		Map<String, Object> dmap = d2.getBsNo(b1);
		Map<String, Object> cmap = d2.getBsNo(b2);
		
		
		map.put("bs3_amount", (-(int)inmap.get("purchase_total")));
		map.put("bs1_no", dmap.get("bs1_no"));
		map.put("bs2_no", dmap.get("bsno2"));
		map.put("bs3_no", dmap.get("bs3_no"));
		
		d2.updateBs1Amount(map);
		d2.updateBs2Amount(map);
		d2.updateBs3Amount(map);
		
		map.put("bs3_amount", (int)inmap.get("purchase_total"));
		map.put("bs1_no", cmap.get("bs1_no"));
		map.put("bs2_no", cmap.get("bsno2"));
		map.put("bs3_no", cmap.get("bs3_no"));
		
		d2.updateBs1Amount(map);
		d2.updateBs2Amount(map);
		d2.updateBs3Amount(map);
		
		d2.deletePurchaseConnectAll(vo.getPurchase_no());
		
		int cno = d2.getClosingNo(vo.getPurchase_code());
		
		d2.deleteClosing(cno);
		
		d2.deletePurchase(vo.getPurchase_no());
		
		return "redirect:/d/d3/d32/inputPurchase?comcode_code="+comcode_code;
	}
	
	@RequestMapping("/d32/deleteGoods")
	@Transactional
	@ResponseBody
	public List<Map<String, Object>> deletePurchaseGoods(Erp_PurchaseconnectVO vo, String purchase_code, Erp_GoodsVO gvo){
		String closing_code = purchase_code;
		
		Erp_GoodslotVO gl = new Erp_GoodslotVO();
		gl.setGoodslot_qty(vo.getPurchaseconnect_number());
		gl.setGoodslot_no(vo.getGoodslot_no());
		d2.updateLotQtySub(gl);
		
		gvo.setGoods_stockqty(vo.getPurchaseconnect_number());
		d2.updateGoodsSub(gvo);
		
		Erp_PurchaseVO pvo = new Erp_PurchaseVO();
		
		int sum = vo.getPurchaseconnect_price() * vo.getPurchaseconnect_number();
		
		double tax = sum * 0.1;
		
		int total = sum + (int)tax;
		
		pvo.setPurchase_price(sum);
		pvo.setPurchase_tax((int)tax);
		pvo.setPurchase_total(total);
		
		d2.updatePurchasePrice(pvo);
		
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
		
		map.put("purchase_no", vo.getPurchase_no());
		map.put("goodssort_name1", "상품");
		map.put("goodssort_name2", "반제품");
		
		d2.deletePurchaseConnect(vo.getPurchaseconnect_no());
		
		List<Map<String, Object>> list = d2.selectPurchaseGoods(map);
		
		if(list.isEmpty()) {
			list = null;
		}
		
		return list;
	}
	
	@RequestMapping("/d32/employee")
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
		
		return ViewPath.WINDOW + "d/d2/d22/employee";
	}
	
	@RequestMapping(value="/d32/getPurchaseCode", produces = "application/text;charset=utf8")
	@ResponseBody
	public String getPurchaseCode(String purchase_code) {
		try {
			
			if(purchase_code == "") {
				return "공백은 허용되지 않습니다.";
			}
			
			int no = d2.getPurchaseNo(purchase_code);
			
			return "이미 존재하는 코드입니다.";
		}catch(Exception e) {
			return "사용 가능한 코드입니다.";
		}
	}
	
	@RequestMapping("/d32/goodsList")
	public String goodsListd22(String btype, String bnword, String comcode_code, Model model, String i, String client_name) {
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
		
		map.put("client_name", client_name);
		map.put("goodssort_name1", "상품");
		map.put("goodssort_name2", "반제품");
		map.put("comcode_no", comcode_no);
		map.put("btype", btype);
		map.put("bnword", bnword);
		
		List<Map<String, Object>> list = d2.selectClient2Goodsd22(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		model.addAttribute("list", list);
		model.addAttribute("i", i);
		model.addAttribute("client_name", client_name);
		
		return ViewPath.WINDOW + "d/d2/d22/goodsList";
	}
	@RequestMapping("/d32/goodsList1")
	public String goodsList1d22(String btype, String bnword, String comcode_code, Model model, String i, String client_name) {
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
		
		map.put("client_name", client_name);
		map.put("goodssort_name1", "상품");
		map.put("goodssort_name2", "반제품");
		map.put("comcode_no", comcode_no);
		map.put("btype", btype);
		map.put("bnword", bnword);
		
		List<Map<String, Object>> list = d2.selectClient2Goodsd22(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		model.addAttribute("list", list);
		model.addAttribute("i", i);
		model.addAttribute("client_name", client_name);
		
		return ViewPath.WINDOW + "d/d2/d22/goodsList1";
	}
	
	@RequestMapping("/d32/goodsListAjax")
	@ResponseBody
	public List<Map<String, Object>> goodsListAjaxd22(String btype, String bnword, String comcode_code, String client_name) {
		
		int comcode_no = ls.comNo(comcode_code);
		
		if(btype == null || bnword == null) {
			btype = null;
			bnword = null;
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("client_name", client_name);
		map.put("goodssort_name1", "상품");
		map.put("goodssort_name2", "반제품");
		map.put("comcode_no", comcode_no);
		map.put("btype", btype);
		map.put("bnword", bnword);
		
		List<Map<String, Object>> list = d2.selectClient2Goodsd22(map);
		
		return list;
	}
	
	
//	producttest
	@RequestMapping("/d34/inputProductTest")
	public String inputProductTest(String comcode_code, String type, String word, Model model) {
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
		map.put("producttest_type", 0);
		
		List<Erp_PtkindVO> ptlist = d2.ptList();
		List<Map<String, Object>> list = d2.productTestList(map);
		
		model.addAttribute("list", list);
		model.addAttribute("ptlist", ptlist);
		
		return ViewPath.D3 + "/d34/inputProductTest";
	}
	
	@RequestMapping("/d34/updateForm")
	public String updateFormPR(Erp_ProducttestVO vo, String comcode_code, String type, String word, Model model) {
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
		map.put("producttest_type", 0);
		
		List<Erp_PtkindVO> ptlist = d2.ptList();
		List<Map<String, Object>> list = d2.productTestList(map);
		Map<String, Object> inmap = d2.selectProductTest(vo.getProducttest_no());
		
		model.addAttribute("list", list);
		model.addAttribute("ptlist", ptlist);
		model.addAttribute("inmap", inmap);
		
		return ViewPath.D3 + "/d34/inputProductTest";
	}
	
	@RequestMapping("/d34/inputProductTestAjax")
	@ResponseBody
	public List<Map<String, Object>> inputProductTestAjax(String comcode_code, String type, String word){
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		map.put("producttest_type", 0);
		
		List<Map<String, Object>> list = d2.productTestList(map);
		
		return list;
	}
	
	@RequestMapping("/d34/createProductTest")
	@Transactional
	public String createProductTest(Erp_ProducttestVO vo, String comcode_code, Model model) {
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
		
		d2.createProductTest(vo);
		
		return "redirect:/d/d3/d34/inputProductTest?comcode_code="+comcode_code;
	}
	
	@RequestMapping("/d34/update")
	@Transactional
	public String updateProductTest(Erp_ProducttestVO vo, String comcode_code, Model model) {
		
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
		
		d2.updateProductTest(vo);
		
		return "redirect:/d/d3/d34/updateForm?comcode_code="+comcode_code+"&producttest_no="+vo.getProducttest_no();
	}
	
	@RequestMapping("/d34/delete")
	@Transactional
	public String deleteProductTest(Erp_ProducttestVO vo, String comcode_code, Model model) {
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
		
		d2.deleteProductTest(vo.getProducttest_no());
		
		return "redirect:/d/d3/d34/inputProductTest?comcode_code="+comcode_code;
	}
	
	@RequestMapping("/d34/purchase")
	public String purchase(String type, String word, String comcode_code, Model model) {
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
		map.put("purchase_type", 0);
		
		List<Map<String, Object>> list = d2.purchaseList(map);
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "/d/d2/d24/purchase";
	}
	
	@RequestMapping("/d34/purchaseAjax")
	@ResponseBody
	public List<Map<String, Object>> purchaseAjax(String type, String word, String comcode_code) {
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		map.put("purchase_type", 0);
		
		List<Map<String, Object>> list = d2.purchaseList(map);
		
		return list;
	}
	
	@RequestMapping("/d34/goodsList")
	public String goodsListd24(Model model, Erp_PurchaseVO vo, String btype, String bnword) {
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("btype", btype);
		map.put("bnword", bnword);
		map.put("goodssort_name1", "상품");
		map.put("goodssort_name2", "반제품");
		map.put("purchase_no", vo.getPurchase_no());
		
		List<Map<String, Object>> list = d2.selectPurchaseGoods(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		model.addAttribute("list", list);
		
		return ViewPath.WINDOW + "d/d2/d24/goodsList";
	}
	
	@RequestMapping("/d34/goodsListAjax")
	@ResponseBody
	public List<Map<String, Object>> goodsListd24Ajax(Erp_PurchaseVO vo, String btype, String bnword) {
		if(btype == null || bnword == null) {
			btype = null;
			bnword = null;
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("btype", btype);
		map.put("bnword", bnword);
		map.put("goodssort_name1", "상품");
		map.put("goodssort_name2", "반제품");
		map.put("purchase_no", vo.getPurchase_no());
		
		List<Map<String, Object>> list = d2.selectPurchaseGoods(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		return list;
	}
	
	
//	inventory
	@RequestMapping("/d33/inputInventory")
	public String inputInventory(String comcode_code, String type, String word, Model model) {
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
		map.put("inventory_type", 0);
		
		List<Map<String, Object>> list = d2.inventoryList(map);
		
		model.addAttribute("list", list);
		
		return ViewPath.D3 + "/d33/inputInventory";
	}
	
	@RequestMapping("/d33/inputInventoryAjax")
	@ResponseBody
	public List<Map<String, Object>> inputInventoryAjax(String comcode_code, String type, String word){
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		map.put("inventory_type", 0);
		
		List<Map<String, Object>> list = d2.inventoryList(map);
		
		return list;
	}
	
	@RequestMapping("/d33/addInventory")
	public String addInventory(String comcode_code, Model model) {
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
		
		return ViewPath.D3 + "/d33/selectForm";
	}
	
	@RequestMapping("/d33/updateForm")
	public String updateFormIV(Erp_InventoryVO vo, Model model, String comcode_code) {
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
		
		Map<String, Object> inmap = d2.selectInventory(vo.getInventory_no());
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("goodssort_name1", "상품");
		map.put("goodssort_name2", "반제품");
		map.put("inventory_no", vo.getInventory_no());
		
		List<Map<String, Object>> ilist = d2.selectInventoryGoods(map);
		
		model.addAttribute("inmap", inmap);
		model.addAttribute("ilist", ilist);
		
		return ViewPath.D3 + "/d33/selectForm";
	}
	
	@RequestMapping("/d33/createInventory")
	@Transactional
	public String createInventory(Erp_InventoryVO vo, Erp_InvenconnectVO ivo, String comcode_code, Model model) {
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
		
		List<Erp_InvenconnectVO> iclist = ivo.getIclist();
		
		vo.setComcode_no(comcode_no);
		
		d2.createInventory(vo);
		
		int ino = d2.getInventoryNo(vo);
		
		for(Erp_InvenconnectVO icvo : iclist) {
			icvo.setInventory_no(ino);
			d2.createInvenConnect(icvo);
		}
		
		return "redirect:/d/d3/d33/updateForm?inventory_no="+ino+"&comcode_code="+comcode_code;
	}
	
	@RequestMapping("/d33/update")
	@Transactional
	public String updateInventory(Erp_InventoryVO vo, Erp_InvenconnectVO ivo, String comcode_code, Model model) {
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
		
		List<Erp_InvenconnectVO> iclist = ivo.getIclist();
		List<Erp_InvenconnectVO> iclist1 = ivo.getIclist1();
		
		if(iclist1 != null) {
			for(Erp_InvenconnectVO icvo : iclist1) {
				d2.updateInvenConnect(icvo);
			}
		}
		
		if(iclist != null) {
			for(Erp_InvenconnectVO icvo : iclist) {
				icvo.setInventory_no(vo.getInventory_no());
				d2.createInvenConnect(icvo);
			}
		}
		
		return "redirect:/d/d3/d33/updateForm?inventory_no="+vo.getInventory_no()+"&comcode_code="+comcode_code;
	}
	
	@RequestMapping("/d33/delete")
	@Transactional
	public String deleteInventory(Erp_InventoryVO vo, String comcode_code, Model model) {
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
		
		d2.deleteInventory(vo.getInventory_no());
		
		d2.deleteInvenConnectAll(vo.getInventory_no());
		
		return "redirect:/d/d3/d33/inputInventory?comcode_code="+comcode_code;
	}
	
	@RequestMapping("/d33/deleteGoods")
	@ResponseBody
	public List<Map<String, Object>> deleteInventorGoods(Erp_InvenconnectVO vo){
		d2.deleteInvenConnect(vo.getInvenconnect_no());
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("goodssort_name1", "상품");
		map.put("goodssort_name2", "반제품");
		map.put("inventory_no", vo.getInventory_no());
		
		List<Map<String, Object>> list = d2.selectInventoryGoods(map);
		
		if(list.isEmpty()) {
			list = null;
		}
		
		return list;
	}
	
	@RequestMapping("/d33/goodsList")
	public String goodsListd23(String btype, String bnword, String comcode_code, Model model, String i) {
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
		
		map.put("goodssort_name1", "상품");
		map.put("goodssort_name2", "반제품");
		map.put("comcode_no", comcode_no);
		map.put("btype", btype);
		map.put("bnword", bnword);
		map.put("purchase_type", 0);
		
		List<Map<String, Object>> list = d2.purchaseGoods(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		model.addAttribute("list", list);
		model.addAttribute("i", i);
		
		return ViewPath.WINDOW + "d/d2/d23/goodsList";
	}
	@RequestMapping("/d33/goodsList1")
	public String goodsList1d23(String btype, String bnword, String comcode_code, Model model, String i) {
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
		
		map.put("goodssort_name1", "상품");
		map.put("goodssort_name2", "반제품");
		map.put("comcode_no", comcode_no);
		map.put("btype", btype);
		map.put("bnword", bnword);
		map.put("purchase_type", 0);
		
		List<Map<String, Object>> list = d2.purchaseGoods(map);
		if(list.isEmpty()) {
			list = null;
		}
		
		model.addAttribute("list", list);
		model.addAttribute("i", i);
		
		return ViewPath.WINDOW + "d/d2/d23/goodsList1";
	}
	
	@RequestMapping("/d33/goodsListAjax")
	@ResponseBody
	public List<Map<String, Object>> goodsListAjaxd23(String btype, String bnword, String comcode_code, Model model) {
		
		int comcode_no = ls.comNo(comcode_code);
		
		if(btype == null || bnword == null) {
			btype = null;
			bnword = null;
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("goodssort_name1", "상품");
		map.put("goodssort_name2", "반제품");
		map.put("comcode_no", comcode_no);
		map.put("btype", btype);
		map.put("bnword", bnword);
		map.put("purchase_type", 0);
		
		List<Map<String, Object>> list = d2.purchaseGoods(map);
		
		return list;
	}
	
	@RequestMapping("/d33/coList")
	public String coListd23(String comcode_code, Model model) {
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
		
		return ViewPath.WINDOW + "d/d2/d23/coList";
	}
	
	@RequestMapping("/d33/coListAjax")
	@ResponseBody
	public List<Map<String, Object>> coListAjaxd23(String comcode_code, String type, String word) {
		Map<String, Object> map = new HashMap<>();
		
		int comcode_no = ls.comNo(comcode_code);
		
		map.put("comcode_no", comcode_no);
		map.put("type", type);
		map.put("word", word);
		
		List<Map<String, Object>> list = d1.coList(map);
		
		return list;
	}
	
	@RequestMapping("/d33/employee")
	public String employeed23(String comcode_code, Model model, String type, String word) {
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
		
		return ViewPath.WINDOW + "d/d2/d23/employee";
	}
}
