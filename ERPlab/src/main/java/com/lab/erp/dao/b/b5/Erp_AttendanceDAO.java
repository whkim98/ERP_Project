package com.lab.erp.dao.b.b5;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

public class Erp_AttendanceDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_AttendanceDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	
}
