package com.lab.erp.dao.c.c2;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Erp_ReturnDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_ReturnDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	
}
