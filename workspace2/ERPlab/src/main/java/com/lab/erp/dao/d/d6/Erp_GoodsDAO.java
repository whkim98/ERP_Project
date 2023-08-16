package com.lab.erp.dao.d.d6;

import java.util.List;

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
	
	public List<Erp_GoodsVO> goodsList(){
		return sqlSession.selectList("c2.goodsList");
	}
	
}
