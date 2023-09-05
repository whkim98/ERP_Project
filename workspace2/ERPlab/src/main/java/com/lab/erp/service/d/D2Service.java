package com.lab.erp.service.d;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lab.erp.dao.b.b1.Erp_Bs3DAO;
import com.lab.erp.dao.b.b1.Erp_ClosingDAO;
import com.lab.erp.dao.c.Erp_ClientDAO;
import com.lab.erp.dao.d.d2.Erp_InvenconnectDAO;
import com.lab.erp.dao.d.d2.Erp_InventoryDAO;
import com.lab.erp.dao.d.d2.Erp_OrderDAO;
import com.lab.erp.dao.d.d2.Erp_OrderconnectDAO;
import com.lab.erp.dao.d.d2.Erp_ProducttestDAO;
import com.lab.erp.dao.d.d2.Erp_PtkindDAO;
import com.lab.erp.dao.d.d2.Erp_PurchaseDAO;
import com.lab.erp.dao.d.d2.Erp_PurchaseconnectDAO;
import com.lab.erp.dao.d.d6.Erp_GoodsDAO;
import com.lab.erp.dao.d.d6.Erp_GoodslotDAO;
import com.lab.erp.dao.login.Erp_TeamDAO;
import com.lab.erp.vo.b.b1.Erp_Bs3VO;
import com.lab.erp.vo.b.b1.Erp_ClosingVO;
import com.lab.erp.vo.c.Erp_ClientVO;
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

@Service
public class D2Service {
	private Erp_OrderDAO odao;
	private Erp_OrderconnectDAO ocdao;
	private Erp_PurchaseDAO pdao;
	private Erp_PurchaseconnectDAO pcdao;
	private Erp_ProducttestDAO ptdao;
	private Erp_PtkindDAO pkdao;
	private Erp_InventoryDAO idao;
	private Erp_InvenconnectDAO icdao;
	
	private Erp_Bs3DAO b3dao;
	private Erp_ClosingDAO cdao;
	
	private Erp_ClientDAO cldao;
	private Erp_TeamDAO tdao;
	private Erp_GoodsDAO gdao;
	private Erp_GoodslotDAO gldao;
	
	@Autowired
	public D2Service(Erp_OrderDAO odao, Erp_OrderconnectDAO ocdao, Erp_PurchaseDAO pdao, Erp_PurchaseconnectDAO pcdao,
			Erp_ProducttestDAO ptdao, Erp_InventoryDAO idao, Erp_InvenconnectDAO icdao, Erp_Bs3DAO b3dao,
			Erp_ClosingDAO cdao, Erp_ClientDAO cldao, Erp_TeamDAO tdao, Erp_PtkindDAO pkdao, Erp_GoodsDAO gdao, Erp_GoodslotDAO gldao) {
		this.odao = odao;
		this.ocdao = ocdao;
		this.pdao = pdao;
		this.pcdao = pcdao;
		this.ptdao = ptdao;
		this.idao = idao;
		this.icdao = icdao;
		this.b3dao = b3dao;
		this.cdao = cdao;
		this.cldao = cldao;
		this.tdao = tdao;
		this.pkdao = pkdao;
		this.gdao = gdao;
		this.gldao = gldao;
	}
	
	
//	goods
	public List<Map<String, Object>> goodsListd2(Map<String, Object> map){
		return gdao.goodsListd2(map);
	}
	
	public int updateGoodsOne(Erp_GoodsVO vo) {
		return gdao.updateGoodsOne(vo);
	}
	
	public int updateGoodsSub(Erp_GoodsVO vo) {
		return gdao.updateGoodsSub(vo);
	}
	
	public int updateLotQtyOne(Erp_GoodslotVO vo) {
		return gldao.updateLotQtyOne(vo);
	}
	
