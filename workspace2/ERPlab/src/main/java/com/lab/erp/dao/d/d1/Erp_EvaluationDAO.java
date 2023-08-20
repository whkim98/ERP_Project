package com.lab.erp.dao.d.d1;

import java.util.List;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.d.d1.Erp_EvaluationVO;

@Component
public class Erp_EvaluationDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_EvaluationDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public int createEvaluation(Erp_EvaluationVO vo) {
		return sqlSession.insert("d1.createEvaluation", vo);
	}
	
	public int updateEvaluation(Erp_EvaluationVO vo) {
		return sqlSession.insert("d1.updateEvaluation", vo);
	}
	
	public int deleteEvaluation(int evaluation_no) {
		return sqlSession.insert("d1.deleteEvaluation", evaluation_no);
	}
	
	public List<Map<String, Object>> evaluationList(Map<String, Object> map){
		return sqlSession.selectList("d1.evaluationList", map);
	}
	
	public Map<String, Object> selectEvaluation(int evaluation_no){
		return sqlSession.selectOne("d1.selectEvaluation", evaluation_no);
	}
	
}
