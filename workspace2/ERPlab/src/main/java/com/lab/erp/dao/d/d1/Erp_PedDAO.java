package com.lab.erp.dao.d.d1;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.d.d1.Erp_PedVO;

@Component
public class Erp_PedDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_PedDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public int createPed(Erp_PedVO vo) {
		return sqlSession.insert("d1.createPed", vo);
	}
	
	public int updatePed(Erp_PedVO vo) {
		return sqlSession.insert("d1.updatePed", vo);
	}
	
	public int deletePed(int ped_no) {
		return sqlSession.insert("d1.deletePed", ped_no);
	}
	
	public int deletePedRequest(int requestproduct_no) {
		return sqlSession.insert("d1.deletePedRequest", requestproduct_no);
	}
	
	public List<Map<String, Object>> pedList(Map<String, Object> map){
		return sqlSession.selectList("d1.pedList", map);
	}
	
	public Map<String, Object> selectPed(int ped_no){
		return sqlSession.selectOne("d1.selectPed", ped_no);
	}
	
	public int getPedNo(Erp_PedVO vo) {
		return sqlSession.selectOne("d1.getPedNo", vo);
	}
	
}
