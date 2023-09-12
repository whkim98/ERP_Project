package com.lab.erp.dao.b.b3;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.b.b3.Erp_StatementVO;

@Component
public class Erp_StatementDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_StatementDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	public int insertStatement(Erp_StatementVO vo) {
		return sqlSession.insert("b3.insertStatement", vo);
	}
	
	public int updateStatement(Erp_StatementVO vo) {
		return sqlSession.update("b3.updateStatement", vo);
	}
	
	public int deleteStatement(int statement_no) {
		return sqlSession.delete("b3.deleteStatement", statement_no);
	}
	
	
	public List<Map<String, Object>> statementList(Map<String, Object> map){
		return sqlSession.selectList("b3.statementList", map);
	}
	
	public Map<String, Object> selectStatement(Map<String, Object> map){
		return sqlSession.selectOne("b3.selectStatement", map);
	}
	
	public int getStatementCode(String statement_code) {
		return sqlSession.selectOne("b3.getStatementCode", statement_code);
	}
	
}
