package com.lab.erp.dao.all;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.all.Erp_ComcodeVO;

@Component
public class Erp_ComcodeDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_ComcodeDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public String findComCode(int comcode_no) {
		return sqlSession.selectOne("login.findComCode", comcode_no);
	}
	
	public List<Erp_ComcodeVO> comCodeList(Map<String, Object> map){
		return sqlSession.selectList("login.comCodeList", map);
	}
	
	public int comNo(String comcode_code) {
		return sqlSession.selectOne("admin.comNo", comcode_code);
	}
	
}
