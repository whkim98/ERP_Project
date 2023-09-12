package com.lab.erp.dao.b.b1;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.b.b1.Erp_Bs2VO;

@Component
public class Erp_Bs2DAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_Bs2DAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public List<Erp_Bs2VO> bs2List(){
		return sqlSession.selectList("b1.bs2List");
	}
	
}
