package com.lab.erp.service.intranet;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lab.erp.dao.login.Erp_EmployeeDAO;
import com.lab.erp.vo.login.Erp_Employee1VO;

@Service
public class IntranetService {
	private Erp_EmployeeDAO edao;
	
	@Autowired
	public IntranetService(Erp_EmployeeDAO edao) {
		this.edao = edao;
	}
	
	public int checkEmp(Map<String, Object> map) {
		return edao.checkEmp(map);
	}
	
	public Map<String, Object> getEmpName(Map<String, Object> map) {
		return edao.getEmpName(map);
	}
	
	public String findEmpId(Map<String, Object> map) {
		return edao.findEmpId(map);
	}
	
	public String findEmpPw(Map<String, Object> map) {
		return edao.findEmpPw(map);
	}
	
	public int updateEmpPw(Erp_Employee1VO vo) {
		return edao.updateEmpPw(vo);
	}
	
	public Map<String, Object> selectEmp(int employee2_no){
		return edao.selectEmp(employee2_no);
	}
}
	
