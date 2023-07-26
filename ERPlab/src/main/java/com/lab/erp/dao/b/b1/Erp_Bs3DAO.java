package com.lab.erp.dao.b.b1;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

public class Erp_Bs3DAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_Bs3DAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	
}
