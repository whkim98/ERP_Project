package com.lab.erp.dao.b.b3;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.b.b3.Erp_TaxinvoiceVO;

@Component
public class Erp_TaxinvoiceDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_TaxinvoiceDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public int selectOneTaxinvoice(Erp_TaxinvoiceVO vo) {
		return sqlSession.selectOne("b32.select", vo);
	}

	
	public int insertTaxinvoice(Erp_TaxinvoiceVO vo) {
		return sqlSession.insert("b32.insert", vo);
	}
	
	public int updateTaxinvoice(Erp_TaxinvoiceVO vo) {
		return sqlSession.update("b32.update", vo);
	}

	public int deleteTaxinvoice(int no) {
		return sqlSession.delete("b32.delete", no);
	}

	
}
