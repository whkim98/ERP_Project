package com.lab.erp.dao.b.b6;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Erp_SalarytypeDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_SalarytypeDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	
}
