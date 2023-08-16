package com.lab.erp.service.b;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lab.erp.dao.b.b7.Erp_SuppliesDAO;
import com.lab.erp.dao.b.b7.Erp_ToolsDAO;

@Service
public class B7Service {

	private Erp_ToolsDAO tdao;
	private Erp_SuppliesDAO sdao;
	
	@Autowired
	public B7Service(Erp_ToolsDAO tdao, Erp_SuppliesDAO sdao) {
		this.tdao = tdao;
		this.sdao = sdao;
	}
	
	
	
}
