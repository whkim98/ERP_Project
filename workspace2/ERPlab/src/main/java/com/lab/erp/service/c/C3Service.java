package com.lab.erp.service.c;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.lab.erp.repository.c3.C3Repository;
import com.lab.erp.vo.c.c3.Erp_EventVO;
import com.lab.erp.vo.d.d6.Erp_GoodsVO;

@Service
public class C3Service {
	private C3Repository c3Repository;
	
	public C3Service(SqlSession sqlSession) {
		System.out.println("### LOG : " + getClass().getName()+ "() 생성");
		c3Repository = sqlSession.getMapper(C3Repository.class);
	}
	
	// 전체 행사 정보 출력
	public List<Erp_EventVO> list() {return c3Repository.findAll();}
	
	// 회사 정보 저장
	public int save (Erp_EventVO erp_EventVO) {return c3Repository.save(erp_EventVO);}
	
	// 회사 정보 수정
	public int update (Erp_EventVO erp_EventVO) {return c3Repository.update(erp_EventVO);}
	
	// 회사 정보 삭제
	public int delete(int event_no) {return c3Repository.delete(event_no);}
	
	// 상품등록 조회용 전체 상품 정보 출력
	public List<Erp_GoodsVO> findGoodsAll() {return c3Repository.findGoodsAll();}
}
