package com.lab.erp.dao.b.b2;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.b.b2.Erp_MoneyVO;

@Component
public class Erp_MoneyDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_MoneyDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public int insertMoney(Erp_MoneyVO vo) {
		return sqlSession.insert("b2.insertMoney", vo);
	}
	
	public List<Map<String, Object>> moneyList(Map<String, Object> map){
		return sqlSession.selectList("b2.moneyList", map);
	}
	
}
