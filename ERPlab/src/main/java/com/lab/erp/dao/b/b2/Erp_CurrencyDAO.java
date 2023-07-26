package com.lab.erp.dao.b.b2;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

public class Erp_CurrencyDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_CurrencyDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	
}
