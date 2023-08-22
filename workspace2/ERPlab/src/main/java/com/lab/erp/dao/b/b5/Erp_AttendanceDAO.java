package com.lab.erp.dao.b.b5;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.b.b5.Erp_AttendanceVO;
import com.lab.erp.vo.login.Erp_Employee2VO;

@Component
public class Erp_AttendanceDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_AttendanceDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public int insertAttendance(Erp_AttendanceVO vo) {
		return sqlSession.insert("b5.insertAttendance", vo);
	}
	
	public double selectLocal(Map<String, Object> map) {
		return sqlSession.selectOne("b5.selectLocal", map);
	}

	public int updateHoliday(Erp_Employee2VO vo) {
		return sqlSession.update("b5.updateHoliday", vo);
	}
	
	
}
