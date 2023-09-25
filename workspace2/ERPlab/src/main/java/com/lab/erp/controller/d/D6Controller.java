package com.lab.erp.controller.d;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lab.erp.service.d.D6Service;
import com.lab.erp.service.login.LoginService;
import com.lab.erp.vo.c.Erp_ClientVO;
import com.lab.erp.vo.d.d6.Erp_GoodskindVO;
import com.lab.erp.vo.d.d6.Erp_GoodslevVO;
import com.lab.erp.vo.d.d6.Erp_GoodsstVO;

@Controller
public class D6Controller {
	
	private LoginService ls;
	private D6Service d6;
	
	public D6Controller(D6Service d6, LoginService ls) {
		this.d6 = d6;
		this.ls = ls;
	}
	
	@RequestMapping("/stock")
	public String stock(Model model, String type, String word, String comcode_code) {
		
		int comcode_no = ls.comNo(comcode_code);
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("comcode_no", comcode_no);
		map.put("type", type);
		map.put("word", word);
		
		List<Map<String, Object>> list = d6.selectGoods(map);
		model.addAttribute("list", list);
		return "/d/d6/d61/goodsList";
	}
	
	@RequestMapping("/stock/ajax")
	@ResponseBody
	public List<Map<String, Object>> stockAjax(Model model, String type, String word, String comcode_code) {
		Map<String, Object> map = new HashMap<>();
		if(type == null || word == null) {
	         type = null;
	         word = null;
	      }
	      
	      int comcode_no = ls.comNo(comcode_code);
	      
	      map.put("comcode_no", comcode_no);
	      map.put("word", word);
	      map.put("type", type);
	      
	      List<Map<String, Object>> list = d6.selectGoods(map);
	      if(list.isEmpty()) {
		         list = null;
		      }
	      
	      System.out.println("ajax:"+list);
		  return list;
	}
	
	@RequestMapping("/stock/insertForm")
	public String insertForm(Model model) {
		List<Erp_GoodskindVO> list = d6.selectGoodskind();
		List<Erp_GoodsstVO> gslist = d6.selectGoodsst();
		List<Erp_GoodslevVO> gllist = d6.selectGoodslev();
		List<Erp_ClientVO> clist = d6.selectClient();
		
		
		model.addAttribute("gslist", gslist);
		model.addAttribute("gllist", gllist);
		model.addAttribute("clist", clist);
		model.addAttribute("list", list);
		return "d/d6/d61/goodsInsertform";
	}
	
