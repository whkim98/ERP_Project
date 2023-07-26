package com.lab.erp.dao.all;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Erp_ComcodeDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_ComcodeDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	
}
