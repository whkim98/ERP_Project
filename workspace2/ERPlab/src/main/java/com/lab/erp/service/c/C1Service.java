package com.lab.erp.service.c;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lab.erp.dao.a.a1.Erp_BusinesstypeDAO;
import com.lab.erp.dao.b.b1.Erp_Bs1DAO;
import com.lab.erp.dao.b.b1.Erp_ClosingDAO;
import com.lab.erp.dao.b.b1.Erp_CreditorDAO;
import com.lab.erp.dao.b.b1.Erp_DebtorDAO;
import com.lab.erp.dao.c.Erp_ClientDAO;
import com.lab.erp.dao.c.Erp_ReceivableDAO;
import com.lab.erp.dao.c.Erp_SalesgoodsDAO;
import com.lab.erp.dao.c.c1.Erp_ForsalesDAO;
import com.lab.erp.dao.c.c1.Erp_ImportDAO;
import com.lab.erp.dao.c.c1.Erp_ImportorderDAO;
import com.lab.erp.dao.c.c1.Erp_ImportpayDAO;
import com.lab.erp.dao.d.d6.Erp_GoodsDAO;
import com.lab.erp.vo.a.a1.Erp_BusinesstypeVO;
import com.lab.erp.vo.b.b1.Erp_Bs1VO;
import com.lab.erp.vo.b.b1.Erp_Bs2VO;
import com.lab.erp.vo.b.b1.Erp_Bs3VO;
import com.lab.erp.vo.b.b1.Erp_ClosingVO;
import com.lab.erp.vo.c.Erp_ClientVO;
import com.lab.erp.vo.c.Erp_ReceivableVO;
import com.lab.erp.vo.c.Erp_SalesgoodsVO;
import com.lab.erp.vo.c.c1.Erp_ForsalesVO;
import com.lab.erp.vo.c.c1.Erp_ImportVO;
import com.lab.erp.vo.c.c1.Erp_ImportorderVO;
import com.lab.erp.vo.c.c1.Erp_ImportpayVO;
import com.lab.erp.vo.d.d6.Erp_GoodsVO;

@Service
public class C1Service {

	private Erp_ClientDAO cdao;
	private Erp_ReceivableDAO rdao;
	private Erp_BusinesstypeDAO bdao;
	private Erp_ForsalesDAO fdao;
	private Erp_GoodsDAO gdao;
	private Erp_ImportpayDAO idao;
	private Erp_ImportorderDAO iodao;
	private Erp_ImportDAO ipdao;
	private Erp_SalesgoodsDAO sgdao;
	private Erp_ClosingDAO csdao;
	private Erp_Bs1DAO b1dao;
	private Erp_DebtorDAO ddao;
	private Erp_CreditorDAO cddao;
	
	@Autowired
	public C1Service(Erp_ClientDAO cdao, Erp_ReceivableDAO rdao, Erp_BusinesstypeDAO bdao, Erp_ForsalesDAO fdao, Erp_GoodsDAO gdao, Erp_ImportpayDAO idao, Erp_ImportorderDAO iodao, Erp_ImportDAO ipdao, Erp_SalesgoodsDAO sgdao, Erp_ClosingDAO csdao, Erp_Bs1DAO b1dao, Erp_DebtorDAO ddao, Erp_CreditorDAO cddao) {
		this.cdao = cdao;
		this.rdao = rdao;
		this.bdao = bdao;
		this.fdao = fdao;
		this.gdao = gdao;
		this.idao = idao;
		this.iodao = iodao;
		this.ipdao = ipdao;
		this.sgdao = sgdao;
		this.csdao = csdao;
		this.b1dao = b1dao;
		this.ddao = ddao;
		this.cddao = cddao;
	}
	
	public List<Map<String, Object>> internationList(Map<String, Object> map){
		return cdao.internationList(map);
	}
	
	public Map<String, Object> internationList2(Map<String, Object> map){
		return cdao.internationList2(map);
	}
	
	public int insertClient(Erp_ClientVO vo) {
		return cdao.insertClient(vo);
	}
	
	public int updateClient(Map<String, Object> map) {
		return cdao.updateClient(map);
	}
	
	public List<Erp_BusinesstypeVO> selectType(){
		return bdao.selectType();
	}
	
	public List<Map<String, Object>> selectForsales(Map<String, Object> map){
		return fdao.selectForsales(map);
	}
	
	public int insertForsales(Erp_ForsalesVO vo) {
		return fdao.insertForsales(vo);
	}
	
