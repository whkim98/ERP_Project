package com.lab.erp.service.b;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lab.erp.dao.b.b5.Erp_AttendanceDAO;
import com.lab.erp.dao.b.b5.Erp_HdkindDAO;
import com.lab.erp.dao.login.Erp_EmployeeDAO;
import com.lab.erp.vo.b.b5.Erp_AttendanceVO;
import com.lab.erp.vo.login.Erp_Employee1VO;
import com.lab.erp.vo.login.Erp_Employee2VO;

@Service
public class B5Service {

	private Erp_EmployeeDAO edao;
	private Erp_AttendanceDAO adao;
	private Erp_HdkindDAO hdao;
	
	@Autowired
	public B5Service(Erp_EmployeeDAO edao, Erp_AttendanceDAO adao, Erp_HdkindDAO hdao) {
		this.edao = edao;
		this.adao = adao;
		this.hdao = hdao;
	}
	
	public List<Erp_Employee1VO> selectEmployee(){
		return edao.selectEmployee();
	}
	
	public int insertEmployee1(Erp_Employee1VO vo) {
		return edao.insertEmployee1(vo);
	}
	
	public int insertEmployee2(Erp_Employee2VO vo) {
		return edao.insertEmployee2(vo);
	}
	
	public int selectEmployeeno(String employee1_code) {
		return edao.selectEmployeeno(employee1_code);
	}
	
	public List<Erp_Employee1VO> selectAttendance(){
		return edao.selectAttendance();
	}
	
	public int insertAttendance(Erp_AttendanceVO vo) {
		return adao.insertAttendance(vo);
	}
	
	public double selectLocal(Map<String, Object> map) {
		return adao.selectLocal(map);
	}
	
	public int updateHoliday(Erp_Employee2VO vo) {
		return adao.updateHoliday(vo);
	}
	
	
}
