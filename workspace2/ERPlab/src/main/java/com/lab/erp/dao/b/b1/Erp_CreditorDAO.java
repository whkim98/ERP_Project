package com.lab.erp.dao.b.b1;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Erp_CreditorDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_CreditorDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public Map<String, Object> autoCreditor(Map<String, Object> map){
		return sqlSession.selectOne("b1.autoCreditor", map);
	}
	
}
