
package com.lab.erp.service.a;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.lab.erp.repository.a1.A1Repository;
import com.lab.erp.vo.a.a1.Erp_BusinesstypeVO;
import com.lab.erp.vo.a.a1.Erp_CompanyVO;

@Service
public class A1Service {

	private A1Repository a1Repository;
	
	public A1Service(SqlSession sqlSession) {
		System.out.println("### LOG : " + getClass().getName()+"() 생성");
		a1Repository = sqlSession.getMapper(A1Repository.class);
	}
	
	// 전체 회사 정보 출력
	public List<Erp_CompanyVO> list_company() {return a1Repository.findAll_company();}
	
	// 회사 정보 저장
	public int save_company(Erp_CompanyVO erp_CompanyVO) {return a1Repository.save_company(erp_CompanyVO);}

	// 회사 정보 수정
	public int update_company(Erp_CompanyVO erp_CompanyVO) {return a1Repository.update_company(erp_CompanyVO);}
	
	// 회사 정보 삭제
	public int delete_company(int company_no) {return a1Repository.delete_company(company_no);}

	// 업정코드목록조회 정보 출력
	public List<Erp_BusinesstypeVO> bstlist() {return a1Repository.findBstAll();}
	

}