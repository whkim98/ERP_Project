package com.lab.erp.dao.c;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.c.Erp_ClientsortVO;

@Component
public class Erp_ClientsortDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_ClientsortDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public List<Erp_ClientsortVO> csList(Map<String, Object> map) {
		return sqlSession.selectList("c2.csList", map);
	}
	
	public Erp_ClientsortVO autoSort(String clientsort_name) {
		return sqlSession.selectOne("c2.autoSort", clientsort_name);
	}
	
}
