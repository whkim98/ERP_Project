package com.lab.erp.dao.all;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.lab.erp.vo.all.Erp_AdminVO;

public class Erp_AdminDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_AdminDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
//	login
	public int checkAdmin(Map<String, Object> map) {
		return sqlSession.selectOne("admin.checkAdmin", map);
	}
	
	public List<Erp_AdminVO> findAdminId(int team_no){
		return sqlSession.selectList("admin.findAdminId", team_no);
	}
	
	public Erp_AdminVO findAdminPw(Map<String, Object> map) {
		return sqlSession.selectOne("admin.findAdminPw", map);
	}
	
//	admin
	public int adminMaxNo() {
		return sqlSession.selectOne("admin.adminMaxNo");
	}
	
	public int createAdmin(Erp_AdminVO vo) {
		return sqlSession.insert("admin.createAdmin", vo);
	}
	
	public int updateAdmin(Erp_AdminVO vo) {
		return sqlSession.update("admin.updateAdmin", vo);
	}
	
	public int deleteAdmin(int admin_no) {
		return sqlSession.delete("admin.deleteAdmin", admin_no);
	}
	
	public Erp_AdminVO selectAdmin(Map<String, Object> map) {
		return sqlSession.selectOne("admin.selectAdmin", map);
	}
	
	public List<Map<String, Object>> adminList(){
		return sqlSession.selectList("admin.adminList");
	}
	
	public Erp_AdminVO giveAdmin(int admin_no) {
		return sqlSession.selectOne("admin.giveAdmin", admin_no);
	}
	
	public List<Map<String, Object>> teamAdmin(String team_name){
		return sqlSession.selectList("admin.teamAdmin", team_name);
	}
}
