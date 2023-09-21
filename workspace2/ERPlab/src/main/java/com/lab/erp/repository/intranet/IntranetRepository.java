package com.lab.erp.repository.intranet;

import java.util.List;


import com.lab.erp.vo.login.Erp_Employee1VO;
import com.lab.erp.vo.login.Erp_Employee2VO;
import com.lab.erp.vo.login.Erp_TeamVO;



public interface IntranetRepository {
	
	List<Erp_TeamVO> findAll_team();
	
	List<Erp_Employee1VO> findAll_employee1();
	
	List<Erp_Employee2VO> findAll_employee2();	
	
	
}
