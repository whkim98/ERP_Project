package com.lab.erp.dao.d.d6;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.d.d6.Erp_GoodslotVO;

@Component
public class Erp_GoodslotDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_GoodslotDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public int createGoodsLot(Erp_GoodslotVO vo) {
		return sqlSession.insert("d6.createGoodsLot", vo);
	}
	
	public int updateGoodsLot(Erp_GoodslotVO vo) {
		return sqlSession.update("d6.updateGoodsLot", vo);
	}
	
	public int deleteGoodsLot(int goodslot_no) {
		return sqlSession.delete("d6.deleteGoodsLot", goodslot_no);
	}
	
	public int goodslotno(Erp_GoodslotVO vo) {
		return sqlSession.selectOne("d6.goodslotno", vo);
	}
}
