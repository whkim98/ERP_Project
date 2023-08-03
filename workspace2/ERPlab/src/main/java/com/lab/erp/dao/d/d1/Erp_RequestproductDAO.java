package com.lab.erp.dao.d.d1;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Erp_RequestproductDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_RequestproductDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	
}
