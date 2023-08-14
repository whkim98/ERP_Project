package com.lab.erp.dao.a.a4;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.a.a4.Erp_InvestmentVO;

@Component
public class Erp_InvestmentDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_InvestmentDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public int createInvestment(Erp_InvestmentVO vo) {
		return sqlSession.insert("a4.createInvestment", vo);
	}
	
	public int updateInvestment(Erp_InvestmentVO vo) {
		return sqlSession.update("a4.updateInvestment", vo);
	}
	
	public int deleteInvestment(int investment_no) {
		return sqlSession.delete("a4.deleteInvestment", investment_no);
	}
	
	public List<Map<String, Object>> investmentList(Map<String, Object> map){
		return sqlSession.selectList("a4.investmentList", map);
	}
	
	public Map<String, Object> selectInvestment(Map<String, Object> map){
		return sqlSession.selectOne("a4.selectInvestment", map);
	}
	
	public int getImCode(String investment_code) {
		return sqlSession.selectOne("a4.getImCode", investment_code);
	}
	
}
