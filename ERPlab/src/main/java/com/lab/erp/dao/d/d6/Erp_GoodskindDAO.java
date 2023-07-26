package com.lab.erp.dao.d.d6;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Erp_GoodskindDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_GoodskindDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	
}
