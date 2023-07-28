package com.lab.erp.dao.a.a1;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Erp_ComptypeDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_ComptypeDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	
}
