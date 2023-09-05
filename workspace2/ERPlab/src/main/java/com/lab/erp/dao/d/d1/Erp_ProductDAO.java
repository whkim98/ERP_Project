package com.lab.erp.dao.d.d1;

import java.util.List;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.d.d1.Erp_ProductVO;

@Component
public class Erp_ProductDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_ProductDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public int createProduct(Erp_ProductVO vo) {
		return sqlSession.insert("d1.createProduct", vo);
	}
	
	public int updateProduct(Erp_ProductVO vo) {
		return sqlSession.insert("d1.updateProduct", vo);
	}
	
	public int deleteProduct(int product_no) {
		return sqlSession.insert("d1.deleteProduct", product_no);
	}
	
	public List<Map<String, Object>> productList(Map<String, Object> map){
		return sqlSession.selectList("d1.productList", map);
	}
	
	public Map<String, Object> selectProduct(int product_no){
		return sqlSession.selectOne("d1.selectProduct", product_no);
	}
	
	public List<Map<String, Object>> employee(Map<String, Object> map){
		return sqlSession.selectList("d1.employee", map);
	}
	
	public int getProductCode(String product_code) {
		return sqlSession.selectOne("d1.getProductCode", product_code);
	}
	
}
