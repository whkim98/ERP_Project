package com.lab.erp.dao.c.c1;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.c.c1.Erp_ImportorderVO;

@Component
public class Erp_ImportorderDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_ImportorderDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public List<Map<String, Object>> selectImportorder(Map<String, Object> map){
		return sqlSession.selectList("c1.selectImportorder", map);
	}
	
	public int insertImportorder(Erp_ImportorderVO vo) {
		return sqlSession.insert("c1.insertImportorder", vo);
	}
	
	public int updateStored(Map<String, Object> map) {
		return sqlSession.update("c1.updateStored", map);
	}
	
	public Map<String, Object> selectIncomeupdate(Map<String, Object> map){
		return sqlSession.selectOne("c1.selectIncomeupdate", map);
	}
	
	public int updateImportorder(Map<String, Object> map) {
		return sqlSession.update("c1.updateImportorder", map);
	}
	
	public int selectImportorderno(String importorder_code) {
		return sqlSession.selectOne("c1.selectImportorderno", importorder_code);
	}
	
	public int selectTotal(int importorder_no) {
		return sqlSession.selectOne("c1.selectTotal", importorder_no);
	}
	
	public int deleteImportorder(int importorder_no) {
		return sqlSession.delete("c1.deleteImportorder", importorder_no);
	}
	
	public int updateStored2(Map<String, Object> map) {
		return sqlSession.update("c1.updatestored2", map);
	}
	
}
