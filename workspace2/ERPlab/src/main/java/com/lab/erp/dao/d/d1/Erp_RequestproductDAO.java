package com.lab.erp.dao.d.d1;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.d.d1.Erp_RequestproductVO;

@Component
public class Erp_RequestproductDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_RequestproductDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public int createRequestProduct(Erp_RequestproductVO vo) {
		return sqlSession.insert("d1.createRequestProduct", vo);
	}
	
	public int updateRequestProduct(Erp_RequestproductVO vo) {
		return sqlSession.update("d1.updateRequestProduct", vo);
	}
	
	public int deleteRequestProduct(int requestproduct_no) {
		return sqlSession.delete("d1.deleteRequestProduct", requestproduct_no);
	}
	
	public List<Map<String, Object>> requestProductList(Map<String, Object> map){
		return sqlSession.selectList("d1.requestProductList", map);
	}
	
	public Map<String, Object> selectRequestProduct(int requestproduct_no){
		return sqlSession.selectOne("d1.selectRequestProduct", requestproduct_no);
	}
	
	public Map<String, Object> searchcl(Map<String, Object> map){
		return sqlSession.selectOne("d1.searchcl", map);
	}
	
	public Map<String, Object> searchecode(String employee1_code){
		return sqlSession.selectOne("d1.searchecode", employee1_code);
	}
	
	public int getRequestProductNo(String requestproduct_code) {
		return sqlSession.selectOne("d1.getRequestProductNo",requestproduct_code);
	}
	
}
