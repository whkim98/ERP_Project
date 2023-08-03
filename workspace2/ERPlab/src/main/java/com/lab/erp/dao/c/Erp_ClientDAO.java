package com.lab.erp.dao.c;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Erp_ClientDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_ClientDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	
}
