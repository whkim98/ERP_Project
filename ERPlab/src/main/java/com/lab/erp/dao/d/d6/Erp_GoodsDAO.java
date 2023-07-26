package com.lab.erp.dao.d.d6;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

public class Erp_GoodsDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_GoodsDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	
}
