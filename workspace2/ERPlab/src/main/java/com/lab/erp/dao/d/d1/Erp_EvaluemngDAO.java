package com.lab.erp.dao.d.d1;

import java.util.List;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.d.d1.Erp_EvaluemngVO;

@Component
public class Erp_EvaluemngDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_EvaluemngDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public int createEvaluemng(Erp_EvaluemngVO vo) {
		return sqlSession.insert("d1.createEvaluemng", vo);
	}
	
	public int updateEvaluemng(Erp_EvaluemngVO vo) {
		return sqlSession.insert("d1.updateEvaluemng", vo);
	}
	
	public int deleteEvaluemng(int evaluemng_no) {
		return sqlSession.insert("d1.deleteEvaluemng", evaluemng_no);
	}
	
	public int deleteEvmng(int evaluation_no) {
		return sqlSession.insert("d1.deleteEvmng", evaluation_no);
	}
	
	public List<Map<String, Object>> evmngList(Map<String, Object> map){
		return sqlSession.selectList("d1.evmngList", map);
	}
	
	public List<Integer> getEvaluemng(int evaluation_no){
		return sqlSession.selectList("d1.getEvaluemng", evaluation_no);
	}
	
	public Map<String, Object> selectEvmng(int evaluemng_no){
		return sqlSession.selectOne("d1.selectEvmng", evaluemng_no);
	}
	
}
