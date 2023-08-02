package com.lab.erp.dao.b.b6;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.login.Erp_Employee1VO;

@Component
public class Erp_ResignDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_ResignDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public List<Erp_Employee1VO> resignList(){
		return sqlSession.selectList("b6.resignList");
	}
	
}
