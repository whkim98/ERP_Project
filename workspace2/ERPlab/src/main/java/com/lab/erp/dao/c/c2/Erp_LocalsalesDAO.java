package com.lab.erp.dao.c.c2;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.c.c2.Erp_LocalsalesVO;

@Component
public class Erp_LocalsalesDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_LocalsalesDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public int inputLocalSales(Erp_LocalsalesVO vo) {
		return sqlSession.insert("c2.inputLocalSales", vo);
	}
	
	public int updateLocalSales(Erp_LocalsalesVO vo) {
		return sqlSession.update("c2.updateLocalSales", vo);
	}
	
	public int deleteLocalSales(int localsales_no) {
		return sqlSession.delete("c2.deleteLocasSales", localsales_no);
	}
	
	public List<Map<String, Object>> localSalesList(Map<String, Object> map){
		return sqlSession.selectList("c2.localSalesList", map);
	}
	
	public Map<String, Object> selectLocalSales(int localsales_no){
		return sqlSession.selectOne("c2.selectLocalSales", localsales_no);
	}
	
}
