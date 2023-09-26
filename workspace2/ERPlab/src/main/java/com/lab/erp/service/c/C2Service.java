package com.lab.erp.service.c;

import java.util.List;


import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lab.erp.dao.a.a1.Erp_BusinesstypeDAO;
import com.lab.erp.dao.b.b1.Erp_Bs3DAO;
import com.lab.erp.dao.b.b1.Erp_ClosingDAO;
import com.lab.erp.dao.c.Erp_BondbillsDAO;
import com.lab.erp.dao.c.Erp_ClientDAO;
import com.lab.erp.dao.c.Erp_ClientsortDAO;
import com.lab.erp.dao.c.Erp_CountryDAO;
import com.lab.erp.dao.c.Erp_GoodsconnectDAO;
import com.lab.erp.dao.c.Erp_ReceivableDAO;
import com.lab.erp.dao.c.Erp_SalesgoodsDAO;
import com.lab.erp.dao.c.c2.Erp_LocalsalesDAO;
import com.lab.erp.dao.c.c2.Erp_ReturnDAO;
import com.lab.erp.dao.d.d6.Erp_GoodsDAO;
import com.lab.erp.dao.d.d6.Erp_GoodslotDAO;
import com.lab.erp.vo.a.a1.Erp_BusinesstypeVO;
import com.lab.erp.vo.b.b1.Erp_Bs3VO;
import com.lab.erp.vo.b.b1.Erp_ClosingVO;
import com.lab.erp.vo.b.b3.Erp_SettletypeVO;
import com.lab.erp.vo.c.Erp_BondbillsVO;
import com.lab.erp.vo.c.Erp_ClientVO;
import com.lab.erp.vo.c.Erp_ClientsortVO;
import com.lab.erp.vo.c.Erp_CountryVO;
import com.lab.erp.vo.c.Erp_GoodsconnectVO;
import com.lab.erp.vo.c.Erp_ReceivableVO;
import com.lab.erp.vo.c.Erp_SalesgoodsVO;
import com.lab.erp.vo.c.c2.Erp_LocalsalesVO;
import com.lab.erp.vo.c.c2.Erp_ReturnVO;
import com.lab.erp.vo.d.d6.Erp_GoodsVO;
import com.lab.erp.vo.d.d6.Erp_GoodslotVO;

@Service
public class C2Service {
	private Erp_Bs3DAO bsdao;
	private Erp_ClosingDAO cldao;
	private Erp_GoodsDAO gsdao;
	private Erp_GoodslotDAO gldao;
	
	private Erp_SalesgoodsDAO sgdao;
	
	private Erp_ClientDAO cdao;
	private Erp_GoodsconnectDAO gcdao;
	private Erp_ClientsortDAO csdao;
	private Erp_BusinesstypeDAO bdao;
	private Erp_CountryDAO ctdao;
	
	private Erp_ReceivableDAO rdao;
	private Erp_BondbillsDAO bbdao;
	private Erp_ReturnDAO redao;
	private Erp_LocalsalesDAO ldao;
	
	@Autowired
	public C2Service(Erp_ClientDAO cdao, Erp_GoodsconnectDAO gcdao, Erp_ClientsortDAO csdao, 
			Erp_BusinesstypeDAO bdao, Erp_CountryDAO ctdao, Erp_ReceivableDAO rdao, 
			Erp_BondbillsDAO bbdao, Erp_ReturnDAO redao, Erp_LocalsalesDAO ldao, 
			Erp_Bs3DAO bsdao, Erp_ClosingDAO cldao, Erp_GoodsDAO gsdao, Erp_SalesgoodsDAO sgdao, 
			Erp_GoodslotDAO gldao) {
		this.bsdao = bsdao;
		this.cldao = cldao;
		this.gsdao = gsdao;
		this.gldao = gldao;
		
		this.sgdao = sgdao;
		
		this.cdao = cdao;
		this.gcdao = gcdao;
		this.csdao = csdao;
		this.bdao = bdao;
		this.ctdao = ctdao;
		
		this.rdao = rdao;
		this.bbdao = bbdao;
		this.redao = redao;
		this.ldao = ldao;
	}
	
//	계정과목
	public List<Erp_Bs3VO> ctgrDebtor(int ctgr_no){
		return bsdao.ctgrDebtor(ctgr_no);
	}
	public List<Erp_Bs3VO> ctgrCreditor(int ctgr_no){
		return bsdao.ctgrCreditor(ctgr_no);
	}
	public Map<String, Object> getBsNo(int bs3_no){
		return bsdao.getBsNo(bs3_no);
	}
	public int updateBs1Amount(Map<String, Object> map) {
		return bsdao.updateBs1Amount(map);
	}
	public int updateBs2Amount(Map<String, Object> map) {
		return bsdao.updateBs2Amount(map);
	}
	public int updateBs3Amount(Map<String, Object> map) {
		return bsdao.updateBs3Amount(map);
	}
	
//	일마감
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
	
//	거래처
	public int createClient(Erp_ClientVO vo) {
		return cdao.createClient(vo);
	}
	
