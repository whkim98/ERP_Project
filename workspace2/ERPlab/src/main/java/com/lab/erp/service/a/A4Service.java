package com.lab.erp.service.a;

import java.util.List;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lab.erp.dao.a.a4.Erp_ImkindDAO;
import com.lab.erp.dao.a.a4.Erp_InvestmentDAO;
import com.lab.erp.dao.a.a4.Erp_LeaseDAO;
import com.lab.erp.dao.a.a4.Erp_LeasetypeDAO;
import com.lab.erp.dao.a.a4.Erp_LoanDAO;
import com.lab.erp.dao.a.a4.Erp_RepayDAO;
import com.lab.erp.dao.b.b1.Erp_Bs3DAO;
import com.lab.erp.dao.b.b1.Erp_ClosingDAO;
import com.lab.erp.dao.b.b1.Erp_CreditorDAO;
import com.lab.erp.dao.b.b1.Erp_DebtorDAO;
import com.lab.erp.dao.b.b2.Erp_AccountDAO;
import com.lab.erp.dao.c.Erp_ClientDAO;
import com.lab.erp.vo.a.a4.Erp_ImkindVO;
import com.lab.erp.vo.a.a4.Erp_InvestmentVO;
import com.lab.erp.vo.a.a4.Erp_LeaseVO;
import com.lab.erp.vo.a.a4.Erp_LeasetypeVO;
import com.lab.erp.vo.a.a4.Erp_LoanVO;
import com.lab.erp.vo.a.a4.Erp_RepayVO;
import com.lab.erp.vo.b.b1.Erp_Bs3VO;
import com.lab.erp.vo.b.b1.Erp_ClosingVO;
import com.lab.erp.vo.b.b2.Erp_AccountVO;
import com.lab.erp.vo.c.Erp_ClientVO;

@Service
public class A4Service {
	private Erp_AccountDAO adao;
	private Erp_ClientDAO cdao;
	private Erp_Bs3DAO b3dao;
	private Erp_DebtorDAO ddao;
	private Erp_CreditorDAO crdao;
	private Erp_ClosingDAO cldao;
	private Erp_ImkindDAO imdao;
	private Erp_InvestmentDAO idao;
	private Erp_RepayDAO rdao;
	private Erp_LoanDAO lodao;
	private Erp_LeaseDAO ledao;
	private Erp_LeasetypeDAO ltdao;
	
	@Autowired
	public A4Service(Erp_RepayDAO rdao, Erp_AccountDAO adao, Erp_ImkindDAO imdao, Erp_InvestmentDAO idao, Erp_LoanDAO lodao, Erp_LeaseDAO ledao, Erp_LeasetypeDAO ltdao, Erp_ClientDAO cdao, Erp_Bs3DAO b3dao, Erp_CreditorDAO crdao, Erp_DebtorDAO ddao, Erp_ClosingDAO cldao) {
		this.adao = adao;
		this.cdao = cdao;
		this.b3dao = b3dao;
		this.ddao = ddao;
		this.crdao = crdao;
		this.cldao = cldao;
		this.imdao = imdao;
		this.idao = idao;
		this.rdao = rdao;
		this.lodao = lodao;
		this.ledao = ledao;
		this.ltdao = ltdao;
	}
	
//	account
	public List<Map<String, Object>> accountList(Map<String, Object> map){
		return adao.accountList(map);
	}
	public Erp_AccountVO selectAccount(int account_no) {
		return adao.selectAccount(account_no);
	}
	
	
//	client
	public List<Map<String, Object>> clientList(Map<String, Object> map){
		return cdao.clientList(map);
	}
	public Erp_ClientVO selectClient(int client_no) {
		return cdao.selectClienta4(client_no);
	}
	public Erp_ClientVO searchcl(Map<String, Object> map) {
		return cdao.searchcl(map);
	}
	
	
//	bs3
	public List<Erp_Bs3VO> bs3List(){
		return b3dao.bs3List();
	}
	public List<Erp_Bs3VO> ctgrDebtor(int ctgr_no){
		return b3dao.ctgrDebtor(ctgr_no);
	}
	public List<Erp_Bs3VO> ctgrCreditor(int ctgr_no){
		return b3dao.ctgrCreditor(ctgr_no);
	}
	public Map<String, Object> getBsNo(int bs3_no){
		return b3dao.getBsNo(bs3_no);
	}
	public int updateBs1Amount(Map<String, Object> map) {
		return b3dao.updateBs1Amount(map);
	}
	public int updateBs2Amount(Map<String, Object> map) {
		return b3dao.updateBs2Amount(map);
	}
	public int updateBs3Amount(Map<String, Object> map) {
		return b3dao.updateBs3Amount(map);
	}
	
	
//	debtor, creditor
	public Map<String, Object> autoDebtor(Map<String, Object> map){
		return ddao.autoDebtor(map);
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
	
	
//	imkind
	public List<Erp_ImkindVO> imkindList(){
		return imdao.imkindList();
	}
	public Erp_ImkindVO searchim(String imkind_name) {
		return imdao.searchim(imkind_name);
	}
	
	
//	investment
	public int createInvestment(Erp_InvestmentVO vo) {
		return idao.createInvestment(vo);
	}
	public int updateInvestment(Erp_InvestmentVO vo) {
		return idao.updateInvestment(vo);
	}
	public int deleteInvestment(int investment_no) {
		return idao.deleteInvestment(investment_no);
	}
	public List<Map<String, Object>> investmentList(Map<String, Object> map){
		return idao.investmentList(map);
	}
	public Map<String, Object> selectInvestment(Map<String, Object> map){
		return idao.selectInvestment(map);
	}
	public int getImCode(String investment_code) {
		return idao.getImCode(investment_code);
	}
	
	
//	repay
	public int inputRepay(Erp_RepayVO vo) {
		return rdao.inputRepay(vo);
	}
	public int updateRepay(Erp_RepayVO vo) {
		return rdao.updateRepay(vo);
	}
	public int deleteRepay(int repay_no) {
		return rdao.deleteRepay(repay_no);
	}
	public List<Erp_RepayVO> repayList(String repay_code){
		return rdao.repayList(repay_code);
	}
	public Map<String, Object> repayCode(String repay_code) {
		return rdao.repayCode(repay_code);
	}
	
	
//	loan
	public int createLoan(Erp_LoanVO vo) {
		return lodao.createLoan(vo);
	}
	public int updateLoan(Erp_LoanVO vo) {
		return lodao.updateLoan(vo);
	}
	public int deleteLoan(int loan_no) {
		return lodao.deleteLoan(loan_no);
	}
	public List<Map<String, Object>>loanList(Map<String, Object> map) {
		return lodao.loanList(map);
	}
	public Map<String, Object> selectLoan(Map<String, Object> map){
		return lodao.selectLoan(map);
	}
	
	
//	lease
	public int createLease(Erp_LeaseVO vo){ 
		return ledao.createLease(vo);
	}
	public int updateLease(Erp_LeaseVO vo) {
		return ledao.updateLease(vo);
	}
	public int deleteLease(int lease_no) {
		return ledao.deleteLease(lease_no);
	}
	public List<Map<String, Object>> leaseList(Map<String, Object> map){
		return ledao.leaseList(map);
	}
	public Map<String, Object> selectLease(Map<String, Object> map){
		return ledao.selectLease(map);
	}
	
	
//	leasetype
	public List<Erp_LeasetypeVO> leasetypeList(){
		return ltdao.leasetypeList();
	}
	public Erp_LeasetypeVO searchlt(String leasetype_name) {
		return ltdao.searchlt(leasetype_name);
	}
	
}
