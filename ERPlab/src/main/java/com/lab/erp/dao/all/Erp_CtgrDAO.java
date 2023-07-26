package com.lab.erp.dao.all;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

public class Erp_CtgrDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_CtgrDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	
}
