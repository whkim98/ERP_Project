package com.lab.erp.dao.c.c2;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.c.c2.Erp_ReturnVO;

@Component
public class Erp_ReturnDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_ReturnDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public int inputReturn(Erp_ReturnVO vo) {
		return sqlSession.insert("c2.inputReturn", vo);
	}
	
	public int updateReturn(Erp_ReturnVO vo) {
		return sqlSession.update("c2.updateReturn", vo);
	}
	
	public int deleteReturn(int return_no) {
		return sqlSession.delete("c2.deleteReturn", return_no);
	}
	
	public List<Map<String, Object>> returnList(Map<String, Object> map){
		return sqlSession.selectList("c2.returnList", map);
	}
	
	public Map<String, Object> selectReturn(int return_no){
		return sqlSession.selectOne("c2.selectReturn", return_no);
	}
	
	public Erp_ReturnVO getReturn(int return_no) {
		return sqlSession.selectOne("c2.getReturn", return_no);
	}
	
	public int getReturnCode(String return_code) {
		return sqlSession.selectOne("c2.getReturnCode", return_code);
	}
}
