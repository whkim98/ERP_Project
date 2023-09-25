package com.lab.erp.service.d;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lab.erp.dao.c.Erp_ClientDAO;
import com.lab.erp.dao.c.c1.Erp_ForsalesDAO;
import com.lab.erp.dao.c.c1.Erp_ImportDAO;
import com.lab.erp.dao.c.c2.Erp_LocalsalesDAO;
import com.lab.erp.dao.c.c3.Erp_OnlineDAO;
import com.lab.erp.dao.c.c3.Erp_StoresalesDAO;
import com.lab.erp.dao.d.d2.Erp_PurchaseconnectDAO;
import com.lab.erp.dao.d.d6.Erp_GoodsDAO;
import com.lab.erp.dao.d.d6.Erp_GoodskindDAO;
import com.lab.erp.dao.d.d6.Erp_GoodslevDAO;
import com.lab.erp.dao.d.d6.Erp_GoodslotDAO;
import com.lab.erp.dao.d.d6.Erp_GoodsstDAO;
import com.lab.erp.vo.c.Erp_ClientVO;
import com.lab.erp.vo.d.d6.Erp_GoodskindVO;
import com.lab.erp.vo.d.d6.Erp_GoodslevVO;
import com.lab.erp.vo.d.d6.Erp_GoodsstVO;

@Service
public class D6Service {

	private Erp_GoodslotDAO gldao;
	private Erp_GoodskindDAO gkdao;
	private Erp_GoodsstDAO gsdao;
	private Erp_GoodslevDAO gvdao;
	private Erp_ClientDAO ecdao;
	private Erp_GoodsDAO gdao;
	
	//입출고관리
	private Erp_ForsalesDAO fdao;
	private Erp_ImportDAO idao;
	private Erp_LocalsalesDAO ldao;
	private Erp_StoresalesDAO sdao;
	private Erp_OnlineDAO odao;
	private Erp_PurchaseconnectDAO pdao;
	
	@Autowired
	public D6Service(Erp_PurchaseconnectDAO pdao, Erp_OnlineDAO odao, Erp_StoresalesDAO sdao, Erp_LocalsalesDAO ldao, Erp_ForsalesDAO fdao, Erp_ImportDAO idao, Erp_GoodsDAO gdao, Erp_GoodsstDAO gsdao, Erp_GoodslevDAO gvdao, Erp_ClientDAO ecdao, Erp_GoodslotDAO gldao, Erp_GoodskindDAO gkdao) {
		this.gldao = gldao;
		this.gkdao = gkdao;
		this.gsdao = gsdao;
		this.gvdao = gvdao;
		this.ecdao = ecdao;
		this.gdao = gdao;
		this.fdao = fdao;
		this.idao = idao;
		this.ldao = ldao;
		this.sdao = sdao;
		this.odao = odao;
		this.pdao = pdao;
	}
	
	public List<Map<String, Object>> selectGoods(Map<String, Object> map){
		return gldao.selectGoods(map);
	}
	
	public List<Erp_GoodskindVO> selectGoodskind(){
		return gkdao.selectGoodskind();
	}
	
	public List<Erp_GoodsstVO> selectGoodsst(){
		return gsdao.selectGoodsst();
	}
	
	public List<Erp_GoodslevVO> selectGoodslev(){
		return gvdao.selectGoodslev();
	}
	
	public List<Erp_ClientVO> selectClient(){
		return ecdao.selectClient();
	}
	
	public int insertGoods(Map<String, Object> map) {
		return gdao.insertGoods(map);
	}
	
	public int insertGoodslot(Map<String, Object> map) {
		return gldao.insertGoodslot(map);
	}
	
	public int selectGoodsno(String goods_code) {
		return gdao.selectGoodsno(goods_code);
	}
	
	public Map<String, Object> selectGoods2(Map<String, Object> map){
		return gldao.selectGoods2(map);
	}
	
	public int updateGoods2(Map<String, Object> map) {
		return gdao.updateGoods2(map);
	}
	
	public int updateGoodslot(Map<String, Object> map) {
		return gldao.updateGoodslot(map);
	}
	
	public int deleteGoodslot(Map<String, Object> map) {
		return gldao.deleteGoodslot(map);
	}
	
	public int updateQty(Map<String, Object> map) {
		return gdao.updateQty(map);
	}
	
	//입출고관리
	public List<Map<String, Object>> manageForsales(Map<String, Object> map){
		return fdao.manageForsales(map);
	}
	
	public List<Map<String, Object>> manageImport(Map<String, Object> map){
		return idao.manageImport(map);
	}
	
	public List<Map<String, Object>> manageLocalsales(Map<String, Object> map){
		return ldao.manageLocalsales(map);
	}
	
	public List<Map<String, Object>> manageStoresales(Map<String, Object> map){
		return sdao.manageStoresales(map);
	}
	
	public List<Map<String, Object>> manageOnline(Map<String, Object> map){
		return odao.manageOnline(map);
	}
	
	public List<Map<String, Object>> managePurchase(Map<String, Object> map){
		return pdao.managePurchase(map);
	}
	
	public int updateGoodslev(Map<String, Object> map) {
		return gdao.updateGoodslev(map);
	}
	
	public int insertGoodsst(Map<String, Object> map) {
		return gsdao.insertGoodsst(map);
	}
	
	public int selectGoodsstno(Map<String, Object> map) {
		return gsdao.selectGoodsstno(map);
	}
	
	public Map<String, Object> selectGoodsst2(Map<String, Object> map){
		return gsdao.selectGoodsst2(map);
	}
	
	public int updateGoodsst2(Map<String, Object> map) {
		return gsdao.updateGoodsst2(map);
	}
	
}
