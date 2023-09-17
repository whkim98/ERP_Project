package com.lab.erp.dao.c;

import java.util.List;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.c.Erp_CountryVO;

@Component
public class Erp_CountryDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_CountryDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public List<Erp_CountryVO> countryList(Map<String, Object> map) {
		return sqlSession.selectList("c2.countryList", map);
	}
	
	public Erp_CountryVO autoCountry(String country_name) {
		return sqlSession.selectOne("c2.autoCountry", country_name);
	}
	
	//b2
	public int selectCountryno(String country_code) {
		return sqlSession.selectOne("b2.selectCountryno", country_code);
	}
	
}
