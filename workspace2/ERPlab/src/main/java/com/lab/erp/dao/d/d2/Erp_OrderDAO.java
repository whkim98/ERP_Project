package com.lab.erp.dao.d.d2;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.d.d2.Erp_OrderVO;

@Component
public class Erp_OrderDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_OrderDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public int createOrder(Erp_OrderVO vo) {
		return sqlSession.insert("d2.createOrder", vo);
	}
	
	public int updateOrder(Erp_OrderVO vo) {
		return sqlSession.update("d2.updateOrder", vo);
	}
	
	public int updateOrderPrice(Erp_OrderVO vo) {
		return sqlSession.update("d2.updateOrderPrice", vo);
	}
	
	public int deleteOrder(int order_no) {
		return sqlSession.delete("d2.deleteOrder", order_no);
	}
	
	public List<Map<String, Object>> orderList(Map<String, Object> map){
		return sqlSession.selectList("d2.orderList", map);
	}
	
	public Map<String, Object> selectOrder(int order_no){
		return sqlSession.selectOne("d2.selectOrder", order_no);
	}
	
	public int getOrderNo(String order_code) {
		return sqlSession.selectOne("d2.getOrderNo", order_code);
	}
	
}
