package com.lab.erp.dao.b.b1;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.b.b1.Erp_ClosingVO;

@Component
public class Erp_ClosingDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_ClosingDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public int createClosing(Erp_ClosingVO vo) {
		return sqlSession.insert("b1.createClosing",vo);
	}
	
	public int updateClosing(Erp_ClosingVO vo) {
		return sqlSession.update("b1.updateClosing", vo);
	}
	
	public int deleteClosing(int closing_no) {
		return sqlSession.delete("b1.deleteClosing", closing_no);
	}
	
	public int getClosingNo(String closing_code) {
		return sqlSession.selectOne("b1.getClosingNo", closing_code);
	}
	
	public Erp_ClosingVO getClosing(int closing_no) {
		return sqlSession.selectOne("b1.getClosing", closing_no);
	}
	
}
