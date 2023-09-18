package com.lab.erp.dao.b.b3;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.b.b3.Erp_CurrencyVO;

@Component
public class Erp_CurrencyDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_CurrencyDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public List<Erp_CurrencyVO> currencyDate(int country_no) {
		return sqlSession.selectList("b2.currencyDate", country_no);
	}
	
	public int insertCurrency(Erp_CurrencyVO vo) {
		return sqlSession.insert("b2.insertCurrency", vo);
	}
	
	public double selectRate(int currency_no) {
		return sqlSession.selectOne("b2.selectRate", currency_no);
	}
	
}
