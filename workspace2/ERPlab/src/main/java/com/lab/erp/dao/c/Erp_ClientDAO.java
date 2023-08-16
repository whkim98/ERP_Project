package com.lab.erp.dao.c;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.c.Erp_ClientVO;

@Component
public class Erp_ClientDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_ClientDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public List<Erp_ClientVO> selectClient(int country_no){
		return sqlSession.selectList("c2.selectClient", country_no);
	}
	
	public int insertClient(Erp_ClientVO vo) {
		return sqlSession.insert("c2.insertClient", vo);
	}
	
	public int updateClient(Map<String, Object> map) {
		return sqlSession.update("c1.updateClient", map);
	}
	
	public List<Erp_ClientVO> internationList(){
		return sqlSession.selectList("c1.internationList");
	}
	
}
