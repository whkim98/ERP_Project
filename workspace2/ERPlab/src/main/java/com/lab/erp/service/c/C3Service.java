package com.lab.erp.service.c;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.lab.erp.repository.c3.C3Repository;
import com.lab.erp.vo.c.c3.Erp_EventVO;

@Service
public class C3Service {
	private C3Repository c3Repository;
	
	public C3Service(SqlSession sqlSession) {
		System.out.println("### LOG : " + getClass().getName()+ "() 생성");
		c3Repository = sqlSession.getMapper(C3Repository.class);
	}
	
	// 전체 행사 정보 출력
	public List<Erp_EventVO> list() {return c3Repository.findAll();}
	
	
}
