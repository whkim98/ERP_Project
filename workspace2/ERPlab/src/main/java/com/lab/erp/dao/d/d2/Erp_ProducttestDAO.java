package com.lab.erp.dao.d.d2;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.d.d2.Erp_ProducttestVO;

@Component
public class Erp_ProducttestDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_ProducttestDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public int createProductTest(Erp_ProducttestVO vo) {
		return sqlSession.insert("d2.createProductTest", vo);
	}
	
	public int updateProductTest(Erp_ProducttestVO vo) {
		return sqlSession.update("d2.updateProductTest", vo);
	}
	
	public int deleteProductTest(int producttest_no) {
		return sqlSession.delete("d2.deleteProductTest", producttest_no);
	}
	
	public List<Map<String, Object>> productTestList(Map<String, Object> map){
		return sqlSession.selectList("d2.productTestList", map);
	}
	
	public Map<String, Object> selectProductTest(int producttest_no){
		return sqlSession.selectOne("d2.selectProductTest", producttest_no);
	}
	
}
