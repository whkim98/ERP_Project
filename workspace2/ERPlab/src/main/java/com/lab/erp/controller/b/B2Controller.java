package com.lab.erp.controller.b;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.lab.erp.service.b.B2Service;
import com.lab.erp.service.login.LoginService;
import com.lab.erp.vo.b.b2.Erp_AccountVO;
import com.lab.erp.vo.b.b2.Erp_BudgetVO;
import com.lab.erp.vo.b.b2.Erp_MoneyVO;
import com.lab.erp.vo.b.b3.Erp_CurrencyVO;

@Controller
public class B2Controller {

	private B2Service b2;
	private LoginService ls;
	
	@Autowired
	public B2Controller(B2Service b2, LoginService ls) {
		this.b2 = b2;
		this.ls = ls;
	}
	
	@RequestMapping("/account")
	public String account(Model model, String type, String word, String comcode_code) {
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		map.put("comcode_no", comcode_no);
		map.put("type", type);
		map.put("word", word);
		
		List<Map<String, Object>> list = b2.selectAccount(map);
		model.addAttribute("list", list);
		
		return "/b/b2/b21/accountList";
	}
	
	@RequestMapping("/account/ajax")
	@ResponseBody
	public List<Map<String, Object>> accountAjax(Model model, String comcode_code, String type, String word) {
		Map<String, Object> map = new HashMap<>();
	      if(type == null || word == null) {
	         type = null;
	         word = null;
	      }
	      
	      int comcode_no = ls.comNo(comcode_code);
	      
	      map.put("comcode_no", comcode_no);
	      map.put("word", word);
	      map.put("type", type);
	      
	      List<Map<String, Object>> list = b2.selectAccount(map);
	      if(list.isEmpty()) {
		         list = null;
		      }
	      System.out.println(list);
	      return list;
	}
	