	public List<Erp_GoodsVO> selectGoods(){
		return gdao.selectGoods();
	}
	
//	public List<Erp_ImportpayVO> selectImportpay(){
//		return idao.selectImportpay();
//	}
	
	public int changeClient(Map<String, Object> map) {
		return cdao.changeClient(map);
	}
	
	public List<Map<String, Object>> selectImportorder(Map<String, Object> map){
		return iodao.selectImportorder(map);
	}
	
	public int insertImportorder(Erp_ImportorderVO vo) {
		return iodao.insertImportorder(vo);
	}
	
	public int updateStored(Map<String, Object> map) {
		return iodao.updateStored(map);
	}
	
	public List<Map<String, Object>> selectImport(Map<String, Object> map){
		return ipdao.selectImport(map);
	}
	
	public int insertImport(Erp_ImportVO vo) {
		return ipdao.insertImport(vo);
	}
	
	public int insertSalesgoods(Erp_SalesgoodsVO vo) {
		return sgdao.insertSalesgoods(vo);
	}
	
	public int insertGoods(Erp_GoodsVO vo) {
		return gdao.insertGoods(vo);
	}
	
	public int insertClosing(Erp_ClosingVO vo) {
		return csdao.insertClosing(vo);
	}
	
	public List<Erp_Bs1VO> selectBsd(){
		return b1dao.selectBsd();
	}
	
	public List<Erp_Bs1VO> selectBsc(){
		return b1dao.selectBsc();
	}
	
	public int selectBsno(int bs3_no) {
		return b1dao.selectBsno(bs3_no);
	}
	
	public int selectBsno2(int bs3_no) {
		return b1dao.selectBsno2(bs3_no);
	}
	
	public int updateBs3(Erp_Bs3VO vo) {
		return b1dao.updateBs3(vo);
	}
	
	public int updateBs2(Erp_Bs2VO vo) {
		return b1dao.updateBs2(vo);
	}
	
	public int updateBs(Erp_Bs1VO vo) {
		return b1dao.updateBs(vo);
	}
	
	public int selectSumqty(int salesgoods_no) {
		return sgdao.selectSumqty(salesgoods_no);
	}
	
	public Map<String, Object> selectimportUpdate(Map<String, Object> map){
		return ipdao.selectimportUpdate(map);
	}
	
	public Map<String, Object> selectimportUpdate2(Map<String, Object> map){
		return ipdao.selectimportUpdate2(map);
	}
	
	public int importUpdate(Map<String, Object> map) {
		return ipdao.importUpdate(map);
	}
	
	public int salesgoodsUpdate(Map<String, Object> map) {
		return sgdao.salesgoodsUpdate(map);
	}
	
	public int closingUpdate(Map<String, Object> map) {
		return csdao.closingUpdate(map);
	}
	
	public int selectCreditor(int bs3_no) {
		return cddao.selectCreditor(bs3_no);
	}
	
	public int selectDebtor(int bs3_no) {
		return ddao.selectDebtor(bs3_no);
	}
	
	public List<Map<String, Object>> selectImportpay(Map<String, Object> map){
		return idao.selectImportpay(map);
	}
	
	public int insertImportpay(Erp_ImportpayVO vo) {
		return idao.insertImportpay(vo);
	}
	
	public int updateImportpayable(Map<String, Object> map) {
		return idao.updateImportpayable(map);
	}
	
	public int selectSalesgoodsno(int importpay_no) {
		return idao.selectSalesgoodsno(importpay_no);
	}
	
	public int selectBs3no(int salesgoods_no) {
		return idao.selectBs3no(salesgoods_no);
	}
	
	public int insertClosingforsales(Erp_ClosingVO vo) {
		return csdao.insertClosingforsales(vo);
	}
	
	public int selectCreditorforsales(int bs3_no) {
		return cddao.selectCreditorforsales(bs3_no);
	}
	
	public int selectDebtorforsales(int bs3_no) {
		return ddao.selectDebtorforsales(bs3_no);
	}
	
	public Map<String, Object> selectIncomeupdate(Map<String, Object> map){
		return iodao.selectIncomeupdate(map);
	}
	
	public int selectSumprice(int goods_no) {
		return sgdao.selectSumprice(goods_no);
	}
	
	public int selectTax(int goods_no) {
		return sgdao.selectTax(goods_no);	
	}
	
	public int updateImportorder(Map<String, Object> map) {
		return iodao.updateImportorder(map);
	}
	
