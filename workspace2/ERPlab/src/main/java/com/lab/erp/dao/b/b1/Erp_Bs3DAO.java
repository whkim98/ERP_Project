package com.lab.erp.dao.b.b1;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.b.b1.Erp_Bs3VO;

@Component
public class Erp_Bs3DAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_Bs3DAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public List<Erp_Bs3VO> bsList(){
		return sqlSession.selectList("b1.bsList");
	}
	public List<Erp_Bs3VO> bs2ctgrList(){
		return sqlSession.selectList("b1.bs2ctgrList");
	}

	public List<Erp_Bs3VO> bs3ctgr(int bs2_no){
		return sqlSession.selectList("b1.bs3ctgr", bs2_no);
	}
	public List<Erp_Bs3VO> bs2ctgr(int bs1_no){
		return sqlSession.selectList("b1.bs2ctgr", bs1_no);
	}
	public List<Erp_Bs3VO> bs1ctgr(int bs1_no){
		return sqlSession.selectList("b1.bs1ctgr", bs1_no);
	}
	
	
	
	public List<Erp_Bs3VO> bs3List(){
		return sqlSession.selectList("b1.bs3List");
	}
	
	
	public List<Erp_Bs3VO> ctgrDebtor(int ctgr_no){
		return sqlSession.selectList("b1.ctgrDebtor", ctgr_no);
	}
	
	public List<Erp_Bs3VO> ctgrCreditor(int ctgr_no){
		return sqlSession.selectList("b1.ctgrCreditor", ctgr_no);
	}
	
	public Map<String, Object> getBsNo(int bs3_no){
		return sqlSession.selectOne("b1.getBsNo", bs3_no);
	}
	
	public int updateBs1Amount(Map<String, Object> map) {
		return sqlSession.update("b1.updateBs1Amount", map);
	}
	
	public int updateBs2Amount(Map<String, Object> map) {
		return sqlSession.update("b1.updateBs2Amount", map);
	}
	
	public int updateBs3Amount(Map<String, Object> map) {
		return sqlSession.update("b1.updateBs3Amount", map);
	}
	
	
	//ㄱㅇㅎ
	public String moneyBs3ctgrd(int bs3_no) {
		return sqlSession.selectOne("b2.moneyBs3ctgrd", bs3_no);
	}
	
	public String moneyBs3ctgrc(int bs3_no) {
		return sqlSession.selectOne("b2.moneyBs3ctgrc", bs3_no);
	}
	
}
