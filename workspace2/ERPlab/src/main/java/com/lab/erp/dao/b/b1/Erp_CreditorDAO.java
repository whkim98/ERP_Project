package com.lab.erp.dao.b.b1;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Erp_CreditorDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_CreditorDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public Map<String, Object> autoCreditor(Map<String, Object> map){
		return sqlSession.selectOne("b1.autoCreditor", map);
	}
	
	public int selectCreditor(int bs3_no) {
		return sqlSession.selectOne("c1.selectCreditor", bs3_no);
	}
	
	public int selectCreditorforsales(int bs3_no) {
		return sqlSession.selectOne("c1.selectCreditorforsales", bs3_no);
	}
	
	public int selectCreditorno(int bs3_no) {
		return sqlSession.selectOne("c1.selectCreditorno", bs3_no);
	}
	
	public int selectCreno(int bs3_no) {
		return sqlSession.selectOne("b7.selectCreno", bs3_no);
	}
	
	public int moneyBs3noc(int creditor_no) {
		return sqlSession.selectOne("b2.moneyBs3noc", creditor_no);
	}
	
	public int selectBs3Noc(int creditor_no) {
		return sqlSession.selectOne("c1.selectBs3Noc", creditor_no);
	}
	
}
