package com.lab.erp.dao.c.c1;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.c.c1.Erp_ImportVO;

@Component
public class Erp_ImportDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_ImportDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public List<Map<String, Object>> selectImport(Map<String, Object> map){
		return sqlSession.selectList("c1.selectImport", map);
	}
	
	public int insertImport(Erp_ImportVO vo) {
		return sqlSession.insert("c1.insertImport", vo);
	}
	
	public Map<String, Object> selectimportUpdate(Map<String, Object> map){
		return sqlSession.selectOne("c1.selectimportUpdate", map);
	}
	
	public Map<String, Object> selectimportUpdate2(Map<String, Object> map){
		return sqlSession.selectOne("c1.selectimportUpdate2", map);
	}
	
	public int importUpdate(Map<String, Object> map) {
		return sqlSession.update("c1.importUpdate", map);
	}
	
	public String selectImportblno(int import_no) {
		return sqlSession.selectOne("c1.selectImportblno", import_no);
	}
	
	public int selectImportno(int importorder_no) {
		return sqlSession.selectOne("c1.selectImportno", importorder_no);
	}
	
	public int selectImportorderno2(int import_no) {
		return sqlSession.selectOne("c1.selectImportorderno2", import_no);
	}
	
	public int deleteImport(int importorder_no) {
		return sqlSession.delete("c1.deleteImport", importorder_no);
	}
	
	public List<Map<String, Object>> manageImport(Map<String, Object> map){
		return sqlSession.selectList("d6.manageImport", map);
	}
	
}
