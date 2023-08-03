package com.lab.erp.service.a;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lab.erp.dao.a.a3.Erp_ContractDAO;
import com.lab.erp.dao.a.a3.Erp_EstimateDAO;
import com.lab.erp.dao.a.a3.Erp_ProjectDAO;
import com.lab.erp.dao.login.Erp_TeamDAO;
import com.lab.erp.vo.a.a3.Erp_ContractVO;
import com.lab.erp.vo.a.a3.Erp_ContractkindVO;
import com.lab.erp.vo.a.a3.Erp_EstimateVO;
import com.lab.erp.vo.a.a3.Erp_ProjectVO;
import com.lab.erp.vo.a.a3.Erp_ProjectkindVO;
import com.lab.erp.vo.c.Erp_ClientVO;
import com.lab.erp.vo.login.Erp_Employee1VO;
import com.lab.erp.vo.login.Erp_TeamVO;

@Service
public class A3Service {
	private Erp_ProjectDAO pdao;
	private Erp_ContractDAO cdao;
	private Erp_TeamDAO tdao;
	private Erp_EstimateDAO edao;
	
	@Autowired
	public A3Service(Erp_ProjectDAO pdao, Erp_TeamDAO tdao, Erp_ContractDAO cdao, Erp_EstimateDAO edao) {
		this.pdao = pdao;
		this.cdao = cdao;
		this.tdao = tdao;
		this.edao = edao;
	}
	
//	프로젝트 관리
	public int createProject(Erp_ProjectVO vo) {
		return pdao.createProject(vo);
	}
	
	public int updateProject(Erp_ProjectVO vo){
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
	
	public List<Erp_ProjectkindVO> kindList(Map<String, Object> map) {
		return pdao.kindList(map);
	}
	
	public Erp_ProjectkindVO kindName(String projectkind_name) {
		return pdao.kindName(projectkind_name);
	}
	
	public List<Erp_ProjectVO> prList(Map<String, Object> map){
		return pdao.prList(map);
	}
	
	public int deleteContractpr(int project_no) {
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
	
	
//	계약 관리
	public int createContract(Erp_ContractVO vo) {
		return cdao.createContract(vo);
	}
	
	public int updateContract(Erp_ContractVO vo) {
		return cdao.updateContract(vo);
	}
	
	public int deleteContract(int contract_no) {
		return cdao.deleteContract(contract_no);
	}
	
	public List<Map<String, Object>> prContractList(Map<String, Object> map){
		return cdao.prContractList(map);
	}
	
	public Map<String, Object> selectContract(int contract_no){
		return cdao.selectContract(contract_no);
	}
	
	public Erp_ContractkindVO getCkNo(String contractkind_name){
		return cdao.getCkNo(contractkind_name);
	}
	
	public Erp_ClientVO getClientNo(String client_name) {
		return cdao.getClientNo(client_name);
	}

	public Map<String,Object> getClient(int client_no) {
		return cdao.getClient(client_no);
	}
	
	public Erp_ClientVO getCl(Map<String, Object> map) {
		return cdao.getCl(map);
	}
	
	public Erp_ContractkindVO getCk(String contractkind_name) {
		return cdao.getCk(contractkind_name);
	}
	
	public Erp_ProjectVO getProjectNo(String project_name) {
		return cdao.getProjectNo(project_name);
	}
	
	public List<Erp_ClientVO> clList(Map<String, Object> map){
		return cdao.clList(map);
	}
	
	public Erp_ProjectVO getProject(Map<String, Object> map) {
		return cdao.getProject(map);
	}
	
	public List<Erp_ContractkindVO> ckList(Map<String, Object> map){
		return cdao.ckList(map);
	}
	
//	실적 / 평가
	public int createEstimate(Erp_EstimateVO vo) {
		return edao.createEstimate(vo);
	}
	
	public int updateEstimate(Erp_EstimateVO vo) {
		return edao.updateEstimate(vo);
	}
	
	public int deleteEstimate(int estimate_no) {
		return edao.deleteEstimate(estimate_no);
	}
	
	public List<Map<String, Object>> estimateList(Map<String, Object> map){
		return edao.estimateList(map);
	}
	
	public Map<String, Object> selectEstimate(Map<String, Object> map){
		return edao.selectEstimate(map);
	}
	
	public int getTotalet(Map<String, Object> map) {
		return edao.getTotalet(map);
	}
	
//	js
	public List<Erp_TeamVO> teamList(Map<String, Object> map){
		return tdao.teamList(map);
	}
	
	public Erp_TeamVO teamName(String team_name){
		return tdao.teamName(team_name);
	}
}
