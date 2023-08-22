package com.lab.erp.dao.b.b5;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Erp_HdkindDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_HdkindDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

}
