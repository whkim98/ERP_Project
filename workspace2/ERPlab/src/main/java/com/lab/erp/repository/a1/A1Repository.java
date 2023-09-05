package com.lab.erp.repository.a1;

import java.util.List;

import com.lab.erp.vo.a.a1.Erp_BusinesstypeVO;
import com.lab.erp.vo.a.a1.Erp_CompanyVO;

public interface A1Repository {
	List<Erp_CompanyVO> findAll_company();
	
	int save_company(Erp_CompanyVO erp_CompanyVO);
	
	int update_company(Erp_CompanyVO erp_CompanyVO);
		
	int delete_company(int company_no);
		
	List<Erp_BusinesstypeVO> findBstAll();
	
}