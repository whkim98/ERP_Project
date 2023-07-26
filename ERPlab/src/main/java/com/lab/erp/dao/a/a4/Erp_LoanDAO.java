package com.lab.erp.dao.a.a4;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

public class Erp_LoanDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_LoanDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	
}
