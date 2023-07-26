package com.lab.erp.dao.d.d6;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

public class Erp_GoodsstDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_GoodsstDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	
}
