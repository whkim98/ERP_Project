package com.lab.erp.dao.d.d2;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.d.d2.Erp_InvenconnectVO;

@Component
public class Erp_InvenconnectDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_InvenconnectDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public int createInvenConnect(Erp_InvenconnectVO vo) {
		return sqlSession.insert("d2.createInvenConnect", vo);
	}
	
	public int updateInvenConnect(Erp_InvenconnectVO vo) {
		return sqlSession.update("d2.updateInvenConnect", vo);
	}
	
	public int deleteInvenConnect(int invenconnect_no) {
		return sqlSession.delete("d2.deleteInvenConnect", invenconnect_no);
	}
	
	public int deleteInvenConnectAll(int inventory_no) {
		return sqlSession.delete("d2.deleteInvenConnectAll", inventory_no);
	}
	
	public List<Map<String, Object>> selectInventoryGoods(Map<String, Object> map){
		return sqlSession.selectList("d2.selectInventoryGoods", map);
	}
	
}
