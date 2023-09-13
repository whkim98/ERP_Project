package com.lab.erp.dao.c.c1;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.c.c1.Erp_ImportpayVO;


@Component
public class Erp_ImportpayDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_ImportpayDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public List<Map<String, Object>> selectImportpay(Map<String, Object> map){
		return sqlSession.selectList("c1.selectImportpay", map);
	}
	
	public int insertImportpay(Erp_ImportpayVO vo) {
		return sqlSession.insert("c1.insertImportpay", vo);
	}
	
	public int updateImportpayable(Map<String, Object> map) {
		return sqlSession.update("c1.updateImportpayable", map);
	}
	
	public int selectSalesgoodsno(int importpay_no) {
		return sqlSession.selectOne("c1.selectSalesgoodsno", importpay_no);
	}
	
	public int selectBs3no(int salesgoods_no) {
		return sqlSession.selectOne("c1.selectBs3no", salesgoods_no);
	}
	
	public Map<String, Object> selectImportpayupdate(Map<String, Object> map){
		return sqlSession.selectOne("c1.selectImportpayupdate", map);
	}
	
	public int updateImportpay(Map<String, Object> map) {
		return sqlSession.update("c1.updateImportpay", map);
	}
	
	public int updatePayable(Map<String, Object> map) {
		return sqlSession.update("c1.updatePayable", map);
	}
	
	public int selectImportpayno(int importorder_no) {
		return sqlSession.selectOne("c1.selectImportpayno", importorder_no);
	}
	
}
