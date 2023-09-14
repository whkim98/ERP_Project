package com.lab.erp.dao.b.b7;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.b.b7.Erp_ToolsVO;

@Component
public class Erp_ToolsDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_ToolsDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public List<Map<String, Object>> selectTools(Map<String, Object> map){
		return sqlSession.selectList("b7.selectTools", map);
	}
	
	public int insertTools(Erp_ToolsVO vo) {
		return sqlSession.insert("b7.insertTools", vo);
	}
	
	public Map<String, Object> selectTools2(Map<String, Object> map){
		return sqlSession.selectOne("b7.selectTools2", map);
	}
	
	public int updateTools(Map<String, Object> map) {
		return sqlSession.update("b7.updateTools", map);
	}
	
	public int selectToolstotal(int tools_no) {
		return sqlSession.selectOne("b7.selectToolstotal", tools_no);
	}
	
}
