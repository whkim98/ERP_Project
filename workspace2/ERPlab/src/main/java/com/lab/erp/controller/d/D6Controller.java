package com.lab.erp.controller.d;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
			String goods_description, int goodsst_no, int client_no1,
			int client_no2, int goods_stockqty, int goodslev_no,
			String comcode_code) {
		
		int comcode_no = ls.comNo(comcode_code);
		
	    for (String lot : goodslot_lot) {
	        System.out.println(lot);
	    }
	    
	    if (goodslot_lot.length > 0) {
	        String firstLot = goodslot_lot[0]; // 첫 번째 배열 요소 가져오기
	        System.out.println("첫 번째 로트번호: " + firstLot);
	    }
	    
	    System.out.println(goodslot_lot[1]);
	    
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
	    
	    d6.insertGoods(map);
	    
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
	    
	    System.out.println("테스트" + goodslot_lot[1]);
	    System.out.println("테스트" + goodslot_qty[1]);
	    System.out.println("테스트" + goodslot_production[1]);
	    System.out.println("테스트" + goodslot_expiry[1]);
	    System.out.println("테스트" + goodslot_price[1]);
	    System.out.println("테스트" + goodslot_tax[1]);
	    
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
		    
	    }else if(goodslot_price[2] != 0) {
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
	    
	    return "redirect:/stock?comcode_code=" + comcode_code;
	}

	@RequestMapping("/stock/updateQty")
	public String stockUpdateqty(int goods_no, int goodslot_no) {
		
		
		
		return "";
	}

}
