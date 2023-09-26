package com.lab.erp.service.login;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lab.erp.dao.login.Erp_AdminDAO;
import com.lab.erp.dao.login.Erp_EmployeeDAO;
import com.lab.erp.vo.all.Erp_ComcodeVO;
import com.lab.erp.vo.login.Erp_AdminVO;
import com.lab.erp.vo.login.Erp_Employee1VO;
import com.lab.erp.vo.login.Erp_Employee2VO;
import com.lab.erp.vo.login.Erp_TeamVO;

@Service
public class AdminService {
private Erp_AdminDAO dao;
private Erp_EmployeeDAO edao;
	
	@Autowired
	public AdminService(Erp_AdminDAO dao, Erp_EmployeeDAO edao) {
		this.dao = dao;
		this.edao = edao;
	}
	
	
//	admin
	public int adminMaxNo() {
		return dao.adminMaxNo();
	}
	
	public int createAdmin(Erp_AdminVO vo) {
		return dao.createAdmin(vo);
	}
	
	public int updateAdmin(Erp_AdminVO vo) {
		return dao.updateAdmin(vo);
	}
	
	public int deleteAdmin(int admin_no) {
		return dao.deleteAdmin(admin_no);
	}
	
	public Map<String, Object> selectAdmin(int admin_no) {
		return dao.selectAdmin(admin_no);
	}
	
	public List<Map<String, Object>> adminList(Map<String, Object> map){
		return dao.adminList(map);
	}
	
	public Erp_AdminVO giveAdmin(int admin_no) {
		return dao.giveAdmin(admin_no);
	}
	
	public List<Map<String, Object>> teamAdmin(String team_name){
		return dao.teamAdmin(team_name);
	}
	
	public List<Erp_TeamVO> teamList(Map<String, Object> map){
		return dao.teamList(map);
	}
	
	public String getComcodeName(String comcode_code) {
		return dao.getComcodeName(comcode_code);
	}
	
	public int checkAdminId(String admin_id) {
		return dao.checkAdminId(admin_id);
	}
	
	
//	employee
	public List<Map<String, Object>> EmpList(Map<String, Object> map){
		return edao.EmpList(map);
	}
	
	public int createEmployee1(Erp_Employee1VO vo) {
		return edao.createEmployee1(vo);
	}
	
	public int createEmployee2(Erp_Employee2VO vo) {
		return edao.createEmployee2(vo);
	}
	
	public int updateEmp1(Erp_Employee1VO vo) {
		return edao.updateEmp1(vo);
	}
	
	public int updateEmp2(Erp_Employee2VO vo) {
		return edao.updateEmp2(vo);
	}
	
	public int updateEmpPw(Erp_Employee1VO vo) {
		return edao.updateEmpPw(vo);
	}
	
	public int deleteEmp1(int employee1_no) {
		return edao.deleteEmp1(employee1_no);
	}
	
	public int deleteEmp2(int employee2_no) {
		return edao.deleteEmp2(employee2_no);
	}
	
	public Map<String, Object> selectEmp(int employee2_no){
		return edao.selectEmp(employee2_no);
	}
}
