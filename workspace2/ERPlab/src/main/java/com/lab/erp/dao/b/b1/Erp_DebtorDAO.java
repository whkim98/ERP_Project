package com.lab.erp.dao.b.b1;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Erp_DebtorDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_DebtorDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	
}
