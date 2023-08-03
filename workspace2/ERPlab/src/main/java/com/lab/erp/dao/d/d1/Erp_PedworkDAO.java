package com.lab.erp.dao.d.d1;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Erp_PedworkDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_PedworkDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	
}
