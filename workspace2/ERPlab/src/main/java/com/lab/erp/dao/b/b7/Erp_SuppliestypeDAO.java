package com.lab.erp.dao.b.b7;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.b.b7.Erp_SuppliestypeVO;

@Component
public class Erp_SuppliestypeDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_SuppliestypeDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public List<Erp_SuppliestypeVO> suppliestypeList(){
		return sqlSession.selectList("b7.suppliestypeList");
	}
	
	
}
