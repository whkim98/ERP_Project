package com.lab.erp.dao.b.b1;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

public class Erp_Bs2DAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_Bs2DAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	
}
