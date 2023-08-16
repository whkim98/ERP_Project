package com.lab.erp.dao.c;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.c.Erp_GoodsconnectVO;

@Component
public class Erp_GoodsconnectDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_GoodsconnectDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public List<Map<String, Object>> clientGoods(int client_no){
		return sqlSession.selectList("c2.clientGoods", client_no);
	}
	
	public int inputGC(Erp_GoodsconnectVO vo) {
		return sqlSession.insert("c2.inputGC", vo);
	}
	public int updateGC(Erp_GoodsconnectVO vo) {
		return sqlSession.update("c2.updateGC", vo);
	}
	public int deleteGCClient(int client_no) {
		return sqlSession.delete("c2.deleteGCClient", client_no);
	}
	public int deleteGCNo(int goodsconnect_no) {
		return sqlSession.delete("c2.deleteGCNo", goodsconnect_no);
	}
	
}
