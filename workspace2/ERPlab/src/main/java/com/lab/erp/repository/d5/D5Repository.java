package com.lab.erp.repository.d5;

import java.util.List;

import com.lab.erp.vo.c.Erp_ClientVO;
import com.lab.erp.vo.c.c4.Erp_CustomerVO;
import com.lab.erp.vo.d.d5.Erp_ClaimVO;
import com.lab.erp.vo.d.d5.Erp_CsVO;
import com.lab.erp.vo.d.d5.Erp_CvalueVO;


public interface D5Repository {
	
	// ---------클레임(기업)---------
	List<Erp_ClaimVO> findAll_claim();
	
	int save_claim(Erp_ClaimVO erp_ClaimVO);
	
	int update_claim(Erp_ClaimVO erp_ClaimVO);
	
	int delete_claim(int claim_no);
	
	
	// ---------CS(소비자)---------
	List<Erp_CsVO> findAll_cs();
	
	int save_cs(Erp_CsVO erp_CsVO);
	
	int update_cs(Erp_CsVO erp_CsVO);
	
	int delete_cs(int cs_no);
	
	
	// ---------거래처조회---------
	List<Erp_ClientVO> findClientAll();
	
	// ---------클레임/CS 항목 조회---------
	List<Erp_CvalueVO> findCvalueAll();
	
	// ---------고객정보 조회---------
	List<Erp_CustomerVO> findCustomerAll();
	
}
