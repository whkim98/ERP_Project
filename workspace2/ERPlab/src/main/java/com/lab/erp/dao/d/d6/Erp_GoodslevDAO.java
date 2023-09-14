package com.lab.erp.dao.d.d6;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.d.d6.Erp_GoodslevVO;

@Component
public class Erp_GoodslevDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_GoodslevDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public List<Erp_GoodslevVO> goodslev(){
		return sqlSession.selectList("d6.goodslev");
	}
	
	public List<Erp_GoodslevVO> selectGoodslev(){
		return sqlSession.selectList("d6.selectGoodslev");
	}
	
}
