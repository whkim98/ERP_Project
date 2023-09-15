package com.lab.erp.dao.d.d6;

import java.util.List;
import java.util.Map;

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
	
	public int updateLotQty(Erp_GoodslotVO vo) {
		return sqlSession.update("d6.updateLotQty", vo);
	}
	
	public int updateLotQtyOne(Erp_GoodslotVO vo) {
		return sqlSession.update("d6.updateLotQtyOne", vo);
	}
	
	public int updateLotQtySub(Erp_GoodslotVO vo) {
		return sqlSession.update("d6.updateLotQtySub", vo);
	}
	
	public int deleteGoodsLot(int goodslot_no) {
		return sqlSession.delete("d6.deleteGoodsLot", goodslot_no);
	}
	
	public int goodslotno(Erp_GoodslotVO vo) {
		return sqlSession.selectOne("d6.goodslotno", vo);
	}
	
	public List<Integer> getLotNo(String goodslot_lot){
		return sqlSession.selectList("d6.getLotNo", goodslot_lot);
	}
	
	public List<Map<String, Object>> productLot(int product_no){
		return sqlSession.selectList("d1.productLot", product_no);
	}
	
	// ㄱㅇㅎ
	public List<Map<String, Object>> selectGoods(Map<String, Object> map){
		return sqlSession.selectList("d6.selectGoods", map);
	}
	
	public int insertGoodslot(Map<String, Object> map) {
		return sqlSession.insert("d6.insertGoodslot", map);
	}
	
	
	public Map<String, Object> selectGoods2(Map<String, Object> map){
		return sqlSession.selectOne("d6.selectGoods2", map);
	}
	
	public int updateGoodslot(Map<String, Object> map) {
		return sqlSession.update("d6.updateGoodslot", map);
	}
	
	public int deleteGoodslot(Map<String, Object> map) {
		return sqlSession.delete("d6.deleteGoodslot", map);
	}
	
}
