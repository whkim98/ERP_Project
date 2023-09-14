package com.lab.erp.dao.d.d6;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.d.d6.Erp_GoodskindVO;

@Component
public class Erp_GoodskindDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_GoodskindDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public List<Erp_GoodskindVO> selectGoodskind(){
		return sqlSession.selectList("d6.selectGoodskind");
	}
	
}
