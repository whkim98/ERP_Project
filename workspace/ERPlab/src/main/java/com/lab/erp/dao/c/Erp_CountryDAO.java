package com.lab.erp.dao.c;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Erp_CountryDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_CountryDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	
}
