package com.lab.erp.dao.c;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.c.Erp_ClientVO;

@Component
public class Erp_ClientDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_ClientDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public List<Map<String, Object>> clientList(Map<String, Object> map){
		return sqlSession.selectList("a4.clientList", map);
	}
	
	public Erp_ClientVO selectClient(int client_no) {
		return sqlSession.selectOne("a4.selectClient", client_no);
	}
	
	public Erp_ClientVO searchcl(Map<String, Object> map) {
		return sqlSession.selectOne("a4.searchcl", map);
	}
	
}
