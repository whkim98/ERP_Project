package com.lab.erp.service.b;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lab.erp.dao.b.b6.Erp_ResignDAO;
import com.lab.erp.dao.b.b6.Erp_SalaryDAO;
import com.lab.erp.vo.b.b6.Erp_ResignVO;
import com.lab.erp.vo.b.b6.Erp_SalaryVO;
import com.lab.erp.vo.login.Erp_Employee1VO;

@Service
public class B6Service {
	private Erp_SalaryDAO sdao;
	private Erp_ResignDAO rdao;
	
	@Autowired
	public B6Service(Erp_SalaryDAO sdao, Erp_ResignDAO rdao) {
		this.sdao = sdao;
		this.rdao = rdao;
	}
	
	//추가근무수당 정산
	public int selectMonth(String salary_date) {
		return sdao.selectMonth(salary_date);
	}
	
	public int selectYear(String salary_date) {
		return sdao.selectYear(salary_date);
	}
	
	public int selectSalary(int employee2_no) {
		return sdao.selectSalary(employee2_no);
	}
	
	public List<Erp_SalaryVO> privacy(String employee1_code){
		return sdao.privacy(employee1_code);
	}
	
	public int selectEmployee(String employee1_code) {
		return sdao.selectEmployee(employee1_code);
	}
	
	public int insertSalary(Erp_SalaryVO vo) {
		return sdao.insertSalary(vo);
	}
	
	public int salaryType(String salarytype_name) {
		return sdao.salaryType(salarytype_name);
	}
	
	public double magnification(int salarytype_no) {
		return sdao.magnification(salarytype_no);
	}
	
	//퇴직
	public List<Erp_Employee1VO> resignList(){
		return rdao.resignList();
	}
	
	public int resignInsert(Erp_ResignVO vo) {
		return rdao.resignInsert(vo);
	}
	
	public List<Erp_Employee1VO> employeeList(){
		return rdao.employeeList();
	}
	
	public int selectExp(int employee2_no) {
		return rdao.selectExp(employee2_no);
	}
	
}
