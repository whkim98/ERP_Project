package com.lab.erp.dao.b.b3;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Erp_CurrencyDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_CurrencyDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	
}
