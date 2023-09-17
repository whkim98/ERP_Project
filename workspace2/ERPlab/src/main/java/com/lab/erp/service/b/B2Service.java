package com.lab.erp.service.b;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lab.erp.dao.b.b1.Erp_Bs3DAO;
import com.lab.erp.dao.b.b1.Erp_ClosingDAO;
import com.lab.erp.dao.b.b1.Erp_CreditorDAO;
import com.lab.erp.dao.b.b1.Erp_DebtorDAO;
import com.lab.erp.dao.b.b2.Erp_BudgetDAO;
import com.lab.erp.dao.b.b2.Erp_MoneyDAO;
import com.lab.erp.vo.b.b2.Erp_BudgetVO;
import com.lab.erp.vo.b.b2.Erp_MoneyVO;

@Service
public class B2Service {

	private Erp_ClosingDAO cdao;
	private Erp_MoneyDAO mdao;
	private Erp_DebtorDAO ddao;
	private Erp_CreditorDAO cddao;
	private Erp_Bs3DAO bdao;
	private Erp_BudgetDAO bgdao;
	
	@Autowired
	public B2Service(Erp_BudgetDAO bgdao, Erp_Bs3DAO bdao, Erp_DebtorDAO ddao, Erp_CreditorDAO cddao, Erp_ClosingDAO cdao, Erp_MoneyDAO mdao) {
		this.cdao = cdao;
		this.mdao = mdao;
		this.ddao = ddao;
		this.cddao = cddao;
		this.bdao = bdao;
		this.bgdao = bgdao;
	}
	
	public List<Map<String, Object>> closingList(Map<String, Object> map){
		return cdao.closingList(map);
	}
	
	public int insertMoney(Erp_MoneyVO vo) {
		return mdao.insertMoney(vo);
	}
	
	public int moneyBs3nod(int debtor_no) {
		return ddao.moneyBs3nod(debtor_no);
	}
	
	public int moneyBs3noc(int creditor_no) {
		return cddao.moneyBs3noc(creditor_no);
	}
	
	public String moneyBs3ctgrd(int bs3_no) {
		return bdao.moneyBs3ctgrd(bs3_no);
	}
	
	public String moneyBs3ctgrc(int bs3_no) {
		return bdao.moneyBs3ctgrc(bs3_no);
	}
	
	public List<Map<String, Object>> budgetList(Map<String, Object> map){
		return bgdao.budgetList(map);
	}
	
	public int insertBudget(Erp_BudgetVO vo) {
		return bgdao.insertBudget(vo);
	}
	
	public Map<String, Object> budgetList2(Map<String, Object> map){
		return bgdao.budgetList2(map);
	}
	
	public int updateBudget(Map<String, Object> map) {
		return bgdao.updateBudget(map);
	}
	
}
