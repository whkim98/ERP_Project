package com.lab.erp.dao.d.d1;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.d.d1.Erp_LotconnevVO;
import com.lab.erp.vo.d.d1.Erp_PedworkVO;

@Component
public class Erp_LotconnevDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_LotconnevDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public int createLotEv(Erp_LotconnevVO vo) {
		return sqlSession.insert("d1.createLotEv", vo);
	}
	
	public int updateLotEv(Erp_LotconnevVO vo) {
		return sqlSession.insert("d1.updateLotEv", vo);
	}
	
	public int deleteLotEv(int lotconnev_no) {
		return sqlSession.insert("d1.deleteLotEv", lotconnev_no);
	}
	
	public int deleteLotEvNo(int evaluation_no) {
		return sqlSession.insert("d1.deleteLotEvNo", evaluation_no);
	}
	
}