	public int selectImportorderno(String importorder_code) {
		return iodao.selectImportorderno(importorder_code);
	}
	
	public Map<String, Object> selectImportpayupdate(Map<String, Object> map){
		return idao.selectImportpayupdate(map);
	}
	
	public int updateImportpay(Map<String, Object> map) {
		return idao.updateImportpay(map);
	}
	
	public int updatePayable(Map<String, Object> map) {
		return idao.updatePayable(map);
	}
	
	public int selectTotal(int importorder_no) {
		return iodao.selectTotal(importorder_no);
	}
	
	public int selectClosingno(String closing_code) {
		return csdao.selectClosingno(closing_code);
	}
	
	public String selectImportblno(int import_no) {
		return ipdao.selectImportblno(import_no);
	}
	
	public int selectImportno(int importorder_no) {
		return ipdao.selectImportno(importorder_no);
	}
	
	public int updateClosing2(Map<String, Object> map) {
		return csdao.updateClosing2(map);
	}
	
	public List<Erp_ClientVO> selectClientlist(){
		return cdao.selectClientlist();
	}
	
	public List<Erp_GoodsVO> selectGoodslist(int client_no2){
		return gdao.selectGoodslist(client_no2);
	}
	
	public int selectImportpayno(int importorder_no) {
		return idao.selectImportpayno(importorder_no);
	}
	
	public Map<String, Object> selectGoodslist2(Map<String, Object> map){
		return gdao.selectGoodslist2(map);
	}
	
	public List<Erp_Bs1VO> selectBsd2(){
		return b1dao.selectBsd2();
	}
	
	public List<Erp_Bs1VO> selectBsc2(){
		return b1dao.selectBsc2();
	}
	
	public List<Erp_Bs1VO> selectBsd3(){
		return b1dao.selectBsd3();
	}
	
	public List<Erp_Bs1VO> selectBsc3(){
		return b1dao.selectBsc3();
	}
	
	public List<Erp_Bs1VO> selectDeb(String closing_code){
		return b1dao.selectDeb(closing_code);
	}
	
	public List<Erp_Bs1VO> selectCre(String closing_code){
		return b1dao.selectCre(closing_code);
	}
	
	public int selectCreditorno(int bs3_no) {
		return cddao.selectCreditorno(bs3_no);
	}
	
	public int selectDebtorno(int bs3_no) {
		return ddao.selectDebtorno(bs3_no);
	}
	
	public int selectImportorderno2(int import_no) {
		return ipdao.selectImportorderno2(import_no);
	}
	
	public int selectPrice(int goods_no) {
		return sgdao.selectPrice(goods_no);
	}
	
	public Map<String, Object> selectForsales2(Map<String, Object> map){
		return fdao.selectForsales2(map);
	}
	
	public int updateForsales(Map<String, Object> map) {
		return fdao.updateForsales(map);
	}
	
	public String forsalesBlno(int forsales_no) {
		return fdao.forsalesBlno(forsales_no);
	}
	
	public int selectClosingdb(String closing_code) {
		return csdao.selectClosingdb(closing_code);
	}
	
	public int selectClosingcr(String closing_code) {
		return csdao.selectClosingcr(closing_code);
	}
	
	public int updateClosing(Map<String, Object> map) {
		return csdao.updateClosing(map);
	}
	
	public int deleteImportorder(int importorder_no) {
		return iodao.deleteImportorder(importorder_no);
	}
	
	public int deleteImport(int importorder_no) {
		return ipdao.deleteImport(importorder_no);
	}
	
	public int deleteForsales(int forsales_no) {
		return fdao.deleteForsales(forsales_no);
	}
	
	public int updateClient2(Map<String, Object> map) {
		return cdao.updateClient2(map);
	}
	
	public int deleteClient2(int client_no) {
		return cdao.deleteClient2(client_no);
	}
	
	public int updateStored2(Map<String, Object> map) {
		return iodao.updateStored2(map);
	}
	
	public int selectDebtorno2(String closing_code) {
		return csdao.selectDebtorno2(closing_code);
	}
	
	public int selectCreditorno2(String closing_code) {
		return csdao.selectCreditorno2(closing_code);	
	}
	
	public int selectBs3Nod(int debtor_no) {
		return ddao.selectBs3Nod(debtor_no);
	}
	
	public int selectBs3Noc(int creditor_no) {
		return cddao.selectBs3Noc(creditor_no);
	}
	
}