	@RequestMapping(value = "/account/autoUpdate", method = RequestMethod.POST)
	public String autoUpdate(@RequestParam("jsonData") String jsonData, Erp_AccountVO avo, Erp_CurrencyVO vo, String comcode_code) {
	    // 받은 JSON 데이터를 다시 객체로 변환
	    List<Map<String, String>> dataList = new ArrayList<>();
	    try {
	        ObjectMapper objectMapper = new ObjectMapper();
	        dataList = objectMapper.readValue(jsonData, new TypeReference<List<Map<String, String>>>() {});
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    // 데이터 처리 로직 추가
	    for (Map<String, String> item : dataList) {
	        System.out.println("fxrt: " + item.get("fxrt"));
	        System.out.println("aplyBgnDt: " + item.get("aplyBgnDt"));
	        System.out.println("currSgn: " + item.get("currSgn"));
	        
	        String country_code = item.get("cntySgn");
	        
	        int country_no = b2.selectCountryno(country_code);
	        
	        System.out.println(country_no);

	        List<Erp_CurrencyVO> list = b2.currencyDate(country_no);
	        
	        List<String> currencyDates = list.stream()
	        	    .map(Erp_CurrencyVO::getCurrency_date)
	        	    .collect(Collectors.toList());
	       
	        System.out.println(currencyDates);
	        
	        String fxrtString = item.get("fxrt"); // "fxrt"에 해당하는 문자열 값을 가져온다.

	        double fxrtDouble = Double.parseDouble(fxrtString); // 문자열을 double로 변환한다.
	           
	        System.out.println(fxrtDouble);
	        
	        System.out.println("=================");
	        
//	        vo.setCountry_no(country_no);
//	        vo.setCurrency_date(item.get("aplyBgnDt"));
//	        vo.setCurrency_name(item.get("currSgn"));
//	        vo.setCurrency_rate(fxrtDouble);
//	        
//	        b2.insertCurrency(vo);
	        
	        
	        if(!currencyDates.contains(item.get("aplyBgnDt"))) {
	        	vo.setCountry_no(country_no);
	        	vo.setCurrency_name(item.get("currSgn"));
	        	vo.setCurrency_rate(fxrtDouble);
	        	vo.setCurrency_date(item.get("aplyBgnDt"));
	        	
	        	b2.insertCurrency(vo);
	        	
	        	try {
	        		
		        	for(int i = 1; i <= item.size(); i++) {
		        		int account_no = i;
			        	int currency_no = b2.selectCurrencyno(account_no);
		        		int account_balance = b2.selectBalance(account_no);
		        		
		        		double currency_rate = b2.selectRate(currency_no);
		        		
		        		double account_exchange = account_balance * currency_rate;
		        		
		        		Map<String, Object> map = new HashMap<>();
		        		map.put("account_no", account_no);
		        		map.put("account_exchange", account_exchange);
		        		
		        		b2.updateExchange(map);
		        		
	        	}
		        	
	        		}catch(Exception e) {
	        			e.printStackTrace();
	        		}
	        	
	        	
	        }
	        
	     
	    }
	    

	   
	    return "redirect:/account?comcode_code=" + comcode_code;
	}

	
	@RequestMapping("/funds")
	public String funds(Model model, String type, String word, String comcode_code) {
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		map.put("comcode_no", comcode_no);
		map.put("type", type);
		map.put("word", word);
		
		List<Map<String, Object>> list = b2.closingList(map);
		model.addAttribute("list", list);
		
		Map<String, Object> map2 = new HashMap<>();
		map2.put("comcode_no", comcode_no);
		map2.put("type", type);
		map2.put("word", word);
		
		List<Map<String, Object>> list2 = b2.moneyList(map2);
		
		model.addAttribute("list2", list2);
		
		return "/b/b2/b22/fundsList";
	}
	
	@RequestMapping("/funds/ajax")
	@ResponseBody
	public List<Map<String, Object>> fundsAjax(Model model, String type, String word, String comcode_code){
		
		System.out.println("ㅠ펀드ajax");
		
		Map<String, Object> map = new HashMap<>();
		
		if(type == null || word == null) {
	         type = null;
	         word = null;
	      }
		
		int comcode_no = ls.comNo(comcode_code);
		
		map.put("comcode_no", comcode_no);
		map.put("type", type);
		map.put("word", word);
		
		List<Map<String, Object>> list = b2.closingList(map);
		
		if(list.isEmpty()) {
	         list = null;
	      }
     
	    System.out.println(list);
		return list;
		
	}
	
	@RequestMapping("/money/ajax")
	@ResponseBody
	public List<Map<String, Object>> moneyAjax(Model model, String type, String word, String comcode_code) {
		Map<String, Object> map = new HashMap<>();
		
		if(type == null || word == null) {
	         type = null;
	         word = null;
	      }
		
		int comcode_no = ls.comNo(comcode_code);
		
		map.put("comcode_no", comcode_no);
		map.put("type", type);
		map.put("word", word);
		
		List<Map<String, Object>> list = b2.moneyList(map);
		return list;
		
	}
	
	@RequestMapping("/funds/insert")
	public String insertFunds(Erp_MoneyVO vo, String money_code, 
			int debtor_no, int money_debtoramount,
			int creditor_no, int money_creditoramount,
			String comcode_code) {
		
		int comcode_no = ls.comNo(comcode_code);
		
		int bs3_no = b2.moneyBs3nod(debtor_no);
		
		String money_debtor = b2.moneyBs3ctgrd(bs3_no);
		
		bs3_no = b2.moneyBs3noc(creditor_no);
		
		String money_creditor = b2.moneyBs3ctgrc(bs3_no);
		
		vo.setComcode_no(comcode_no);
		vo.setCreditor_no(creditor_no);
		vo.setDebtor_no(debtor_no);
		vo.setMoney_code(money_code);
		vo.setMoney_creditor(money_creditor);
		vo.setMoney_creditoramount(money_creditoramount);
		vo.setMoney_debtor(money_debtor);
		vo.setMoney_debtoramount(money_debtoramount);
		
		b2.insertMoney(vo);
		
		return "redirect:/funds?comcode_code=" + comcode_code;
		
	}
	
	@RequestMapping("/budget")
	public String budget(Model model, String comcode_code, String type, String word) {
		
		int comcode_no = ls.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		map.put("comcode_no", comcode_no);
		map.put("type", type);
		map.put("word", word);
		
		List<Map<String, Object>> list = b2.budgetList(map);
		model.addAttribute("list", list);
		
		return "/b/b2/b23/budgetList";
	}
	
	@RequestMapping("/budget/insert")
	public String insertBudget(Erp_BudgetVO vo, String budget_type, int team_no, 
			String budget_contents, String budget_approved,
			String budget_execution, int budget_amount, int budget_tax
			, String comcode_code) {
		
		int comcode_no = ls.comNo(comcode_code);
		
		int total = budget_tax + budget_amount;
		
		vo.setBudget_amount(budget_amount);
		vo.setBudget_approved(budget_approved);
		vo.setBudget_contents(budget_contents);
		vo.setBudget_execution(budget_execution);
		vo.setBudget_tax(budget_tax);
		vo.setBudget_total(total);
		vo.setBudget_type(budget_type);
		vo.setComcode_no(comcode_no);
		vo.setTeam_no(team_no);
		
		b2.insertBudget(vo);
		
		return "redirect:/budget?comcode_code=" + comcode_code;
	}
	
	@RequestMapping("/budget/updateForm")
	public String budgetUpdateform(Model model, String type, String word, String comcode_code, int budget_no) {
		
		int comcode_no = ls.comNo(comcode_code);
		
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("comcode_no", comcode_no);
		map.put("budget_no", budget_no);
		map.put("type", type);
		map.put("word", word);
		
		map = b2.budgetList2(map);
		
		List<Map<String, Object>> list = b2.budgetList(map);
		
		model.addAttribute("map", map);
		model.addAttribute("list", list);
		
		return "/b/b2/b23/budgetList";
	}
	
	@RequestMapping("/budget/update")
	public String updateBudget(String comcode_code, int budget_no
			, String budget_type, int team_no, String budget_contents
			, String budget_approved, String budget_execution,
			int budget_amount, int budget_tax) {
		
		int comcode_no = ls.comNo(comcode_code);
		
		int total = budget_tax + budget_amount;
		
		Map<String, Object> map = new HashMap<>();
		map.put("comcode_no", comcode_no);
		map.put("budget_no", budget_no);
		map.put("budget_type", budget_type);
		map.put("team_no", team_no);
		map.put("budget_contents", budget_contents);
		map.put("budget_approved", budget_approved);
		map.put("budget_execution", budget_execution);
		map.put("budget_amount", budget_amount);
		map.put("budget_tax", budget_tax);
		map.put("budget_total", total);
		
		b2.updateBudget(map);
		
		return "redirect:/budget?comcode_code=" + comcode_code;
		
	}
	
	@RequestMapping("/budget/ajax")
	@ResponseBody
	public List<Map<String, Object>> budgetAjax(Model model, String type, String word, String comcode_code){
		
		
		Map<String, Object> map = new HashMap<>();
		
		if(type == null || word == null) {
	         type = null;
	         word = null;
	      }
		
		int comcode_no = ls.comNo(comcode_code);
		
		map.put("comcode_no", comcode_no);
		map.put("type", type);
		map.put("word", word);
		
		List<Map<String, Object>> list = b2.budgetList(map);
		
		if(list.isEmpty()) {
	         list = null;
	      }
     
	    System.out.println(list);
		return list;
		
	}
	
}
