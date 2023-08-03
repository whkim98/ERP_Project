package com.lab.erp.dao.a.a4;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Erp_InvestmentDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_InvestmentDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	
}
