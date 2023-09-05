package com.lab.erp.service.c;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.lab.erp.repository.c4.C4Repository;
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

	
	// ---------고객관리---------
	public List<Erp_CustomerVO> list_customer() {return c4Repository.findAll_customer();}
	
	public int save_customer(Erp_CustomerVO erp_customerVO) {return c4Repository.save_customer(erp_customerVO);} 
	
	public int update_customer(Erp_CustomerVO erp_customerVO) {return c4Repository.update_customer(erp_customerVO);}
	
	public int delete_customer(int customer_no) {return c4Repository.delete_customer(customer_no);}
}
