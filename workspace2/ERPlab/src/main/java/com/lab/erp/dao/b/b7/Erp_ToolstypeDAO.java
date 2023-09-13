package com.lab.erp.dao.b.b7;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.b.b7.Erp_ToolstypeVO;

@Component
public class Erp_ToolstypeDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_ToolstypeDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public List<Erp_ToolstypeVO> toolstypeList(){
		return sqlSession.selectList("b7.toolstypeList");
	}

}
