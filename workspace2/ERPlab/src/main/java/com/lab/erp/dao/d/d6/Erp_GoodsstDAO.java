package com.lab.erp.dao.d.d6;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.d.d6.Erp_GoodsstVO;

@Component
public class Erp_GoodsstDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_GoodsstDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public int createGoodsst(Erp_GoodsstVO vo) {
		return sqlSession.insert("d6.createGoodsst", vo);
	}
	
	public int updateGoodsst(Erp_GoodsstVO vo) {
		return sqlSession.update("d6.updateGoodsst", vo);
	}
	
	public int deleteGoodsst(int goodsst_no) {
		return sqlSession.delete("d6.deleteGoodsst", goodsst_no);
	}
	
	public int goodsstno(Erp_GoodsstVO vo) {
		return sqlSession.selectOne("d6.goodsstno", vo);
	}
	
	public List<Erp_GoodsstVO> selectGoodsst(){
		return sqlSession.selectList("d6.selectGoodsst");
	}
	
	public int insertGoodsst(Map<String, Object> map) {
		return sqlSession.insert("d6.insertGoodsst", map);
	}
	
	public int selectGoodsstno(Map<String, Object> map) {
		return sqlSession.selectOne("d6.selectGoodsstno", map);
	}
	
	public Map<String, Object> selectGoodsst2(Map<String, Object> map){
		return sqlSession.selectOne("d6.selectGoodsst2", map);
	}
	
	public int updateGoodsst2(Map<String, Object> map) {
		return sqlSession.update("d6.updateGoodsst2", map);
	}
	
}
