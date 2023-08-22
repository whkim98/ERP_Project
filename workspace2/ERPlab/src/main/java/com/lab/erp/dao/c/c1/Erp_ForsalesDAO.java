package com.lab.erp.dao.c.c1;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.c.c1.Erp_ForsalesVO;

@Component
public class Erp_ForsalesDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_ForsalesDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public List<Erp_ForsalesVO> selectForsales(){
		return sqlSession.selectList("c1.selectForsales");
	}

	public int insertForsales(Erp_ForsalesVO vo) {
		return sqlSession.insert("c1.insertForsales", vo);
	}
	
}
