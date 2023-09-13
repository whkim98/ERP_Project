package com.lab.erp.dao.c;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.c.Erp_SalesgoodsVO;

@Component
public class Erp_SalesgoodsDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_SalesgoodsDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public int inputSalesGoods(Erp_SalesgoodsVO vo) {
		return sqlSession.insert("c2.inputSalesGoods", vo);
	}
	public int updateSGNo(Erp_SalesgoodsVO vo) {
		return sqlSession.update("c2.updateSGNo", vo);
	}
	public int deleteSGNo(int salesgoods_no) {
		return sqlSession.delete("c2.deleteSGNo", salesgoods_no);
	}
	public int deleteSGCode(String salesgoods_code) {
		return sqlSession.delete("c2.deleteSGCode", salesgoods_code);
	}
	public List<Erp_SalesgoodsVO> getSGNo(String salesgoods_code){
		return sqlSession.selectList("c2.getSGNo", salesgoods_code);
	}
	public List<Map<String, Object>> getSalesGoods(String salesgoods_code){
		return sqlSession.selectList("c2.getSalesGoods", salesgoods_code);
	}
	
	public int insertSalesgoods(Erp_SalesgoodsVO vo) {
		return sqlSession.insert("c1.insertSalesgoods", vo);
	}
	
	public int selectSumqty(int salesgoods_no) {
		return sqlSession.selectOne("c1.selectSumqty", salesgoods_no);
	}
	
	public int salesgoodsUpdate(Map<String, Object> map) {
		return sqlSession.update("c1.salesgoodsUpdate", map);
	}
	
	public int selectSumprice(int goods_no) {
		return sqlSession.selectOne("c1.selectSumprice", goods_no);
	}
	
	public int selectTax(int goods_no) {
		return sqlSession.selectOne("c1.selectTax", goods_no);
	}
	
	public int selectPrice(int goods_no) {
		return sqlSession.selectOne("c1.selectPrice", goods_no);
	}
}
