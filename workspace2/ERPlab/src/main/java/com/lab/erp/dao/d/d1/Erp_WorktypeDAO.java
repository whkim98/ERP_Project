package com.lab.erp.dao.d.d1;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.d.d1.Erp_WorktypeVO;

@Component
public class Erp_WorktypeDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_WorktypeDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public List<Erp_WorktypeVO> workTypeList(){
		return sqlSession.selectList("d1.workTypeList");
	}
	
	public Erp_WorktypeVO selectWorkType(int connectrequest_no) {
		return sqlSession.selectOne("d1.selectWorkType", connectrequest_no);
	}
	
}
