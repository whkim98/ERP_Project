package com.lab.erp.dao.b.b1;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Erp_DebtorDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_DebtorDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public Map<String, Object> autoDebtor(Map<String, Object> map){
		return sqlSession.selectOne("b1.autoDebtor", map);
	}
	
}
