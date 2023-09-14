package com.lab.erp.dao.d.d1;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.d.d1.Erp_BomVO;

@Component
public class Erp_BomDAO {
	@Autowired
	private SqlSession sqlSession;
	
	public Erp_BomDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public int createBom(Erp_BomVO vo) {
		return sqlSession.insert("d1.createBom", vo);
	}
	
	public int updateBom(Erp_BomVO vo) {
		return sqlSession.update("d1.updateBom", vo);
	}
	
	public int deleteBom(int bom_no) {
		return sqlSession.delete("d1.deleteBom", bom_no);
	}
	
	public List<Map<String, Object>> itemList(Map<String, Object> map){
		return sqlSession.selectList("d1.itemList", map);
	}
	
	public Map<String, Object> selectItem(int goods_no){
		return sqlSession.selectOne("d1.selectItem", goods_no);
	}
	
	public List<Map<String, Object>> bomList(Map<String, Object> map){
		return sqlSession.selectList("d1.bomList", map);
	}
}
