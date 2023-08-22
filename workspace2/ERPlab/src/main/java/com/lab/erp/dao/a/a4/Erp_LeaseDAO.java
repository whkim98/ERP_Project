package com.lab.erp.dao.a.a4;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.a.a4.Erp_LeaseVO;

@Component
public class Erp_LeaseDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_LeaseDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public int createLease(Erp_LeaseVO vo) {
		return sqlSession.insert("a4.createLease", vo);
	}
	
	public int updateLease(Erp_LeaseVO vo) {
		return sqlSession.update("a4.updateLease", vo);
	}
	
	public int deleteLease(int lease_no) {
		return sqlSession.delete("a4.deleteLease", lease_no);
	}
	
	public List<Map<String, Object>> leaseList(Map<String, Object> map){
		return sqlSession.selectList("a4.leaseList", map);
	}
	
	public Map<String, Object> selectLease(Map<String, Object> map){
		return sqlSession.selectOne("a4.selectLease", map);
	}
	
}
