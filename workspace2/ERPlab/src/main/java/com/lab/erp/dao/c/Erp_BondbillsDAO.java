package com.lab.erp.dao.c;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.c.Erp_BondbillsVO;

@Component
public class Erp_BondbillsDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_BondbillsDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public int inputBills(Erp_BondbillsVO vo) {
		return sqlSession.insert("c2.inputBills", vo);
	}
	
	public int updateBills(Erp_BondbillsVO vo) {
		return sqlSession.update("c2.updateBills", vo);
	}
	
	public int deleteBills(int bondbills_no) {
		return sqlSession.delete("c2.deleteBills", bondbills_no);
	}
	
	public List<Map<String, Object>> bondbillsList(Map<String, Object> map){
		return sqlSession.selectList("c2.bondbillsList", map);
	}
	
	public List<Map<String, Object>> receiveBondbills(Map<String, Object> map){
		return sqlSession.selectList("c2.receiveBondbills", map);
	}
	
	public Map<String, Object> selectBondbills(int bondbills_no){
		return sqlSession.selectOne("c2.selectBondbills", bondbills_no);
	}
	
	public Erp_BondbillsVO getBillsTotal(int receivable_no) {
		return sqlSession.selectOne("c2.getBillsTotal", receivable_no);
	}
	
	public int getBondbillsCode(String bondbills_code) {
		return sqlSession.selectOne("c2.getBondbillsCode",bondbills_code);
	}
	
}