	@RequestMapping("/stock/insert")
	public String stockInsert(@RequestParam("goodslot_lot") String[] goodslot_lot,
			@RequestParam("goodslot_qty") Integer[] goodslot_qty,
			@RequestParam("goodslot_production") String[] goodslot_production,
			@RequestParam("goodslot_expiry") String[] goodslot_expiry,
			@RequestParam("goodslot_price") Integer[] goodslot_price,
			@RequestParam("goodslot_tax") Integer[] goodslot_tax,
			String goods_code, String goods_barcode, String goods_name,
			int goodskind_no, int goods_customerprice,
			String goods_description, int client_no1,
			int client_no2, int goods_stockqty, int goodslev_no,
			String comcode_code, String goodsst_unit, String goodsst_spec,
			String goodsst_size, String goodsst_package,
			int goodsst_ea) {
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map11 = new HashMap<>();
		map11.put("goodsst_unit", goodsst_unit);
		map11.put("goodsst_spec", goodsst_spec);
		map11.put("goodsst_size", goodsst_size);
		map11.put("goodsst_package", goodsst_package);
		map11.put("goodsst_ea", goodsst_ea);
		
		d6.insertGoodsst(map11);
		
		Map<String, Object> map12 = new HashMap<>();
		map12.put("goodsst_unit", goodsst_unit);
		map12.put("goodsst_spec", goodsst_spec);
		map12.put("goodsst_size", goodsst_size);
		map12.put("goodsst_package", goodsst_package);
		map12.put("goodsst_ea", goodsst_ea);
		
		int goodsst_no = d6.selectGoodsstno(map12);
		
		
	    for (String lot : goodslot_lot) {
	        System.out.println(lot);
	    }
	    
	    if (goodslot_lot.length > 0) {
	        String firstLot = goodslot_lot[0]; // 첫 번째 배열 요소 가져오기
	        System.out.println("첫 번째 로트번호: " + firstLot);
	    }
	    
	    
	    Map<String, Object> map = new HashMap<>();
	    map.put("goods_code", goods_code);
	    map.put("goods_barcode", goods_barcode);
	    map.put("goods_name", goods_name);
	    map.put("goodskind_no", goodskind_no);
	    map.put("goods_customerprice", goods_customerprice);
	    map.put("goods_description", goods_description);
	    map.put("goodsst_no", goodsst_no);
	    map.put("client_no1", client_no1);
	    map.put("client_no2", client_no2);
	    map.put("goods_stockqty", goods_stockqty);
	    map.put("goodslev_no", goodslev_no);
	    map.put("comcode_no", comcode_no);
	    
	    int su = d6.insertGoods(map);
	    System.out.println("1번 배열:" + su);
		int goods_no = d6.selectGoodsno(goods_code);
	    
		System.out.println(goods_no);
		
	    Map<String, Object> map2 = new HashMap<>();
	    map2.put("goodslot_lot", goodslot_lot[0]);
	    map2.put("goodslot_qty", goodslot_qty[0]);
	    map2.put("goodslot_production", goodslot_production[0]);
	    map2.put("goodslot_expiry", goodslot_expiry[0]);
	    map2.put("goodslot_price", goodslot_price[0]);
	    map2.put("goodslot_tax", goodslot_tax[0]);
	    map2.put("goodslot_total", goodslot_price[0] + goodslot_tax[0]);
	    map2.put("goods_no", goods_no);
	    
	    d6.insertGoodslot(map2);
	    
	    
	    try {
	    if(goodslot_price[1] != 0) {
	    	Map<String, Object> map3 = new HashMap<>();
		    map3.put("goodslot_lot", goodslot_lot[1]);
		    map3.put("goodslot_qty", goodslot_qty[1]);
		    map3.put("goodslot_production", goodslot_production[1]);
		    map3.put("goodslot_expiry", goodslot_expiry[1]);
		    map3.put("goodslot_price", goodslot_price[1]);
		    map3.put("goodslot_tax", goodslot_tax[1]);
		    map3.put("goodslot_total", goodslot_price[1] + goodslot_tax[1]);
		    map3.put("goods_no", goods_no);
		    
		    d6.insertGoodslot(map3);
		    
	    }
	    if(goodslot_price[2] != 0) {
	    	Map<String, Object> map4 = new HashMap<>();
		    map4.put("goodslot_lot", goodslot_lot[2]);
		    map4.put("goodslot_qty", goodslot_qty[2]);
		    map4.put("goodslot_production", goodslot_production[2]);
		    map4.put("goodslot_expiry", goodslot_expiry[2]);
		    map4.put("goodslot_price", goodslot_price[2]);
		    map4.put("goodslot_tax", goodslot_tax[2]);
		    map4.put("goodslot_total", goodslot_price[2] + goodslot_tax[2]);
		    map4.put("goods_no", goods_no);
		    
		    d6.insertGoodslot(map4);
	    }
	    }catch(Exception e) {
	    	e.printStackTrace();
	    }
	    
	    return "redirect:/stock?comcode_code=" + comcode_code;
	}

	@RequestMapping("/stock/updateQty")
	public String stockUpdateqty(@RequestParam(required = false) String comcode_code, @RequestParam(required = false) Integer goods_no, @RequestParam(required = false) Integer goodslot_no, @RequestParam(required = false) Integer goodslot_qty) {
	    System.out.println("테스"+goods_no);
	    System.out.println(goodslot_no);
	    System.out.println(goodslot_qty);
	    
	    Map<String, Object> map = new HashMap<>();
	    map.put("goodslot_no", goodslot_no);
	    map.put("goodslot_qty", goodslot_qty);
	    
	    d6.updateQty(map);
	    
	    // 나머지 로직 추가
	    return "redirect:/stock?comcode_code=" + comcode_code;
	}
	
	@RequestMapping("/stock/updateForm")
	public String stockupdateForm(Model model, int goodsst_no, String type, String word, String comcode_code, int goods_no, int goodslot_no) {
		
		int comcode_no = ls.comNo(comcode_code);
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("comcode_no", comcode_no);
		map.put("goodslot_no", goodslot_no);
		map.put("type", type);
		map.put("word", word);
		
		map = d6.selectGoods2(map);
		
		List<Erp_GoodskindVO> list = d6.selectGoodskind();
		List<Erp_GoodsstVO> gslist = d6.selectGoodsst();
		List<Erp_GoodslevVO> gllist = d6.selectGoodslev();
		List<Erp_ClientVO> clist = d6.selectClient();
		
		Map<String, Object> map2 = new HashMap<>();
		map2.put("goodsst_no", goodsst_no);
		
		map2 = d6.selectGoodsst2(map2);
		
		model.addAttribute("gslist", gslist);
		model.addAttribute("gllist", gllist);
		model.addAttribute("clist", clist);
		model.addAttribute("list", list);
		
		model.addAttribute("goods_no", goods_no);
		model.addAttribute("goodslot_no", goodslot_no);
		model.addAttribute("map", map);
		model.addAttribute("map2", map2);
		
		return "/d/d6/d61/updateForm";
	}
	
