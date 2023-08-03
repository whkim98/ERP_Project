package com.lab.erp.dao.b.b3;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Erp_SettletypeDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_SettletypeDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	
}
