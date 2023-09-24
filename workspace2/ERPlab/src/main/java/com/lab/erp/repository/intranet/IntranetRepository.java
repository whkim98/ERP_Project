package com.lab.erp.repository.intranet;

import java.util.List;

import com.lab.erp.vo.intranet.Erp_CalendarVO;
import com.lab.erp.vo.intranet.Erp_EmailVO;
import com.lab.erp.vo.login.Erp_DeptVO;
import com.lab.erp.vo.login.Erp_Employee1VO;
import com.lab.erp.vo.login.Erp_Employee2VO;
import com.lab.erp.vo.login.Erp_TeamVO;



public interface IntranetRepository {
	
	List<Erp_TeamVO> findAll_team();
	
	List<Erp_DeptVO> findAll_dept();
	
	List<Erp_Employee1VO> findAll_employee1();
	
	List<Erp_Employee2VO> findAll_employee2();	
	
	Erp_CalendarVO find_calendar();
	
	int update_calendar(Erp_CalendarVO erp_CalendarVO);
	
	String findAll_sample();

}
