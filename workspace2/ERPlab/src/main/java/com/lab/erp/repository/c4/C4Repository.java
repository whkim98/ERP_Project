package com.lab.erp.repository.c4;

import java.util.List;

import com.lab.erp.vo.c.c4.Erp_CustomerVO;
import com.lab.erp.vo.c.c4.Erp_SalesresultVO;

public interface C4Repository {
	
	// ---------영업실적관리---------
	List<Erp_SalesresultVO> findAll_salesresult();
	
	int save_salesresult(Erp_SalesresultVO erp_salesresultVO);
		
	int update_salesresult(Erp_SalesresultVO erp_salesresultVO);
	
	int delete_salesresult(int salesresult_no);
	
	
	// ---------부서별매출--------- 

	
	// ---------고객관리---------
	List<Erp_CustomerVO> findAll_customer();
	
	int save_customer(Erp_CustomerVO erp_customerVO);
	
	int update_customer(Erp_CustomerVO erp_customerVO);
	
	int delete_customer(int customer_no);
	
	// ---------상품조회--------- 	
	
	// ---------회사조회--------- 	
	
	
}
