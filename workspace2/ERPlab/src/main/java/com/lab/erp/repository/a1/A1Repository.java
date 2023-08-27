package com.lab.erp.repository.a1;

import java.util.List;

import com.lab.erp.vo.a.a1.Erp_BusinesstypeVO;
import com.lab.erp.vo.a.a1.Erp_CompanyVO;

public interface A1Repository {
	List<Erp_CompanyVO> findAll();
	
	int save(Erp_CompanyVO erp_CompanyVO);
	
	int update(Erp_CompanyVO erp_CompanyVO);
		
	int delete(int company_no);
	
	int countAll();
	
	List<Erp_BusinesstypeVO> findBstAll();
	
	List<Erp_CompanyVO> searchedList(String type, String word);
}