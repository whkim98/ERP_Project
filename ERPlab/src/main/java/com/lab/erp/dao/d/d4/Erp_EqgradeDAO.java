package com.lab.erp.dao.d.d4;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

public class Erp_EqgradeDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_EqgradeDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	
}
