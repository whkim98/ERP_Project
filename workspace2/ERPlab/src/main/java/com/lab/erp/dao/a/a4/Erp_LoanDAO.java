package com.lab.erp.dao.a.a4;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.a.a4.Erp_LoanVO;

@Component
public class Erp_LoanDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_LoanDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public int createLoan(Erp_LoanVO vo) {
		return sqlSession.insert("a4.createLoan", vo);
	}
	
	public int updateLoan(Erp_LoanVO vo) {
		return sqlSession.update("a4.updateLoan", vo);
	}
	
	public int deleteLoan(int loan_no) {
		return sqlSession.delete("a4.deleteLoan", loan_no);
	}
	
	public List<Map<String, Object>> loanList(Map<String, Object> map){
		return sqlSession.selectList("a4.loanList", map);
	}
	
	public Map<String, Object> selectLoan(Map<String, Object> map){
		return sqlSession.selectOne("a4.selectLoan", map);
	}
	
}
