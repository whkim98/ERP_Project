package com.lab.erp.dao.c;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Erp_GoodsconnectDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_GoodsconnectDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	
}