	@RequestMapping("/stock/update")
	public String stockUpdate(String comcode_code, int goods_no, 
			int goodslot_no, String goods_code, 
			String goods_barcode, String goods_name, 
			int goodskind_no, int goods_customerprice, 
			int goodsst_no, int client_no1, int client_no2, 
			int goods_stockqty, int goodslev_no, 
			String goods_description, String goodslot_lot, 
			int goodslot_qty, String goodslot_production, 
			int goodslot_tax, int goodslot_price, 
			String goodslot_expiry, String goodsst_unit,
			String goodsst_spec, String goodsst_size,
			String goodsst_package, int goodsst_ea) {
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		map.put("goods_no", goods_no);
		map.put("goods_code", goods_code);
		map.put("goods_barcode", goods_barcode);
		map.put("goods_name", goods_name);
		map.put("goodskind_no", goodskind_no);
		map.put("goods_customerprice", goods_customerprice);
		map.put("goods_description", goods_description);
		map.put("client_no1", client_no1);
		map.put("client_no2", client_no2);
		map.put("goods_stockqty", goods_stockqty);
		map.put("goodslev_no", goodslev_no);
		map.put("comcode_no", comcode_no);
		
		d6.updateGoods2(map);
		
		Map<String, Object> map2 = new HashMap<>();
		map2.put("goodslot_lot", goodslot_lot);
		map2.put("goodslot_qty", goodslot_qty);
		map2.put("goodslot_production", goodslot_production);
		map2.put("goodslot_expiry", goodslot_expiry);
		map2.put("goodslot_price", goodslot_price);
		map2.put("goodslot_tax", goodslot_tax);
		map2.put("goodslot_total", goodslot_price + goodslot_tax);
		map2.put("goodslot_no", goodslot_no);
		map2.put("goods_no", goods_no);
		
		d6.updateGoodslot(map2);
		
		Map<String, Object> map3 = new HashMap<>();
		map3.put("goodsst_unit", goodsst_unit);
		map3.put("goodsst_spec", goodsst_spec);
		map3.put("goodsst_size", goodsst_size);
		map3.put("goodsst_package", goodsst_package);
		map3.put("goodsst_ea", goodsst_ea);
		map3.put("goodsst_no", goodsst_no);
		
		d6.updateGoodsst2(map3);
		
		return "redirect:/stock?comcode_code=" + comcode_code;
		
	}
	
	@RequestMapping("/stock/delete")
	public String stockDelete(int goods_no, int goodslot_no, String comcode_code) {
		
		Map<String, Object> map = new HashMap<>();
		map.put("goodslot_no", goodslot_no);
		
		d6.deleteGoodslot(map);
		return "redirect:/stock?comcode_code=" + comcode_code;
	}
	
	@RequestMapping("/management")
	public String management(Model model, String comcode_code, String word, String type) {
		int comcode_no = ls.comNo(comcode_code);
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("comcode_no", comcode_no);
		map.put("type", type);
		map.put("word", word);
		
		List<Map<String, Object>> flist = d6.manageForsales(map);
		List<Map<String, Object>> ilist = d6.manageImport(map);
		List<Map<String, Object>> llist = d6.manageLocalsales(map);
		List<Map<String, Object>> slist = d6.manageStoresales(map);
		List<Map<String, Object>> olist = d6.manageOnline(map);
		List<Map<String, Object>> plist = d6.managePurchase(map);
		
		model.addAttribute("flist", flist);
		model.addAttribute("ilist", ilist);
		model.addAttribute("llist", llist);
		model.addAttribute("slist", slist);
		model.addAttribute("olist", olist);
		model.addAttribute("plist", plist);

		
		return "/d/d6/d62/managementList";
	}
	
	@RequestMapping("/stock/dispose")
	public String dispose(Model model, String comcode_code, int goods_no) {
		
		System.out.println("폐기"+goods_no);
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		map.put("goodslev_no", 4);
		map.put("goods_no", goods_no);
	
		d6.updateGoodslev(map);
		
		return "redirect:/stock?comcode_code=" + comcode_code;
	}
	
	@RequestMapping("/stock/reverseDispose")
	public String reverseDispose(Model model, String comcode_code, int goods_no) {
		
		Map<String, Object> map = new HashMap<>();
		map.put("goodslev_no", 1);
		map.put("goods_no", goods_no);
		
		d6.updateGoodslev(map);
		
		return "redirect:/stock?comcode_code=" + comcode_code;
	}


}
