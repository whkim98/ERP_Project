package com.lab.erp.dao.d.d2;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.d.d2.Erp_PtkindVO;

@Component
public class Erp_PtkindDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_PtkindDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public List<Erp_PtkindVO> ptList(){
		return sqlSession.selectList("d2.ptList");
	}
	
}
