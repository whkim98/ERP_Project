package com.lab.erp.dao.c;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.c.Erp_ReceivableVO;

@Component
public class Erp_ReceivableDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_ReceivableDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public int createReceivable(Erp_ReceivableVO vo) {
		return sqlSession.insert("c2.createReceivable", vo);
	}
	
	public int updateReceivable(Erp_ReceivableVO vo) {
		return sqlSession.update("c2.updateReceivable", vo);
	}
	
	public int updateReceiveTotal(Erp_ReceivableVO vo) {
		return sqlSession.update("c2.updateReceiveTotal", vo);
	}
	
	public int finishCollect(Erp_ReceivableVO vo) {
		return sqlSession.update("c2.finishCollect", vo);
	}
	
	public int deleteReceivable(int receivable_no) {
		return sqlSession.delete("c2.deleteReceivable", receivable_no);
	}
	
	public int deleteReceive(int receivable_no) {
		return sqlSession.delete("c2.deleteReceive", receivable_no);
	}
	
	public List<Map<String, Object>> receivableList(Map<String, Object> map){
		return sqlSession.selectList("c2.receivableList", map);
	}
	
	public Map<String, Object> selectReceivable(int receivable_no){
		return sqlSession.selectOne("c2.selectReceivable", receivable_no);
	}
	
	public int getUniqueCIno(String receivable_cino) {
		return sqlSession.selectOne("c2.getUniqueCIno", receivable_cino);
	}
	public int getUniqueCode(String receivable_code) {
		return sqlSession.selectOne("c2.getUniqueCode", receivable_code);
	}
	
	public int getReceivableTotal(int receivable_no) {
		return sqlSession.selectOne("c2.getReceivableTotal", receivable_no);
	}
	
}
