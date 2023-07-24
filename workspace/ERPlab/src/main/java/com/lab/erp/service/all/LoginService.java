package com.lab.erp.service.all;

import org.springframework.beans.factory.annotation.Autowired;

import com.lab.erp.dao.all.Erp_AdminDAO;
import com.lab.erp.dao.all.Erp_EmployeeDAO;

public class LoginService {
	private Erp_EmployeeDAO edao;
	private Erp_AdminDAO adao;
	
	@Autowired
	public LoginService(Erp_EmployeeDAO edao, Erp_AdminDAO adao) {
		this.edao = edao;
		this.adao = adao;
	}
	
	
}
