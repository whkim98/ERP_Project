package com.lab.erp.dao.d.d2;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.d.d2.Erp_InventoryVO;

@Component
public class Erp_InventoryDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_InventoryDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public int createInventory(Erp_InventoryVO vo) {
		return sqlSession.insert("d2.createInventory", vo);
	}
	
	public int updateInventory(Erp_InventoryVO vo) {
		return sqlSession.update("d2.updateInventory", vo);
	}
	
	public int deleteInventory(int inventory_no) {
		return sqlSession.delete("d2.deleteInventory", inventory_no);
	}
	
	public List<Map<String, Object>> inventoryList(Map<String, Object> map){
		return sqlSession.selectList("d2.inventoryList", map);
	}
	
	public Map<String, Object> selectInventory(int inventory_no){
		return sqlSession.selectOne("d2.selectInventory", inventory_no);
	}
	
	public int getInventoryNo(Erp_InventoryVO vo) {
		return sqlSession.selectOne("d2.getInventoryNo", vo);
	}
	
}
