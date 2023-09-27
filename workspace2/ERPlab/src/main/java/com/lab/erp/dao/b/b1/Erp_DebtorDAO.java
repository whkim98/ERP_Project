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
	
	public int selectDebtor(int bs3_no) {
		return sqlSession.selectOne("c1.selectDebtor", bs3_no);
	}
	
	public int selectDebtorforsales(int bs3_no) {
		return sqlSession.selectOne("c1.selectDebtorforsales", bs3_no);
	}
	
	public int selectDebtorno(int bs3_no) {
		return sqlSession.selectOne("c1.selectDebtorno", bs3_no);
	}
	
	public int selectDebno(int bs3_no) {
		return sqlSession.selectOne("b7.selectDebno", bs3_no);
	}
	
	public int moneyBs3nod(int debtor_no) {
		return sqlSession.selectOne("b2.moneyBs3nod", debtor_no);
	}
	
	public int selectBs3Nod(int debtor_no) {
		return sqlSession.selectOne("c1.selectBs3Nod", debtor_no);
	}
	
}
