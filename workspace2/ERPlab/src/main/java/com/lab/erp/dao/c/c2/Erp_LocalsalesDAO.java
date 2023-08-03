package com.lab.erp.dao.c.c2;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Erp_LocalsalesDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_LocalsalesDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	
}
