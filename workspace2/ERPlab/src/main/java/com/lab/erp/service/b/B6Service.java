package com.lab.erp.service.b;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lab.erp.dao.b.b1.Erp_Bs1DAO;
import com.lab.erp.dao.b.b1.Erp_ClosingDAO;
import com.lab.erp.dao.b.b6.Erp_ResignDAO;
import com.lab.erp.dao.b.b6.Erp_SalaryDAO;
import com.lab.erp.dao.login.Erp_EmphistoryDAO;
import com.lab.erp.vo.b.b1.Erp_Bs1VO;
import com.lab.erp.vo.b.b1.Erp_Bs2VO;
import com.lab.erp.vo.b.b1.Erp_Bs3VO;
import com.lab.erp.vo.b.b1.Erp_ClosingVO;
import com.lab.erp.vo.b.b6.Erp_ResignVO;
import com.lab.erp.vo.b.b6.Erp_SalaryVO;
import com.lab.erp.vo.login.Erp_Employee1VO;

@Service
public class B6Service {
	private Erp_SalaryDAO sdao;
	private Erp_ResignDAO rdao;
	private Erp_Bs1DAO bdao;
	private Erp_ClosingDAO cdao;
	private Erp_EmphistoryDAO emdao;
	
	@Autowired
	public B6Service(Erp_SalaryDAO sdao, Erp_ResignDAO rdao, Erp_Bs1DAO bdao, Erp_ClosingDAO cdao, Erp_EmphistoryDAO emdao) {
		this.sdao = sdao;
		this.rdao = rdao;
		this.bdao = bdao;
		this.cdao = cdao;
		this.emdao = emdao;
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
	
	public List<Map<String, Object>> privacy(Map<String, Object> map){
		return sdao.privacy(map);
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
	
	public int getSalarycode(String salary_code) {
		return sdao.getSalarycode(salary_code);
	}
	
	public List<Erp_Bs1VO> selectBs(){
		return bdao.selectBs();
	}
	
	public int insertClosing(Erp_ClosingVO vo) {
		return cdao.insertClosing(vo);
	}
	
	public Map<String, Object> selectSalaryUpdate1(Map<String, Object> map){
		return sdao.selectSalaryUpdate1(map);
	}
	
	public Map<String, Object> selectSalaryUpdate2(Map<String, Object> map){
		return sdao.selectSalaryUpdate2(map);
	}
	
	public int updateBs3(Erp_Bs3VO vo) {
		return sdao.updateBs3(vo);
	}
	
	public int updateBs2(Erp_Bs2VO vo) {
		return sdao.updateBs2(vo);
	}
	
	public int updateBs(Erp_Bs1VO vo) {
		return sdao.updateBs(vo);
	}
	
	public int selectBsno(int bs3_no){
		return sdao.selectBsno(bs3_no);
	}
	
	public int selectBsno2(int bs3_no){
		return sdao.selectBsno2(bs3_no);
	}
	
	public int updateResign(Map<String, Object> map) {
		return emdao.updateResign(map);
	}
	
	public int salaryUpdate(Map<String, Object> map) {
		return sdao.salaryUpdate(map);
	}
	
}
