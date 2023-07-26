package com.lab.erp.dao.c.c4;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

public class Erp_SalesresultDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_SalesresultDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	
}
