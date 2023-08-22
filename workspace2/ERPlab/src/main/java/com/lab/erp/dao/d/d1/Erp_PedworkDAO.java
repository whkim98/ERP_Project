package com.lab.erp.dao.d.d1;

import org.apache.ibatis.session.SqlSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.d.d1.Erp_ConnectrequestVO;
import com.lab.erp.vo.d.d1.Erp_PedworkVO;

@Component
public class Erp_PedworkDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_PedworkDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public int createPedWork(Erp_PedworkVO vo) {
		return sqlSession.insert("d1.createPedWork", vo);
	}
	
	public int updatePedWork(Erp_PedworkVO vo) {
		return sqlSession.insert("d1.updatePedWork", vo);
	}
	
	public int deletePedWork(int pedwork_no) {
		return sqlSession.insert("d1.deletePedWork", pedwork_no);
	}
	
	public int deletePedWorkNo(int ped_no) {
		return sqlSession.insert("d1.deletePedWorkNo", ped_no);
	}
	
}
