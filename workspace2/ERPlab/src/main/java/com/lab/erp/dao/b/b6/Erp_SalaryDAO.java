package com.lab.erp.dao.b.b6;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.b.b1.Erp_Bs1VO;
import com.lab.erp.vo.b.b1.Erp_Bs2VO;
import com.lab.erp.vo.b.b1.Erp_Bs3VO;
import com.lab.erp.vo.b.b6.Erp_SalaryVO;
import com.lab.erp.vo.login.Erp_Employee2VO;

@Component
public class Erp_SalaryDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_SalaryDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public int selectMonth(String salary_date) {
		return sqlSession.selectOne("b6.selectMonth", salary_date);
	}
	
	public int selectYear(String salary_date) {
		return sqlSession.selectOne("b6.selectYear", salary_date);
	}
	
	public int selectSalary(int employee2_no) {
		return sqlSession.selectOne("b6.selectSalary", employee2_no);
	}
	
	public List<Map<String, Object>> privacy(Map<String, Object> map){
		return sqlSession.selectList("b6.privacy", map);
	}
	
	public int selectEmployee(String employee1_code) {
		return sqlSession.selectOne("b6.selectEmployee", employee1_code);
	}
	
	public int insertSalary(Erp_SalaryVO vo) {
		return sqlSession.insert("b6.insertSalary", vo);
	}
	
	public int salaryType(String salarytype_name) {
		return sqlSession.selectOne("b6.salaryType", salarytype_name);
	}
	
	public double magnification(int salarytype_no) {
		return sqlSession.selectOne("b6.magnification", salarytype_no);
	}
	
	public int getSalarycode(String salary_code) {
		return sqlSession.selectOne("b6.getSalarycode", salary_code);
	}
	
	public Map<String, Object> selectSalaryUpdate1(Map<String, Object> map){
		return sqlSession.selectOne("b6.selectSalaryUpdate1", map);
	}
	
	public Map<String, Object> selectSalaryUpdate2(Map<String, Object> map){
		return sqlSession.selectOne("b6.selectSalaryUpdate2", map);
	}
	
	public int updateBs3(Erp_Bs3VO vo) {
		return sqlSession.update("b6.updateBs3", vo);
	}
	
	public int updateBs2(Erp_Bs2VO vo) {
		return sqlSession.update("b6.updateBs2", vo);
	}
	
	public int updateBs(Erp_Bs1VO vo) {
		return sqlSession.update("b6.updateBs", vo);
	}
	
	public int selectBsno(int bs3_no){
		return sqlSession.selectOne("b6.selectBsno", bs3_no);
	}
	
	public int selectBsno2(int bs3_no){
		return sqlSession.selectOne("b6.selectBsno2", bs3_no);
	}
	
	public int salaryUpdate(Map<String, Object> map) {
		return sqlSession.update("b6.salaryUpdate", map);
	}
	
}
