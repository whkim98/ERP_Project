package com.lab.erp.dao.d.d1;

import java.util.List;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.d.d1.Erp_ProinventoryVO;

@Component
public class Erp_ProinventoryDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_ProinventoryDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public int createProInven(Erp_ProinventoryVO vo) {
		return sqlSession.insert("d1.createProInven", vo);
	}
	
	public int updateProInven(Erp_ProinventoryVO vo) {
		return sqlSession.insert("d1.updateProInven", vo);
	}
	
	public int deleteProInven(int proinventory_no) {
		return sqlSession.insert("d1.deleteProInven", proinventory_no);
	}
	
	public List<Map<String, Object>> proinvenList(Map<String, Object> map){
		return sqlSession.selectList("d1.proinvenList", map);
	}
	
	public Map<String, Object> selectPro(int proinventory_no){
		return sqlSession.selectOne("d1.selectPro", proinventory_no);
	}
	
	public List<Map<String, Object>> selectProInven(Map<String, Object> map){
		return sqlSession.selectList("d1.selectProInven", map);
	}
	
	public List<Map<String, Object>> coList(Map<String, Object> map){
		return sqlSession.selectList("d1.coList", map);
	}
	
	public int getProNo() {
		return sqlSession.selectOne("d1.getProNo");
	}
	
}
