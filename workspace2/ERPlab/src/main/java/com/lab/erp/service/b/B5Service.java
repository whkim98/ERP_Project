package com.lab.erp.service.b;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lab.erp.dao.b.b5.Erp_AttendanceDAO;
import com.lab.erp.dao.b.b5.Erp_HdkindDAO;
import com.lab.erp.dao.login.Erp_EmphistoryDAO;
import com.lab.erp.dao.login.Erp_EmployeeDAO;
import com.lab.erp.vo.b.b5.Erp_AttendanceVO;
import com.lab.erp.vo.login.Erp_EmphistoryVO;
import com.lab.erp.vo.login.Erp_Employee1VO;
import com.lab.erp.vo.login.Erp_Employee2VO;

@Service
public class B5Service {

	private Erp_EmployeeDAO edao;
	private Erp_AttendanceDAO adao;
	private Erp_HdkindDAO hdao;
	private Erp_EmphistoryDAO emdao;
	
	@Autowired
	public B5Service(Erp_EmployeeDAO edao, Erp_AttendanceDAO adao, Erp_HdkindDAO hdao, Erp_EmphistoryDAO emdao) {
		this.edao = edao;
		this.adao = adao;
		this.hdao = hdao;
		this.emdao = emdao;
	}
	
	public List<Map<String, Object>> selectEmployee(Map<String, Object> map){
		return edao.selectEmployee(map);
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
	
	public List<Erp_Employee1VO> selectAttendance(int employee2_no){
		return edao.selectAttendance(employee2_no);
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
	
	public int insertEmphistory(Erp_EmphistoryVO vo) {
		return emdao.insetEmphistory(vo);
	}
	
	public Map<String, Object> selectEmployee2(Map<String, Object> map){
		return edao.selectEmployee2(map);
	}
	
	public int updateEmployee1(Map<String, Object> map) {
		return edao.updateEmployee1(map);
	}
	
	public int updateEmployee2(Map<String, Object> map) {
		return edao.updateEmployee2(map);
	}
	
}