	public int updateClient(Erp_ClientVO vo) {
		return cdao.updateClient(vo);
	}
	
	public int deleteClient(int client_no) {
		return cdao.deleteClient(client_no);
	}
	
	public List<Map<String, Object>> clientListb4(Map<String, Object> map){
		return cdao.clientListb4(map);
	}
	
	public Map<String, Object> selectClientb4(int client_no){
		return cdao.selectClientb4(client_no);
	}
	
	public int getClNo(String client_registeredno) {
		return cdao.getClNo(client_registeredno);
	}
	
	public List<Map<String, Object>> clientGoods(int client_no){
		return gcdao.clientGoods(client_no);
	}
	public int inputGC(Erp_GoodsconnectVO vo) {
		return gcdao.inputGC(vo);
	}
	public int updateGC(Erp_GoodsconnectVO vo) {
		return gcdao.updateGC(vo);
	}
	public int deleteGCClient(int client_no) {
		return gcdao.deleteGCClient(client_no);
	}
	public int deleteGCNo(int goodsconnect_no) {
		return gcdao.deleteGCNo(goodsconnect_no);
	}
	
	public List<Erp_ClientsortVO> csList(Map<String, Object> map) {
		return csdao.csList(map);
	}
	
	public List<Erp_CountryVO> countryList(Map<String, Object> map) {
		return ctdao.countryList(map);
	}
	
	public List<Erp_BusinesstypeVO> btList(Map<String, Object> map){
		return bdao.btList(map);
	}
	
	public List<Erp_BusinesstypeVO> btSubctgr(Map<String, Object> map) {
		return bdao.btSubctgr(map);
	}
	
	public List<Erp_BusinesstypeVO> btName(Map<String, Object> map) {
		return bdao.btName(map);
	}
	
	public Erp_CountryVO autoCountry(String country_name) {
		return ctdao.autoCountry(country_name);
	}
	
	public Erp_ClientsortVO autoSort(String clientsort_name) {
		return csdao.autoSort(clientsort_name);
	}
	
	
//	채권 / 수금
	public int createReceivable(Erp_ReceivableVO vo) {
		return rdao.createReceivable(vo);
	}
	
	public int updateReceivable(Erp_ReceivableVO vo) {
		return rdao.updateReceivable(vo);
	}
	
	public int updateReceiveTotal(Erp_ReceivableVO vo) {
		return rdao.updateReceiveTotal(vo);
	}
	
	public int finishCollect(Erp_ReceivableVO vo) {
		return rdao.finishCollect(vo);
	}
	
	public int deleteReceivable(int receivable_no) {
		return rdao.deleteReceivable(receivable_no);
	}
	
	public List<Map<String, Object>> receivableList(Map<String, Object> map){
		return rdao.receivableList(map);
	}
	
	public Map<String, Object> selectReceivable(int receivable_no){
		return rdao.selectReceivable(receivable_no);
	}
	
	public int getUniqueCIno(String receivable_cino) {
		return rdao.getUniqueCIno(receivable_cino);
	}
	public int getUniqueCode(String receivable_code) {
		return rdao.getUniqueCode(receivable_code);
	}
	
	public int getReceivableTotal(int receivable_no) {
		return rdao.getReceivableTotal(receivable_no);
	}
	
	public int inputBills(Erp_BondbillsVO vo) {
		return bbdao.inputBills(vo);
	}
	
	public int updateBills(Erp_BondbillsVO vo) {
		return bbdao.updateBills(vo);
	}
	
	public int deleteBills(int bondbills_no) {
		return bbdao.deleteBills(bondbills_no);
	}
	
	public int deleteReceive(int receivable_no) {
		return rdao.deleteReceive(receivable_no);
	}
	
