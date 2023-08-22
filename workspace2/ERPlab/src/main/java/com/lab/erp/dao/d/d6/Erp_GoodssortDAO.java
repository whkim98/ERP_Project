package com.lab.erp.dao.d.d6;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Erp_GoodssortDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_GoodssortDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public List<Map<String, Object>> sortkind(){
		return sqlSession.selectList("d6.sortkind");
	}
	
}
