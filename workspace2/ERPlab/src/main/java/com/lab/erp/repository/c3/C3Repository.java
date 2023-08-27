package com.lab.erp.repository.c3;

import java.util.List;

import com.lab.erp.vo.c.c3.Erp_EventVO;

public interface C3Repository {
	List<Erp_EventVO> findAll();
	
	int save(Erp_EventVO erp_EventVO);
	
	int update(Erp_EventVO erp_EventVO);
	
	int delete(Erp_EventVO erp_EventVO);
}
