package com.lab.erp.dao.d.d1;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.d.d1.Erp_DefectiveVO;

@Component
public class Erp_DefectiveDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_DefectiveDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public int createDefective(Erp_DefectiveVO vo) {
		return sqlSession.insert("d1.createDefective", vo);
	}
	
	public int updateDefective(Erp_DefectiveVO vo) {
		return sqlSession.insert("d1.updateDefective", vo);
	}
	
	public int deleteDefective(int defective_no) {
		return sqlSession.insert("d1.deleteDefective", defective_no);
	}
	
	public List<Map<String, Object>> defectiveList(Map<String, Object> map){
		return sqlSession.selectList("d1.defectiveList", map);
	}
	
	public List<Map<String, Object>> defectiveListAll(Map<String, Object> map){
		return sqlSession.selectList("d1.defectiveListAll", map);
	}
	
	public Map<String, Object> selectDefective(int defective_no){
		return sqlSession.selectOne("d1.selectDefective", defective_no);
	}
	
	public Map<String, Object> selectDefectiveAll(int defective_no){
		return sqlSession.selectOne("d1.selectDefectiveAll", defective_no);
	}
	
}
