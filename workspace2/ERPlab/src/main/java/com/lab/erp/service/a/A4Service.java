package com.lab.erp.service.a;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lab.erp.dao.a.a4.Erp_RepayDAO;

@Service
public class A4Service {
	private Erp_RepayDAO rdao;
	
	@Autowired
	public A4Service(Erp_RepayDAO rdao) {
		this.rdao = rdao;
	}
	
}
