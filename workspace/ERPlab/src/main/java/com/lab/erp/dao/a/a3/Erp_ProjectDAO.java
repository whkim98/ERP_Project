package com.lab.erp.dao.a.a3;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.a.a3.Erp_ContractVO;
import com.lab.erp.vo.a.a3.Erp_ProjectVO;
import com.lab.erp.vo.a.a3.Erp_ProjectkindVO;
import com.lab.erp.vo.login.Erp_Employee1VO;

@Component
public class Erp_ProjectDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_ProjectDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public int createProject(Erp_ProjectVO vo) {
		return sqlSession.insert("a3.createProject", vo);
	}
	
	public int updateProject(Erp_ProjectVO vo) {
		return sqlSession.update("a3.updateProject", vo);
	}
	
	public int deleteProject(int project_no) {
		return sqlSession.delete("a3.deleteProject", project_no);
	}
	
	public List<Map<String, Object>> projectList(int comcode_no){
		return sqlSession.selectList("a3.projectList", comcode_no);
	}
	
	public Map<String, Object> selectProject(int project_no){
		return sqlSession.selectOne("a3.selectProject", project_no);
	}
	
	public List<Map<String, Object>> searchList(Map<String, Object> map){
		return sqlSession.selectList("a3.searchList", map);
	}
	
	public int getTotal(Map<String, Object> map) {
		return sqlSession.selectOne("a3.getTotal", map);
	}
	
//	public List<Map<String, Object>> projectKindList(int projectkind_no){
//		return sqlSession.selectList("a3.projectKindList", projectkind_no);
//	}
//	
//	public List<Map<String, Object>> projectNameList(String project_name){
//		return sqlSession.selectList("a3.projectNameList", project_name);
//	}
//	
//	public List<Map<String, Object>> projectContentList(String project_content){
//		return sqlSession.selectList("a3.projectContentList", project_content);
//	}
//	
//	public List<Map<String, Object>> empProjectList(int employee1_no){
//		return sqlSession.selectList("a3.empProjectList", employee1_no);
//	}
//	
//	public List<Map<String, Object>> teamProjectList(int team_no){
//		return sqlSession.selectList("a3.teamProjectList", team_no);
//	}
	
	public int pkNo(String projectkind_name) {
		return sqlSession.selectOne("a3.pkNo", projectkind_name);
	}
	
	public List<Erp_Employee1VO> empList(Map<String, Object> map) {
		return sqlSession.selectList("a3.empList", map);
	}
	
	public List<Erp_ProjectkindVO> kindList(Map<String, Object> map) {
		return sqlSession.selectList("a3.kindList", map);
	}
	
	public Erp_ProjectkindVO kindName(String projectkind_name) {
		return sqlSession.selectOne("a3.kindName", projectkind_name);
	}
	
	public List<Erp_ProjectVO> prList(Map<String, Object> map){
		return sqlSession.selectList("a3.prList", map);
	}
	
	public List<Erp_ProjectVO> getProject(Map<String, Object> map){
		return sqlSession.selectList("a3.getProject", map);
	}
	
	
	public int deleteContract(int project_no) {
		return sqlSession.delete("a3.deleteContract", project_no);
	}
	
	public List<Erp_ContractVO> prContract(int project_no){
		return sqlSession.selectList("a3.prContract", project_no);
	}
}
