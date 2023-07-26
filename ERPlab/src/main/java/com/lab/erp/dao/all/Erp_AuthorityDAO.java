package com.lab.erp.dao.all;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.lab.erp.vo.all.Erp_AuthorityVO;

public class Erp_AuthorityDAO {
	private SqlSession sqlSession;
	
	@Autowired
	public Erp_AuthorityDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public List<Erp_AuthorityVO> authorityList(){
		return sqlSession.selectList("admin.authorityList");
	}
}
