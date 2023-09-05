package com.lab.erp.repository.c3;

import java.util.List;

import com.lab.erp.vo.a.a1.Erp_CompanyVO;
import com.lab.erp.vo.c.c3.Erp_EventVO;

import com.lab.erp.vo.c.c3.Erp_OnlineVO;
import com.lab.erp.vo.c.c3.Erp_WarehouseVO;
import com.lab.erp.vo.d.d6.Erp_GoodsVO;

public interface C3Repository {
	
	// ---------창고관리(재고관리)---------
	List<Erp_WarehouseVO> findAll_warehouse();
	
	int save_warehouse(Erp_WarehouseVO erp_WarehouseVO);
	
	int delete_warehouse(Erp_WarehouseVO erp_WarehouseVO);
	
	int update_warehouse(Erp_WarehouseVO erp_WarehouseVO);
	
	int delete_warehouse(int warehouse_no);
	
	
	// ---------행사--------- 
	List<Erp_EventVO> findAll_event();
	
	int save_event(Erp_EventVO erp_EventVO);
	
	int update_event(Erp_EventVO erp_EventVO);
	
	int delete_event(int event_no);
	
	// ---------온라인매출---------
	List<Erp_OnlineVO> findAll_online();
	
	int save_online(Erp_OnlineVO erp_OnlineVO);
	
	int update_online(Erp_OnlineVO erp_OnlineVO);
	
	int delete_online(int online_no);
	
	// ---------상품조회--------- 	
	List<Erp_GoodsVO> findGoodsAll();
	
	// ---------회사조회--------- 	
	List<Erp_CompanyVO> findCompanyAll();
}
