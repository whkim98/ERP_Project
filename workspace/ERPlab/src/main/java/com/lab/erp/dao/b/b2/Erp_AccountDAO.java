package com.lab.erp.dao.b.b2;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Erp_AccountDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_AccountDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	
}
