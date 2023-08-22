package com.lab.erp.dao.d.d1;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.d.d1.Erp_InvenlotVO;

@Component
public class Erp_InvenlotDAO {

private SqlSession sqlSession;
	
	@Autowired
	public Erp_InvenlotDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public int createInvenLot(Erp_InvenlotVO vo) {
		return sqlSession.insert("d1.createInvenLot", vo);
	}
	
	public int updateInvenLot(Erp_InvenlotVO vo) {
		return sqlSession.insert("d1.updateInvenLot", vo);
	}
	
	public int deleteLot(int goodslot_no) {
		return sqlSession.insert("d1.deleteLot", goodslot_no);
	}
	
	public int deleteInvenLot(int invenlot_no) {
		return sqlSession.insert("d1.deleteInvenLot", invenlot_no);
	}
	
	public int deleteInvenPro(int proinventory_no) {
		return sqlSession.insert("d1.deleteInvenPro", proinventory_no);
	}
	
	public Map<String, Object> selectProinventoryGoods(int goodslot_no){
		return sqlSession.selectOne("d1.selectProinventoryGoods", goodslot_no);
	}
}
