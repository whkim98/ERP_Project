package com.lab.erp.dao.d.d2;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Erp_ProducttestDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_ProducttestDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	
}
