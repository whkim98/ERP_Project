package com.lab.erp.dao.a.a4;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.a.a4.Erp_LeasetypeVO;

@Component
public class Erp_LeasetypeDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_LeasetypeDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public List<Erp_LeasetypeVO> leasetypeList(){
		return sqlSession.selectList("a4.leasetypeList");
	}
	
	public Erp_LeasetypeVO searchlt(String leasetype_name) {
		return sqlSession.selectOne("a4.searchlt", leasetype_name);
	}
	
}
