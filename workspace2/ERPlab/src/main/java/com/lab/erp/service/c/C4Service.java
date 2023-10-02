package com.lab.erp.service.c;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.lab.erp.repository.c4.C4Repository;
import com.lab.erp.vo.b.b1.Erp_Bs1VO;
import com.lab.erp.vo.b.b1.Erp_Bs2VO;
import com.lab.erp.vo.b.b1.Erp_Bs3VO;
import com.lab.erp.vo.b.b1.Erp_ClosingVO;
import com.lab.erp.vo.c.c1.Erp_ForsalesVO;
import com.lab.erp.vo.c.c2.Erp_LocalsalesVO;
import com.lab.erp.vo.c.c3.Erp_OnlineVO;
import com.lab.erp.vo.c.c3.Erp_StoresalesVO;
import com.lab.erp.vo.c.c4.Erp_CsgradeVO;
import com.lab.erp.vo.c.c4.Erp_CustomerVO;
import com.lab.erp.vo.c.c4.Erp_SalesresultVO;

@Service
public class C4Service {
	private C4Repository c4Repository;
	
	public C4Service(SqlSession sqlSession) {
		System.out.println("### LOG : " + getClass().getName()+"() 생성");
		c4Repository = sqlSession.getMapper(C4Repository.class);

	}
	
	// ---------영업실적관리---------
	public List<Erp_SalesresultVO> list_salesresult(){return c4Repository.findAll_salesresult();}
	
	public int save_salesresult(Erp_SalesresultVO erp_salesresultVO) {return c4Repository.save_salesresult(erp_salesresultVO);}
		
	public int update_salesresult(Erp_SalesresultVO erp_salesresultVO) {return c4Repository.update_salesresult(erp_salesresultVO);}
	
	public int delete_salesresult(int salesresult_no) {return c4Repository.delete_salesresult(salesresult_no);}
	
	
	// ---------부서별매출--------- 
	public List<Erp_ClosingVO> list_closing() {return c4Repository.findAll_closing();}

	
	// ---------고객관리---------
	public List<Erp_CustomerVO> list_customer() {return c4Repository.findAll_customer();}
	
	public int save_customer(Erp_CustomerVO erp_customerVO) {return c4Repository.save_customer(erp_customerVO);} 
	
	public int update_customer(Erp_CustomerVO erp_customerVO) {return c4Repository.update_customer(erp_customerVO);}
	
	public int delete_customer(int customer_no) {return c4Repository.delete_customer(customer_no);}
	
	// ---------해외영업매출조회---------
	public List<Erp_ForsalesVO> findForsalesAll() {return c4Repository.findForsalesAll();}
	
	// ---------국내영업매출조회---------
	public List<Erp_LocalsalesVO> findLocalsalesAll() {return c4Repository.findLocalsalesAll();}

	// ---------매장영업매출조회---------
	public List<Erp_StoresalesVO> findStoresalesAll() {return c4Repository.findStoresalesAll();}

	// ---------온라인영업매출조회---------
	public List<Erp_OnlineVO> findOnlineAll() {return c4Repository.findOnlineAll();}
	
	// ---------고객등급조회---------
	public List<Erp_CsgradeVO> findCsgradeAll(){return c4Repository.findCsgradeAll();}
	
	// ---------일마감처리---------
	public int update_bs1(Erp_Bs1VO erp_Bs1VO) {return c4Repository.update_bs1(erp_Bs1VO);}
	public int update_bs2(Erp_Bs2VO erp_Bs2VO) {return c4Repository.update_bs2(erp_Bs2VO);}
	public int update_bs3(Erp_Bs3VO erp_Bs3VO) {return c4Repository.update_bs3(erp_Bs3VO);}
	public int save_closing(Erp_ClosingVO erp_ClosingVO) {return c4Repository.save_closing(erp_ClosingVO);}
	
}
