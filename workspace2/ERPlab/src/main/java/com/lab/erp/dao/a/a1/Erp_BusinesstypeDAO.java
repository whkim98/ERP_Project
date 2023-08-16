package com.lab.erp.dao.a.a1;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.a.a1.Erp_BusinesstypeVO;

@Component
public class Erp_BusinesstypeDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_BusinesstypeDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public List<Erp_BusinesstypeVO> selectType(){
		return sqlSession.selectList("c1.selectType");
	}
	
}
