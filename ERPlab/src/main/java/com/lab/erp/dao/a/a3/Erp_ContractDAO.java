package com.lab.erp.dao.a.a3;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

public class Erp_ContractDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_ContractDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	
}
