package com.lab.erp.dao.c.c1;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.c.c1.Erp_ForsalesVO;

@Component
public class Erp_ForsalesDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_ForsalesDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public List<Map<String, Object>> selectForsales(Map<String, Object> map){
		return sqlSession.selectList("c1.selectForsales", map);
	}

	public int insertForsales(Erp_ForsalesVO vo) {
		return sqlSession.insert("c1.insertForsales", vo);
	}
	
	public Map<String, Object> selectForsales2(Map<String, Object> map){
		return sqlSession.selectOne("c1.selectForsales2", map);
	}
	
	public int updateForsales(Map<String, Object> map) {
		return sqlSession.update("c1.updateForsales", map);
	}
	
	public String forsalesBlno(int forsales_no) {
		return sqlSession.selectOne("c1.forsalesBlno", forsales_no);
	}
	
	public int deleteForsales(int forsales_no) {
		return sqlSession.delete("c1.deleteForsales", forsales_no);
	}
	
	public List<Map<String, Object>> manageForsales(Map<String, Object> map){
		return sqlSession.selectList("d6.manageForsales", map);
	}
	
}
