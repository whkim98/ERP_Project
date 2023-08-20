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
	public List<Erp_GoodsVO> getSalesGoods(int goods_no) {
		return sqlSession.selectList("c2.getSalesGoods", goods_no);
	}
	
	public List<Map<String, Object>> goodsList(Map<String, Object> map){
		return sqlSession.selectList("c2.goodsList", map);
	}
	
	public List<Map<String, Object>> goodsReturn(Map<String, Object> map){
		return sqlSession.selectList("c2.goodsReturn", map);
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
	
}
