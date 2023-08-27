package com.lab.erp.repository.c3;

import java.util.List;

import com.lab.erp.vo.c.c3.Erp_EventVO;
import com.lab.erp.vo.d.d6.Erp_GoodsVO;

public interface C3Repository {
	List<Erp_EventVO> findAll();
	
	int save(Erp_EventVO erp_EventVO);
	
	int update(Erp_EventVO erp_EventVO);
	
	int delete(int event_no);
	
	List<Erp_GoodsVO> findGoodsAll();
}
