package com.lab.erp.service.all;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.lab.erp.dao.all.Erp_AdminDAO;
import com.lab.erp.dao.all.Erp_EmployeeDAO;
import com.lab.erp.vo.all.Erp_AdminVO;

public class LoginService {
	private Erp_EmployeeDAO edao;
	private Erp_AdminDAO adao;
	
	@Autowired
	public LoginService(Erp_EmployeeDAO edao, Erp_AdminDAO adao) {
		this.edao = edao;
		this.adao = adao;
	}
	
	public int checkAdmin(Map<String, Object> map) {
		return adao.checkAdmin(map);
	}
	
	public List<Erp_AdminVO> findAdminId(int team_no){
		return adao.findAdminId(team_no);
	}
	
	public Erp_AdminVO findAdminPw(Map<String, Object> map) {
		return adao.findAdminPw(map);
	}
	
	public int checkEmp(Map<String, Object> map) {
		return edao.checkEmp(map);
	}
	
	public String findEmpId(Map<String, Object> map) {
		return edao.findEmpId(map);
	}
	
	public String findEmpPw(Map<String, Object> map) {
		return edao.findEmpPw(map);
	}
}
