package com.lab.erp.dao.b.b1;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.b.b1.Erp_Bs1VO;
import com.lab.erp.vo.b.b1.Erp_Bs2VO;
import com.lab.erp.vo.b.b1.Erp_Bs3VO;

@Component
public class Erp_Bs1DAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_Bs1DAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public List<Erp_Bs1VO> bs1List(){
		return sqlSession.selectList("b1.bs1List");
	}
	
	public List<Erp_Bs1VO> selectBs(){
		return sqlSession.selectList("b6.selectBs");
	}
	
	public List<Erp_Bs1VO> selectBsd(){
		return sqlSession.selectList("c1.selectBsd");
	}

	public List<Erp_Bs1VO> selectBsc(){
		return sqlSession.selectList("c1.selectBsc");
	}
	
	public int selectBsno(int bs3_no) {
		return sqlSession.selectOne("c1.selectBsno", bs3_no);
	}
	
	public int selectBsno2(int bs3_no) {
		return sqlSession.selectOne("c1.selectBsno2", bs3_no);
	}
	
	public int updateBs3(Erp_Bs3VO vo) {
		return sqlSession.update("c1.updateBs3", vo);
	}
	
	public int updateBs2(Erp_Bs2VO vo) {
		return sqlSession.update("c1.updateBs2", vo);
	}
	
	public int updateBs(Erp_Bs1VO vo) {
		return sqlSession.update("c1.updateBs", vo);
	}
	
	public List<Erp_Bs1VO> selectBsd2(){
		return sqlSession.selectList("c1.selectBsd2");
	}
	
	public List<Erp_Bs1VO> selectBsc2(){
		return sqlSession.selectList("c1.selectBsc2");
	}
	
	public List<Erp_Bs1VO> selectBsd3(){
		return sqlSession.selectList("c1.selectBsd3");
	}
	
	public List<Erp_Bs1VO> selectBsc3(){
		return sqlSession.selectList("c1.selectBsc3");
	}
	
	public List<Erp_Bs1VO> selectDeb(String closing_code){
		return sqlSession.selectList("c1.selectDeb", closing_code);
	}
	
	public List<Erp_Bs1VO> selectCre(String closing_code){
		return sqlSession.selectList("c1.selectCre", closing_code);
	}
	
	public List<Erp_Bs1VO> selectBsdeb(){
		return sqlSession.selectList("b7.selectBsdeb");
	}
	
	public List<Erp_Bs1VO> selectBscre(){
		return sqlSession.selectList("b7.selectBscre");
	}
	
	public List<Erp_Bs1VO> selectBsdeb2(){
		return sqlSession.selectList("b7.selectBsdeb2");
	}
	
	public List<Erp_Bs1VO> selectBscre2(){
		return sqlSession.selectList("b7.selectBscre2");
	}
	
}

	

