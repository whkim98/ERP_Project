package com.lab.erp.dao.a.a3;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.a.a3.Erp_EstimateVO;

@Component
public class Erp_EstimateDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_EstimateDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public int createEstimate(Erp_EstimateVO vo) {
		return sqlSession.insert("a3.createEstimate", vo);
	}
	
	public int updateEstimate(Erp_EstimateVO vo) {
		return sqlSession.update("a3.updateEstimate", vo);
	}
	
	public int deleteEstimate(int estimate_no) {
		return sqlSession.delete("a3.deleteEstimate", estimate_no);
	}
	
	public List<Map<String, Object>> estimateList(Map<String, Object> map){
		return sqlSession.selectList("a3.estimateList", map);
	}
	
	public Map<String, Object> selectEstimate(Map<String, Object> map){
		return sqlSession.selectOne("a3.selectEstimate", map);
	}
	
	public int getTotalet(Map<String, Object> map) {
		return sqlSession.selectOne("a3.getTotalet", map);
	}
	
}
