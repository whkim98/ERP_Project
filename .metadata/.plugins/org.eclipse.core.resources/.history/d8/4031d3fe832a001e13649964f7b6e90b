package com.lab.erp.dao.all;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.lab.erp.vo.all.Erp_TeamVO;

public class Erp_TeamDAO {
	private SqlSession sqlSession;
	
	@Autowired
	public Erp_TeamDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public List<Erp_TeamVO> teamList(){
		return sqlSession.selectList("admin.teamList");
	}
	
	public int teamNo(String team_name) {
		return sqlSession.selectOne("admin.teamNo", team_name);
	}
}
