package com.lab.erp.service.a;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lab.erp.dao.a.a3.Erp_ProjectDAO;
import com.lab.erp.dao.login.Erp_TeamDAO;
import com.lab.erp.vo.a.a3.Erp_ContractVO;
import com.lab.erp.vo.a.a3.Erp_ProjectVO;
import com.lab.erp.vo.a.a3.Erp_ProjectkindVO;
import com.lab.erp.vo.login.Erp_Employee1VO;

@Service
public class A3Service {
	private Erp_ProjectDAO pdao;
	private Erp_TeamDAO tdao;
	
	@Autowired
	public A3Service(Erp_ProjectDAO pdao, Erp_TeamDAO tdao) {
		this.pdao = pdao;
		this.tdao = tdao;
	}
	
	public int createProject(Erp_ProjectVO vo, String team_name, String projectkind_name, int comcode_no) {
		
		int team_no = tdao.teamNo(team_name);
				
		int pkNo = pdao.pkNo(projectkind_name);
		
		vo.setComcode_no(comcode_no);
		vo.setProjectkind_no(pkNo);
		vo.setTeam_no(team_no);
		
		return pdao.createProject(vo);
	}
	
	public int updateProject(Erp_ProjectVO vo, String team_name, String projectkind_name, int comcode_no){
		
		int team_no = tdao.teamNo(team_name);
		
		int pkNo = pdao.pkNo(projectkind_name);
		
		vo.setComcode_no(comcode_no);
		vo.setProjectkind_no(pkNo);
		vo.setTeam_no(team_no);
		
		return pdao.updateProject(vo);
	}
	
	public int deleteProject(int project_no) {
		return pdao.deleteProject(project_no);
	}
	
	public List<Map<String,Object>> projectList(int comcode_no){
		return pdao.projectList(comcode_no);
	}
	
	public Map<String,Object> selectProject(int project_no){
		return pdao.selectProject(project_no);
	}
	
	public List<Map<String,Object>> searchList(Map<String,Object> map){
		return pdao.searchList(map);
	}
	
	public int getTotal(Map<String, Object> map) {
		return pdao.getTotal(map);
	}
	
	public List<Erp_Employee1VO> empList(Map<String, Object> map) {
		return pdao.empList(map);
	}
	
	public List<Erp_ProjectkindVO> kindList() {
		return pdao.kindList();
	}
	
	public int deleteContract(int project_no) {
		return pdao.deleteContract(project_no);
	}
	
	public List<Erp_ContractVO> prContract(int project_no){
		return pdao.prContract(project_no);
	}
	
//	public List<Map<String,Object>> projectNameList(String project_name){
//		return pdao.projectNameList(project_name);
//	}
//	
//	public List<Map<String,Object>> projectContentList(String project_content){
//		return pdao.projectContentList(project_content);
//	}
//	
//	public List<Map<String,Object>> projectKindList(String projectkind_name){
//		int pkNo = pdao.pkNo(projectkind_name);
//		
//		return pdao.projectKindList(pkNo);
//	}
//	
//	public List<Map<String,Object>> empProjectList(int employee1_no){
//		return pdao.empProjectList(employee1_no);
//	}
//	
//	public List<Map<String,Object>> teamProjectList(String team_name){
//		int teamNo = tdao.teamNo(team_name);
//		
//		return pdao.teamProjectList(teamNo);
//	}
	
}
