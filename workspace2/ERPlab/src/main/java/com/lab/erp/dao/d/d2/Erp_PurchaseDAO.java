package com.lab.erp.dao.d.d2;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.d.d2.Erp_PurchaseVO;

@Component
public class Erp_PurchaseDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_PurchaseDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public int createPurchase(Erp_PurchaseVO vo) {
		return sqlSession.insert("d2.createPurchase", vo);
	}
	
	public int updatePurchase(Erp_PurchaseVO vo) {
		return sqlSession.update("d2.updatePurchase", vo);
	}
	
	public int updatePurchasePrice(Erp_PurchaseVO vo) {
		return sqlSession.update("d2.updatePurchasePrice", vo);
	}
	
	public int deletePurchase(int purchase_no) {
		return sqlSession.delete("d2.deletePurchase", purchase_no);
	}
	
	public List<Map<String, Object>> purchaseList(Map<String, Object> map){
		return sqlSession.selectList("d2.purchaseList", map);
	}
	
	public List<Map<String, Object>> purchaseGoods(Map<String, Object> map){
		return sqlSession.selectList("d2.purchaseGoods", map);
	}
	
	public Map<String, Object> selectPurchase(int purchase_no){
		return sqlSession.selectOne("d2.selectPurchase", purchase_no);
	}
	
	public int getPurchaseNo(String purchase_code) {
		return sqlSession.selectOne("d2.getPurchaseNo", purchase_code);
	}
	
}