	public List<Map<String, Object>> bondbillsList(Map<String, Object> map){
		return bbdao.bondbillsList(map);
	}
	
	public List<Map<String, Object>> receiveBondbills(Map<String, Object> map){
		return bbdao.receiveBondbills(map);
	}
	
	public Map<String, Object> selectBondbills(int bondbills_no){
		return bbdao.selectBondbills(bondbills_no);
	}
	
	public Erp_BondbillsVO getBillsTotal(int receivable_no) {
		return bbdao.getBillsTotal(receivable_no);
	}
	
	public int getBondbillsCode(String bondbills_code) {
		return bbdao.getBondbillsCode(bondbills_code);
	}
	
	
//	반품
	public int inputReturn(Erp_ReturnVO vo) {
		return redao.inputReturn(vo);
	}
	
	public int updateReturn(Erp_ReturnVO vo) {
		return redao.updateReturn(vo);
	}
	
	public int deleteReturn(int return_no) {
		return redao.deleteReturn(return_no);
	}
	
	public List<Map<String, Object>> returnList(Map<String, Object> map){
		return redao.returnList(map);
	}
	
	public Map<String, Object> selectReturn(int return_no){
		return redao.selectReturn(return_no);
	}
	
	public Erp_ReturnVO getReturn(int return_no) {
		return redao.getReturn(return_no);
	}
	
	public int getReturnCode(String return_code) {
		return redao.getReturnCode(return_code);
	}
	
	
//	국내영업매출
	public int inputLocalSales(Erp_LocalsalesVO vo) {
		return ldao.inputLocalSales(vo);
	}
	
	public int updateLocalSales(Erp_LocalsalesVO vo) {
		return ldao.updateLocalSales(vo);
	}
	
	public int updateLocalPrice(Erp_LocalsalesVO vo) {
		return ldao.updateLocalPrice(vo);
	}
	
	public int deleteLocalSales(int localsales_no) {
		return ldao.deleteLocalSales(localsales_no);
	}
	
	public List<Map<String, Object>> localSalesList(Map<String, Object> map){
		return ldao.localSalesList(map);
	}
	
	public Map<String, Object> selectLocalSales(int localsales_no){
		return ldao.selectLocalSales(localsales_no);
	}
	
	public List<Erp_SettletypeVO> getCondition(){
		return ldao.getCondition();
	}
	
	public List<Erp_SettletypeVO> getSettleList(){
		return ldao.getSettleList();
	}
	
	public int getLocasCino(String localsales_cino) {
		return ldao.getLocasCino(localsales_cino);
	}
	
//	goods
	public List<Map<String, Object>> goodsList(Map<String, Object> map){
		return gsdao.goodsList(map);
	}
	public  List<Map<String, Object>> goodsReturn(Map<String, Object> map){
		return gsdao.goodsReturn(map);
	}
	public int updateGoodsOne(Erp_GoodsVO vo) {
		return gsdao.updateGoodsOne(vo);
	}
	public int updateGoodsSub(Erp_GoodsVO vo) {
		return gsdao.updateGoodsSub(vo);
	}
	
	public List<Map<String, Object>> goodsLotList(Map<String, Object> map){
		return gsdao.goodsLotList(map);
	}
	
	
//	goodslot
	public int updateLotQtyOne(Erp_GoodslotVO vo) {
		return gldao.updateLotQtyOne(vo);
	}
	
	public int updateLotQtySub(Erp_GoodslotVO vo) {
		return gldao.updateLotQtySub(vo);
	}
	
	
	
//	salesgoods
	public int inputSalesGoods(Erp_SalesgoodsVO vo) {
		return sgdao.inputSalesGoods(vo);
	}
	public int updateSGNo(Erp_SalesgoodsVO vo) {
		return sgdao.updateSGNo(vo);
	}
	public int deleteSGNo(int salesgoods_no) {
		return sgdao.deleteSGNo(salesgoods_no);
	}
	public int deleteSGCode(String salesgoods_code) {
		return sgdao.deleteSGCode(salesgoods_code);
	}
	public List<Erp_SalesgoodsVO> getSGNo(String salesgoods_code){
		return sgdao.getSGNo(salesgoods_code);
	}
	public List<Map<String, Object>> getSalesGoods(String salesgoods_code){
		return sgdao.getSalesGoods(salesgoods_code);
	}
}
