
package com.lab.erp.service.a;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.lab.erp.repository.a1.A1Repository;
import com.lab.erp.vo.a.a1.Erp_CompanyVO;

@Service
public class A1Service {

	private A1Repository a1Repository;
	
	public A1Service(SqlSession sqlSession) {
		System.out.println("### LOG : " + getClass().getName()+"() 생성");
		a1Repository = sqlSession.getMapper(A1Repository.class);
	}
	
	// 전체 회사 정보 출력
	public List<Erp_CompanyVO> list() {return a1Repository.findAll();}
	
	
}