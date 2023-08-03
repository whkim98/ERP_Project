package com.lab.erp.dao.b.b5;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Erp_AttendanceDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_AttendanceDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	
}
