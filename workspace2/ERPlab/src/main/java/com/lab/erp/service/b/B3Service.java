package com.lab.erp.service.b;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lab.erp.dao.b.b3.Erp_TaxinvoiceDAO;
import com.lab.erp.vo.b.b3.Erp_TaxinvoiceVO;

@Service
public class B3Service {

	// 전자세금계산서
	private Erp_TaxinvoiceDAO tdao;
	
	@Autowired
	public B3Service(Erp_TaxinvoiceDAO tdao) {
		this.tdao = tdao;
	}
	
	public int insertTaxinvoice(Erp_TaxinvoiceVO vo) {
		return tdao.insertTaxinvoice(vo);
	}

	
}