	public int updateLotQtySub(Erp_GoodslotVO vo) {
		return gldao.updateLotQtySub(vo);
	}
	
	
//	clientgoods
	public List<Map<String, Object>> selectClient2Goods(Map<String, Object> map){
		return cldao.selectClient2Goods(map);
	}
	public List<Map<String, Object>> selectClient2Goodsd22(Map<String, Object> map){
		return cldao.selectClient2Goodsd22(map);
	}
	
	
//	client
	public Erp_ClientVO searchcl(Map<String, Object> map) {
		return cldao.searchcl(map);
	}
	public List<Map<String, Object>> clientList(Map<String, Object> map){
		return cldao.clientList(map);
	}
	public Map<String, Object> searchcld2(Map<String, Object> map) {
		return cldao.searchcld2(map);
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
	
	
//	closing
	public int createClosing(Erp_ClosingVO vo) {
		return cdao.createClosing(vo);
	}
	
	public int updateClosing(Erp_ClosingVO vo) {
		return cdao.updateClosing(vo);
	}
	
	public int deleteClosing(int closing_no) {
		return cdao.deleteClosing(closing_no);
	}
	
	public int getClosingNo(String closing_code) {
		return cdao.getClosingNo(closing_code);
	}
	
	public Erp_ClosingVO getClosing(int closing_no) {
		return cdao.getClosing(closing_no);
	}
	
//	b4
	public Erp_ClosingVO totalAmount(Map<String, Object> map) {
		return cdao.totalAmount(map);
	}
	
	public List<Map<String, Object>> selectCtgr(Map<String, Object> map) {
		return cdao.selectCtgr(map);
	}
	
	public Erp_ClosingVO ctgrAmount(Map<String, Object> map) {
		return cdao.ctgrAmount(map);
	}
	
//	d1
	public Map<String, Object> getClosingCode(String closing_code){
		return cdao.getClosingCode(closing_code);
	}
	
	public int updateClosingPrice(Erp_ClosingVO vo) {
		return cdao.updateClosingPrice(vo);
	}
	
	
//	order
	public int createOrder(Erp_OrderVO vo) {
		return odao.createOrder(vo);
	}
	
	public int updateOrder(Erp_OrderVO vo) {
		return odao.updateOrder(vo);
	}
	
	public int updateOrderPrice(Erp_OrderVO vo) {
		return odao.updateOrderPrice(vo);
	}
	
	public int deleteOrder(int order_no) {
		return odao.deleteOrder(order_no);
	}
	
	public List<Map<String, Object>> orderList(Map<String, Object> map){
		return odao.orderList(map);
	}
	
	public Map<String, Object> selectOrder(int order_no){
		return odao.selectOrder(order_no);
	}
	
	public int getOrderNo(String order_code) {
		return odao.getOrderNo(order_code);
	}
	
	
//	orderconnect
	public int createOrderConnect(Erp_OrderconnectVO vo) {
		return ocdao.createOrderConnect(vo);
	}
	
	public int updateOrderConnect(Erp_OrderconnectVO vo) {
		return ocdao.updateOrderConnect(vo);
	}
	
	public int deleteOrderConnect(int orderconnect_no) {
		return ocdao.deleteOrderConnect(orderconnect_no);
	}
	
	public int deleteOrderConnectAll(int order_no) {
		return ocdao.deleteOrderConnectAll(order_no);
	}
	
	public List<Map<String, Object>> selectOrderGoods(Map<String, Object> map){
		return ocdao.selectOrderGoods(map);
	}
	
	
//	purchase
	public int createPurchase(Erp_PurchaseVO vo) {
		return pdao.createPurchase(vo);
	}
	
	public int updatePurchase(Erp_PurchaseVO vo) {
		return pdao.updatePurchase(vo);
	}
	
	public int updatePurchasePrice(Erp_PurchaseVO vo) {
		return pdao.updatePurchasePrice(vo);
	}
	
	public int deletePurchase(int purchase_no) {
		return pdao.deletePurchase(purchase_no);
	}
	
	public List<Map<String, Object>> purchaseList(Map<String, Object> map){
		return pdao.purchaseList(map);
	}
	
	public List<Map<String, Object>> purchaseGoods(Map<String, Object> map){
		return pdao.purchaseGoods(map);
	}
	
	public Map<String, Object> selectPurchase(int purchase_no){
		return pdao.selectPurchase(purchase_no);
	}
	
	public int getPurchaseNo(String purchase_code) {
		return pdao.getPurchaseNo(purchase_code);
	}
	
	
//	purchaseconnect
	public int createPurchaseConnect(Erp_PurchaseconnectVO vo) {
		return pcdao.createPurchaseConnect(vo);
	}
	
	public int updatePurchaseConnect(Erp_PurchaseconnectVO vo) {
		return pcdao.updatePurchaseConnect(vo);
	}
	
	public int deletePurchaseConnect(int purchaseconnect_no) {
		return pcdao.deletePurchaseConnect(purchaseconnect_no);
	}
	
	public int deletePurchaseConnectAll(int purchase_no) {
		return pcdao.deletePurchaseConnectAll(purchase_no);
	}
	
	public List<Map<String, Object>> selectPurchaseGoods(Map<String, Object> map){
		return pcdao.selectPurchaseGoods(map);
	}
	
	
//	producttest
	public int createProductTest(Erp_ProducttestVO vo) {
		return ptdao.createProductTest(vo);
	}
	
	public int updateProductTest(Erp_ProducttestVO vo) {
		return ptdao.updateProductTest(vo);
	}
	
	public int deleteProductTest(int producttest_no) {
		return ptdao.deleteProductTest(producttest_no);
	}
	
	public List<Map<String, Object>> productTestList(Map<String, Object> map){
		return ptdao.productTestList(map);
	}
	
	public Map<String, Object> selectProductTest(int producttest_no){
		return ptdao.selectProductTest(producttest_no);
	}
	
	public List<Erp_PtkindVO> ptList(){
		return pkdao.ptList();
	}
	
	
//	inventory
	public int createInventory(Erp_InventoryVO vo) {
		return idao.createInventory(vo);
	}
	
	public int updateInventory(Erp_InventoryVO vo) {
		return idao.updateInventory(vo);
	}
	
	public int deleteInventory(int inventory_no) {
		return idao.deleteInventory(inventory_no);
	}
	
	public List<Map<String, Object>> inventoryList(Map<String, Object> map){
		return idao.inventoryList(map);
	}
	
	public Map<String, Object> selectInventory(int inventory_no){
		return idao.selectInventory(inventory_no);
	}
	
	public int getInventoryNo(Erp_InventoryVO vo) {
		return idao.getInventoryNo(vo);
	}
	
	
//	invenconnect
	public int createInvenConnect(Erp_InvenconnectVO vo) {
		return icdao.createInvenConnect(vo);
	}
	
	public int updateInvenConnect(Erp_InvenconnectVO vo) {
		return icdao.updateInvenConnect(vo);
	}
	
	public int deleteInvenConnect(int invenconnect_no) {
		return icdao.deleteInvenConnect(invenconnect_no);
	}
	
	public int deleteInvenConnectAll(int inventory_no) {
		return icdao.deleteInvenConnectAll(inventory_no);
	}
	
	public List<Map<String, Object>> selectInventoryGoods(Map<String, Object> map){
		return icdao.selectInventoryGoods(map);
	}
	
}
