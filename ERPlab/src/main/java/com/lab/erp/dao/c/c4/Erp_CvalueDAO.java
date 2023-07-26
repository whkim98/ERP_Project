package com.lab.erp.dao.c.c4;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Erp_CvalueDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_CvalueDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	
}
