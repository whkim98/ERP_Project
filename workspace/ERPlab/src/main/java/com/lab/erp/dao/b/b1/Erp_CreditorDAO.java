package com.lab.erp.dao.b.b1;

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

	
	
}
