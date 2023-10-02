package com.lab.erp.repository.c4;

import java.util.List;

import com.lab.erp.dao.c.c1.Erp_ForsalesDAO;
import com.lab.erp.vo.b.b1.Erp_Bs1VO;
import com.lab.erp.vo.b.b1.Erp_Bs2VO;
import com.lab.erp.vo.b.b1.Erp_Bs3VO;
import com.lab.erp.vo.b.b1.Erp_ClosingVO;
import com.lab.erp.vo.c.c1.Erp_ForsalesVO;
import com.lab.erp.vo.c.c2.Erp_LocalsalesVO;
import com.lab.erp.vo.c.c3.Erp_OnlineVO;
import com.lab.erp.vo.c.c3.Erp_StoresalesVO;
import com.lab.erp.vo.c.c4.Erp_CsgradeVO;
import com.lab.erp.vo.c.c4.Erp_CustomerVO;
import com.lab.erp.vo.c.c4.Erp_SalesresultVO;

public interface C4Repository {
	
	// ---------영업실적관리---------
	List<Erp_SalesresultVO> findAll_salesresult();
	
	int save_salesresult(Erp_SalesresultVO erp_salesresultVO);
		
	int update_salesresult(Erp_SalesresultVO erp_salesresultVO);
	
	int delete_salesresult(int salesresult_no);
	
	
	// ---------부서별매출--------- 
	List<Erp_ClosingVO> findAll_closing();
	
	// ---------고객관리---------
	List<Erp_CustomerVO> findAll_customer();
	
	int save_customer(Erp_CustomerVO erp_customerVO);
	
	int update_customer(Erp_CustomerVO erp_customerVO);
	
	int delete_customer(int customer_no);
	
	// ---------해외영업매출조회---------
	List<Erp_ForsalesVO> findForsalesAll();
	
	// ---------국내영업매출조회---------
	List<Erp_LocalsalesVO> findLocalsalesAll();

	// ---------매장영업매출조회---------
	List<Erp_StoresalesVO> findStoresalesAll();

	// ---------온라인영업매출조회---------
	List<Erp_OnlineVO> findOnlineAll();
	
	// ---------고객등급조회---------
	List<Erp_CsgradeVO> findCsgradeAll();
	
	// ---------일마감처리---------
	int update_bs1(Erp_Bs1VO erp_Bs1VO);
	int update_bs2(Erp_Bs2VO erp_Bs2VO);
	int update_bs3(Erp_Bs3VO erp_Bs3VO);
	int save_closing(Erp_ClosingVO erp_ClosingVO);

	
	

	
}
