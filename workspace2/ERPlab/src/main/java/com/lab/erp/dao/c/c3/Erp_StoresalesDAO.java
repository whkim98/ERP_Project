package com.lab.erp.dao.c.c3;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Erp_StoresalesDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_StoresalesDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	//ㄱㅇㅎ
	public List<Map<String, Object>> manageStoresales(Map<String, Object> map){
		return sqlSession.selectList("d6.manageStoresales", map);
	}
	
}
