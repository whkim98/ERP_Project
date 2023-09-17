package com.lab.erp.dao.c.c3;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Erp_OnlineDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_OnlineDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	//ㄱㅇㅎ
	public List<Map<String, Object>> manageOnline(Map<String, Object> map){
		return sqlSession.selectList("d6.manageOnline", map);
	}
	
}
