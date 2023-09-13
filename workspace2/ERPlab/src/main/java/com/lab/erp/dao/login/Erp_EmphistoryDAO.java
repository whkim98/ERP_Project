package com.lab.erp.dao.login;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.login.Erp_EmphistoryVO;

@Component
public class Erp_EmphistoryDAO {

	private SqlSession sqlSession;
	
	@Autowired
	public Erp_EmphistoryDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public int insetEmphistory(Erp_EmphistoryVO vo) {
		return sqlSession.insert("b5.insertEmphistory", vo);
	}
	
	public int updateResign(Map<String, Object> map) {
		return sqlSession.update("b6.updateResign", map);
	}
	
}
