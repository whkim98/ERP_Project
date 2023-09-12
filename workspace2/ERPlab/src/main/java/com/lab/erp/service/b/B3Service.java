package com.lab.erp.service.b;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lab.erp.dao.b.b1.Erp_Bs3DAO;
import com.lab.erp.dao.b.b1.Erp_ClosingDAO;
import com.lab.erp.dao.b.b1.Erp_CreditorDAO;
import com.lab.erp.dao.b.b1.Erp_DebtorDAO;
import com.lab.erp.dao.b.b3.Erp_StatementDAO;
import com.lab.erp.dao.b.b3.Erp_TaxinvoiceDAO;
import com.lab.erp.dao.c.Erp_ClientDAO;
import com.lab.erp.dao.c.Erp_CountryDAO;
import com.lab.erp.dao.login.Erp_TeamDAO;
import com.lab.erp.vo.b.b1.Erp_Bs3VO;
import com.lab.erp.vo.b.b1.Erp_ClosingVO;
import com.lab.erp.vo.b.b3.Erp_StatementVO;
import com.lab.erp.vo.b.b3.Erp_TaxinvoiceVO;
import com.lab.erp.vo.c.Erp_ClientVO;
import com.lab.erp.vo.c.Erp_CountryVO;

@Service
public class B3Service {
	private Erp_Bs3DAO bs3dao;
	
	private Erp_ClosingDAO cldao;
	private Erp_DebtorDAO dedao;
	private Erp_CreditorDAO crdao;
	
	private Erp_ClientDAO cdao;
	private Erp_TeamDAO tdao;
	
	private Erp_TaxinvoiceDAO taxdao;
	
	private Erp_StatementDAO sdao;
	
	private Erp_CountryDAO ctdao;
	
	@Autowired
	public B3Service(Erp_Bs3DAO bs3dao, Erp_ClosingDAO cldao, Erp_DebtorDAO dedao, Erp_CreditorDAO crdao, Erp_ClientDAO cdao, Erp_TeamDAO tdao, Erp_TaxinvoiceDAO taxdao, Erp_StatementDAO sdao, Erp_CountryDAO ctdao) {
		this.bs3dao = bs3dao;
		this.cldao = cldao;
		this.dedao = dedao;
		this.crdao = crdao;
		
		this.cdao = cdao;
		this.tdao = tdao;
		
		this.taxdao = taxdao;
		
		this.sdao = sdao;
		
		this.ctdao = ctdao;
	}
	
	
	// 전자세금계산서
	public int insertTaxinvoice(Erp_TaxinvoiceVO vo) {
		return taxdao.insertTaxinvoice(vo);
	}

	
	// <전표>
	public int insertStatement(Erp_StatementVO vo) {
		return sdao.insertStatement(vo);
	}
	public int updateStatement(Erp_StatementVO vo) {
		return sdao.updateStatement(vo);
	}
	public int deleteStatement(int statement_no) {
		return sdao.deleteStatement(statement_no);
	}
	public List<Map<String, Object>> statementList(Map<String, Object> map){
		return sdao.statementList(map);
	}
	public Map<String, Object> selectStatement(Map<String, Object> map){
		return sdao.selectStatement(map);
	}
	public int getStatementCode(String statement_code) {
		return sdao.getStatementCode(statement_code);
	}
	
	// client
	public List<Map<String, Object>> clientList(Map<String, Object> map){
		return cdao.clientList(map);
	}
	public Erp_ClientVO selectClient(int client_no) {
		return cdao.selectClienta4(client_no);
	}
	public Erp_ClientVO searchcl(Map<String, Object> map) {
		return cdao.searchcl(map);
	}	
	
	// team
	
	// bs
	public List<Erp_Bs3VO> bs3List(){
		return bs3dao.bs3List();
	}
	public List<Erp_Bs3VO> ctgrDebtor(int ctgr_no){
		return bs3dao.ctgrDebtor(ctgr_no);
	}
	public List<Erp_Bs3VO> ctgrCreditor(int ctgr_no){
		return bs3dao.ctgrCreditor(ctgr_no);
	}
	public Map<String, Object> getBsNo(int bs3_no){
		return bs3dao.getBsNo(bs3_no);
	}
	public int updateBs1Amount(Map<String, Object> map) {
		return bs3dao.updateBs1Amount(map);
	}
	public int updateBs2Amount(Map<String, Object> map) {
		return bs3dao.updateBs2Amount(map);
	}
	public int updateBs3Amount(Map<String, Object> map) {
		return bs3dao.updateBs3Amount(map);
	}
		
	//	debtor, creditor
	public Map<String, Object> autoDebtor(Map<String, Object> map){
		return dedao.autoDebtor(map);
	}
	public Map<String, Object> autoCreditor(Map<String, Object> map){
		return crdao.autoCreditor(map);
	}
		
	//	closing
	public int createClosing(Erp_ClosingVO vo) {
		return cldao.createClosing(vo);
	}
	public int updateClosing(Erp_ClosingVO vo) {
		return cldao.updateClosing(vo);
	}
	public int deleteClosing(int closing_no) {
		return cldao.deleteClosing(closing_no);
	}
	public int getClosingNo(String closing_code) {
		return cldao.getClosingNo(closing_code);
	}
	public Erp_ClosingVO getClosing(int closing_no) {
		return cldao.getClosing(closing_no);
	}	
	
	
	// <외화관리>
	// c2 xml 사용
	
	
}
