package com.lab.erp.dao.b.b6;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.b.b6.Erp_SalaryVO;
import com.lab.erp.vo.login.Erp_Employee2VO;

@Component
public class Erp_SalaryDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_SalaryDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public int selectMonth(Map<String, Object> map) {
		return sqlSession.selectOne("b6.selectMonth", map);
	}
	
	public int selectYear(Map<String, Object> map) {
		return sqlSession.selectOne("b6.selectYear", map);
	}
	
	public int selectSalary(int employee2_no) {
		return sqlSession.selectOne("b6.selectSalary", employee2_no);
	}
	
	public List<Erp_SalaryVO> privacy(String employee1_code){
		return sqlSession.selectList("b6.privacy", employee1_code);
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
	
}
