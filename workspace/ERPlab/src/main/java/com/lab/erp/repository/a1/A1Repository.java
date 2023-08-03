package com.lab.erp.repository.a1;

import java.util.List;

import com.lab.erp.vo.a.a1.Erp_CompanyVO;

public interface A1Repository {
	List<Erp_CompanyVO> findAll();
	
	int save(Erp_CompanyVO erp_CompanyVO);
	
	int update(Erp_CompanyVO erp_CompanyVO);
	
	int findById(int company_no);
	
	int delete(Erp_CompanyVO erp_CompanyVO);
	
	int countAll();
}
