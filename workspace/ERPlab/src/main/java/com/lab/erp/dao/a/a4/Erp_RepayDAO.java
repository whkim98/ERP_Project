package com.lab.erp.dao.a.a4;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Erp_RepayDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_RepayDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
}
