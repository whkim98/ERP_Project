package com.lab.erp.service.c;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import com.lab.erp.repository.c3.C3Repository;
import com.lab.erp.vo.a.a1.Erp_CompanyVO;
import com.lab.erp.vo.all.Erp_CtgrVO;
import com.lab.erp.vo.b.b3.Erp_SettletypeVO;
import com.lab.erp.vo.c.c3.Erp_EventVO;
import com.lab.erp.vo.c.c3.Erp_OnlineVO;
import com.lab.erp.vo.c.c3.Erp_WarehouseVO;
import com.lab.erp.vo.c.c4.Erp_CustomerVO;
import com.lab.erp.vo.d.d6.Erp_GoodsVO;
import com.lab.erp.vo.d.d6.Erp_GoodslotVO;
import com.lab.erp.vo.login.Erp_TeamVO;

@Service
public class C3Service {
	private C3Repository c3Repository;
	
	public C3Service(SqlSession sqlSession) {
		System.out.println("### LOG : " + getClass().getName()+ "() 생성");
		c3Repository = sqlSession.getMapper(C3Repository.class);
	}
	// ---------매장매출---------
	
	
	// ---------창고관리(재고관리)---------
	// 전체 재고 정보 출력
	public List<Erp_WarehouseVO> list_warehouse() {return c3Repository.findAll_warehouse();}
	
	// 재고 정보 저장
	public int save_warehouse(Erp_WarehouseVO erp_WarehouseVO) {return c3Repository.save_warehouse(erp_WarehouseVO);}
	
	//재고 정보 수정
	public int update_warehouse(Erp_WarehouseVO erp_WarehouseVO) {return c3Repository.update_warehouse(erp_WarehouseVO);}
	
	//재고 정보 삭제
	public int delete_warehouse(int warehouse_no) {return c3Repository.delete_warehouse(warehouse_no);}
	
	// ---------행사---------
	// 전체 행사 정보 출력
	public List<Erp_EventVO> list_event() {return c3Repository.findAll_event();}
	
	// 회사 정보 저장
	public int save_event (Erp_EventVO erp_EventVO) {return c3Repository.save_event(erp_EventVO);}
	
	// 회사 정보 수정
	public int update_event (Erp_EventVO erp_EventVO) {return c3Repository.update_event(erp_EventVO);}
	
	// 회사 정보 삭제
	public int delete_event(int event_no) {return c3Repository.delete_event(event_no);}
	
	// ---------온라인매출---------
	// 전체 온라인매출 정보 출력
	public List<Erp_OnlineVO> list_online() {return c3Repository.findAll_online();}
	
	// 온라인매출 정보 저장
	public int save_online(Erp_OnlineVO erp_OnlineVO) {return c3Repository.save_online(erp_OnlineVO);}
	
	// 온라인매출 정보 수정
	public int update_online(Erp_OnlineVO erp_OnlineVO) {return c3Repository.update_online(erp_OnlineVO);}
	
	// 온라인매출 정보 삭제
	public int delete_online(int online_no) {return c3Repository.delete_event(online_no);}
	
	// ---------상품조회---------
	// 상품등록 조회용 전체 상품 정보 출력
	public List<Erp_GoodsVO> findGoodsAll() {return c3Repository.findGoodsAll();}
	
	// ---------회사조회---------
	// 회사등록 조회용 전체 회사 정보 출력
	public List<Erp_CompanyVO> findCompanyAll() {return c3Repository.findCompanyAll();}
	
	// ---------카테고리조회---------
	public List<Erp_CtgrVO> findCtgrAll() {return c3Repository.findCtgrAll();}
	
	// ---------팀-부서조회---------
	public List<Erp_TeamVO> findTeamAll() {return c3Repository.findTeamAll();}
	
	// ---------고객정보조회---------
	public List<Erp_CustomerVO> findCustomerAll() {return c3Repository.findCustomerAll();}
	
	// ---------결제구분조회---------
	public List<Erp_SettletypeVO> findSettletypeAll() {return c3Repository.findSettletypeAll();}

	// ---------상품로트번호조회---------
	public List<Erp_GoodslotVO> findGoodslotAll() {return c3Repository.findGoodslotAll();}
}
