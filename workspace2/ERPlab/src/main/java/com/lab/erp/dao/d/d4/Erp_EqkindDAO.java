package com.lab.erp.dao.d.d4;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Erp_EqkindDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_EqkindDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	
}
