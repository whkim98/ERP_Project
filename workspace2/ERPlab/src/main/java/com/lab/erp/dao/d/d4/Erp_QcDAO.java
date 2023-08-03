package com.lab.erp.dao.d.d4;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Erp_QcDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_QcDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	
}
