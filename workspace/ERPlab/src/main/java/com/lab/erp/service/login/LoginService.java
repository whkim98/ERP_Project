package com.lab.erp.service.login;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lab.erp.dao.all.Erp_ComcodeDAO;
import com.lab.erp.dao.login.Erp_AdminDAO;
import com.lab.erp.dao.login.Erp_EmployeeDAO;
import com.lab.erp.vo.all.Erp_ComcodeVO;
import com.lab.erp.vo.login.Erp_AdminVO;

@Service
public class LoginService {
	
	private Erp_EmployeeDAO edao;
	private Erp_AdminDAO adao;
	private Erp_ComcodeDAO cdao;
	
	@Autowired
	public LoginService(Erp_EmployeeDAO edao, Erp_AdminDAO adao, Erp_ComcodeDAO cdao) {
		this.edao = edao;
		this.adao = adao;
		this.cdao = cdao;
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
	
	public String findComCode(int comcode_no) {
		return cdao.findComCode(comcode_no);
	}
	
	public List<Erp_ComcodeVO> comCodeList(Map<String, Object> map){
		List<Erp_ComcodeVO> list = cdao.comCodeList(map);
		return list;
	}
	
	public int comNo(String comcode_code) {
		return cdao.comNo(comcode_code);
	}
}
