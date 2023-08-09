package com.lab.erp.dao.a.a4;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.a.a4.Erp_ImkindVO;

@Component
public class Erp_ImkindDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_ImkindDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public List<Erp_ImkindVO> imkindList(){
		return sqlSession.selectList("a4.imkindList");
	}
	
	public Erp_ImkindVO searchim(String imkind_name) {
		return sqlSession.selectOne("a4.searchim", imkind_name);
	}
	
}
