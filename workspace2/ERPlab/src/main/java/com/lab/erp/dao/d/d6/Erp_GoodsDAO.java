package com.lab.erp.dao.d.d6;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.d.d6.Erp_GoodsVO;

@Component
public class Erp_GoodsDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_GoodsDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public List<Erp_GoodsVO> selectGoods(){
		return sqlSession.selectList("c1.selectGoods");
	}
	
	public List<Map<String, Object>> goodsList(Map<String, Object> map){
		return sqlSession.selectList("c2.goodsList", map);
	}
	
	public List<Map<String, Object>> goodsReturn(Map<String, Object> map){
		return sqlSession.selectList("c2.goodsReturn", map);
	}
	
	public List<Map<String, Object>> goodsLotList(Map<String, Object> map){
		return sqlSession.selectList("c2.goodsLotList", map);
	}
	
	
//	d1
	public List<Map<String, Object>> goodsListd1(Map<String, Object> map){
		return sqlSession.selectList("d1.goodsList", map);
	}
	
	public List<Map<String, Object>> selectRequestGoods(int requestproduct_no){
		return sqlSession.selectList("d1.selectRequestGoods", requestproduct_no);
	}
	
	public List<Map<String, Object>> selectPedGoods(int ped_no){
		return sqlSession.selectList("d1.selectPedGoods", ped_no);
	}
	
	public List<Map<String, Object>> selectEvGoods(int evaluation_no){
		return sqlSession.selectList("d1.selectEvGoods", evaluation_no);
	}
	
	public int createGoods(Erp_GoodsVO vo) {
		return sqlSession.insert("d6.createGoods", vo);
	}
	
	public int updateGoods(Erp_GoodsVO vo) {
		return sqlSession.update("d6.updateGoods", vo);
	}
	
	public int updateGoodsOne(Erp_GoodsVO vo) {
		return sqlSession.update("d6.updateGoodsOne", vo);
	}
	
	public int updateGoodsSub(Erp_GoodsVO vo) {
		return sqlSession.update("d6.updateGoodsSub", vo);
	}
	
	public int deleteGoods(int goods_no) {
		return sqlSession.delete("d6.deleteGoods", goods_no);
	}
	
	public int goodsno(String goods_code) {
		return sqlSession.selectOne("d6.goodsno", goods_code);
	}
	
	public String getLotNo1(String goodslot_lot) {
		return sqlSession.selectOne("d6.getLotNo1", goodslot_lot);
	}
	
	public List<Map<String, Object>> goodsListd17(Map<String, Object> map){
		return sqlSession.selectList("d1.goodsList17", map);
	}
	
	public List<Map<String, Object>> goodsListd2(Map<String, Object> map){
		return sqlSession.selectList("d2.goodsList", map);
	}
	
	public int insertGoods(Erp_GoodsVO vo) {
		return sqlSession.insert("c1.insertGoods", vo);
	}
	
	public List<Erp_GoodsVO> selectGoodslist(int client_no2){
		return sqlSession.selectList("c1.selectGoodslist", client_no2);
	}
	
	public Map<String, Object> selectGoodslist2(Map<String, Object> map){
		return sqlSession.selectOne("c1.selectGoodslist2", map);
	}
	
	//ㄱㅇㅎ
	public int insertGoods(Map<String, Object> map) {
		return sqlSession.insert("d6.insertGoods", map);
	}
	
	public int selectGoodsno(String goods_code) {
		return sqlSession.selectOne("d6.selectGoodsno", goods_code);
	}
	
	public int updateGoods2(Map<String, Object> map) {
		return sqlSession.update("d6.updateGoods2", map);
	}
	
	public int updateQty(Map<String, Object> map) {
		return sqlSession.update("d6.updateQty", map);
	}
	
	public int updateGoodslev(Map<String, Object> map) {
		return sqlSession.update("d6.updateGoodslev", map);
	}
	
}
