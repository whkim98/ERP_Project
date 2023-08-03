package com.lab.erp.dao.login;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.login.Erp_TeamVO;

@Component
public class Erp_TeamDAO {
	private SqlSession sqlSession;
	
	@Autowired
	public Erp_TeamDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public List<Erp_TeamVO> teamList(Map<String, Object> map){
		return sqlSession.selectList("admin.teamList", map);
	}
	public Erp_TeamVO teamName(String team_name){
		return sqlSession.selectOne("admin.teamName", team_name);
	}
	
	public int teamNo(String team_name) {
		return sqlSession.selectOne("admin.teamNo", team_name);
	}
}
