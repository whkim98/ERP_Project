package com.lab.erp.dao.d.d2;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.d.d2.Erp_PurchaseconnectVO;

@Component
public class Erp_PurchaseconnectDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_PurchaseconnectDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public int createPurchaseConnect(Erp_PurchaseconnectVO vo) {
		return sqlSession.insert("d2.createPurchaseConnect", vo);
	}
	
	public int updatePurchaseConnect(Erp_PurchaseconnectVO vo) {
		return sqlSession.update("d2.updatePurchaseConnect", vo);
	}
	
	public int deletePurchaseConnect(int purchaseconnect_no) {
		return sqlSession.delete("d2.deletePurchaseConnect", purchaseconnect_no);
	}
	
	public int deletePurchaseConnectAll(int purchase_no) {
		return sqlSession.delete("d2.deletePurchaseConnectAll", purchase_no);
	}
	
	public List<Map<String, Object>> selectPurchaseGoods(Map<String, Object> map){
		return sqlSession.selectList("d2.selectPurchaseGoods", map);
	}
	
	//ㄱㅇㅎ
	public List<Map<String, Object>> managePurchase(Map<String, Object> map){
		return sqlSession.selectList("d6.managePurchase", map);
	}
	
}
