package com.lab.erp.dao.d.d1;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.d.d1.Erp_ConnectrequestVO;

@Component
public class Erp_ConnectrequestDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_ConnectrequestDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public int createConnectRequest(Erp_ConnectrequestVO vo) {
		return sqlSession.insert("d1.createConnectRequest", vo);
	}
	
	public int updateConnectRequest(Erp_ConnectrequestVO vo) {
		return sqlSession.update("d1.updateConnectRequest", vo);
	}
	
	public int deleteConnectRequest(int connectrequest_no) {
		return sqlSession.delete("d1.deleteConnectRequest", connectrequest_no);
	}
	
	public int deleteConnectRequestNo(int requestproduct_no) {
		return sqlSession.delete("d1.deleteConnectRequestNo", requestproduct_no);
	}
	
}
