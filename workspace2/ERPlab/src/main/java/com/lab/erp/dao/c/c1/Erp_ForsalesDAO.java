package com.lab.erp.dao.c.c1;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Erp_ForsalesDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_ForsalesDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	
}
