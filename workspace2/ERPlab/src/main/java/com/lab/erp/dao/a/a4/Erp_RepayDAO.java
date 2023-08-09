package com.lab.erp.dao.a.a4;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.a.a4.Erp_RepayVO;

@Component
public class Erp_RepayDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_RepayDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public int inputRepay(Erp_RepayVO vo) {
		return sqlSession.insert("a4.inputRepay", vo);
	}
	
	public int updateRepay(Erp_RepayVO vo) {
		return sqlSession.update("a4.updateRepay", vo);
	}
	
	public int deleteRepay(int repay_no) {
		return sqlSession.delete("a4.deleteRepay", repay_no);
	}
	
	public List<Erp_RepayVO> repayList(String repay_code){
		return sqlSession.selectList("a4.repayList", repay_code);
	}
	
	public Map<String, Object> repayCode(String repay_code){
		return sqlSession.selectOne("a4.repayCode", repay_code);
	}
	
}
