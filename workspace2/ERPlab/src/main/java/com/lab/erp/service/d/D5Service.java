package com.lab.erp.service.d;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.lab.erp.repository.d5.D5Repository;
import com.lab.erp.vo.c.Erp_ClientVO;
import com.lab.erp.vo.c.c4.Erp_CustomerVO;
import com.lab.erp.vo.d.d5.Erp_ClaimVO;
import com.lab.erp.vo.d.d5.Erp_CsVO;
import com.lab.erp.vo.d.d5.Erp_CvalueVO;

@Service
public class D5Service {
	private D5Repository d5Repository;
	
	public D5Service(SqlSession sqlSession) {
		System.out.println("### LOG : " + getClass().getName()+"() 생성");
		d5Repository = sqlSession.getMapper(D5Repository.class);
	}
	
	
	// ---------클레임(기업)---------
	public List<Erp_ClaimVO> list_claim() {return d5Repository.findAll_claim();}
	
	public int save_claim(Erp_ClaimVO erp_ClaimVO) {return d5Repository.save_claim(erp_ClaimVO);}
	
	
	public int update_claim(Erp_ClaimVO erp_ClaimVO) {return d5Repository.update_claim(erp_ClaimVO);}
	
	public int delete_claim(int claim_no) {return d5Repository.delete_claim(claim_no);}
	
	// ---------CS(소비자)---------
	public List<Erp_CsVO> list_cs() {return d5Repository.findAll_cs();}
	
	public int save_cs(Erp_CsVO erp_CsVO) {return d5Repository.save_cs(erp_CsVO);}
	
	public int update_cs(Erp_CsVO erp_CsVO) {return d5Repository.update_cs(erp_CsVO);}
	
	public int delete_cs(int cs_no) {return d5Repository.delete_cs(cs_no);}
	
	// ---------거래처조회---------
	public List<Erp_ClientVO> findClientAll() {return d5Repository.findClientAll();}

	// ---------클레임/CS 항목 조회---------
	public List<Erp_CvalueVO> findCvalueAll() {return d5Repository.findCvalueAll();}

	public List<Erp_CustomerVO> findCustomerAll() {return d5Repository.findCustomerAll();}
}
