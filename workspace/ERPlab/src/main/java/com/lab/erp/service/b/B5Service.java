package com.lab.erp.service.b;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lab.erp.dao.login.Erp_EmployeeDAO;
import com.lab.erp.vo.login.Erp_Employee1VO;

@Service
public class B5Service {

	private Erp_EmployeeDAO edao;
	
	@Autowired
	public B5Service(Erp_EmployeeDAO edao) {
		this.edao = edao;
	}
	
	public List<Erp_Employee1VO> selectEmployee(){
		return edao.selectEmployee();
	}
	
}
