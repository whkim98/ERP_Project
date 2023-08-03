package com.lab.erp.dao.b.b7;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Erp_ToolstypeDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_ToolstypeDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	
}
