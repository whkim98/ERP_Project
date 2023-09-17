package com.lab.erp.dao.b.b2;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.b.b2.Erp_AccountVO;

@Component
public class Erp_AccountDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_AccountDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public List<Map<String, Object>> accountList(Map<String, Object> map){
		return sqlSession.selectList("a4.accountList", map);
	}
	
	public Erp_AccountVO selectAccount(int account_no) {
		return sqlSession.selectOne("a4.selectAccount", account_no);
	}
	
	public List<Map<String, Object>> selectAccount(Map<String, Object> map){
		return sqlSession.selectList("b2.selectAccount", map);
	}
	
	public int updateExchange(Map<String, Object> map) {
		return sqlSession.update("b2.updateExchange", map);
	}
	
	public int selectBalance(int account_no) {
		return sqlSession.selectOne("b2.selectBalance", account_no);
	}
	
	public int selectCurrencyno(int account_no) {
		return sqlSession.selectOne("b2.selectCurrencyno", account_no);
	}
	
}
