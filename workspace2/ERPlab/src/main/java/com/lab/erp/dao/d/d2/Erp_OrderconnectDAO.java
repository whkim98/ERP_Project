package com.lab.erp.dao.d.d2;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.d.d2.Erp_OrderconnectVO;

@Component
public class Erp_OrderconnectDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_OrderconnectDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public int createOrderConnect(Erp_OrderconnectVO vo) {
		return sqlSession.insert("d2.createOrderConnect", vo);
	}
	
	public int updateOrderConnect(Erp_OrderconnectVO vo) {
		return sqlSession.update("d2.updateOrderConnect", vo);
	}
	
	public int deleteOrderConnect(int orderconnect_no) {
		return sqlSession.delete("d2.deleteOrderConnect", orderconnect_no);
	}
	
	public int deleteOrderConnectAll(int order_no) {
		return sqlSession.delete("d2.deleteOrderConnectAll", order_no);
	}
	
	public List<Map<String, Object>> selectOrderGoods(Map<String, Object> map){
		return sqlSession.selectList("d2.selectOrderGoods", map);
	}
	
}
