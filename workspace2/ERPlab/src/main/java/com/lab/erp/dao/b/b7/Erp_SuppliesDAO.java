package com.lab.erp.dao.b.b7;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Erp_SuppliesDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_SuppliesDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	
}
