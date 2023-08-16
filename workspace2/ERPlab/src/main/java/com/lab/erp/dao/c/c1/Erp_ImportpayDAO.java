package com.lab.erp.dao.c.c1;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.c.c1.Erp_ImportpayVO;

@Component
public class Erp_ImportpayDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_ImportpayDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	public List<Erp_ImportpayVO> selectImportpay(){
		return sqlSession.selectList("c1.selectImportpay");
	}
	
	
}
