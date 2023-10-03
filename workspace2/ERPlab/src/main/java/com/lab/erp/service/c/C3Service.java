package com.lab.erp.service.c;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import com.lab.erp.repository.c3.C3Repository;
import com.lab.erp.vo.a.a1.Erp_CompanyVO;
import com.lab.erp.vo.all.Erp_CtgrVO;
import com.lab.erp.vo.b.b1.Erp_ClosingVO;
import com.lab.erp.vo.b.b1.Erp_CreditorVO;
import com.lab.erp.vo.b.b1.Erp_DebtorVO;
import com.lab.erp.vo.b.b3.Erp_SettletypeVO;
import com.lab.erp.vo.c.Erp_SalesgoodsVO;
import com.lab.erp.vo.c.c3.Erp_EventVO;
import com.lab.erp.vo.c.c3.Erp_OnlineVO;
import com.lab.erp.vo.c.c3.Erp_StoresalesVO;
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
	public List<Erp_StoresalesVO> list_storesales() {return c3Repository.findAll_storesales();}
	
	public int save_storesales(Erp_StoresalesVO erp_StoresalesVO) {return c3Repository.save_storesales(erp_StoresalesVO);}
		
	public int update_storesales(Erp_StoresalesVO erp_StoresalesVO) {return c3Repository.update_storesales(erp_StoresalesVO);}
	
	public int delete_storesales(int storesales_no) {return c3Repository.delete_storesales(storesales_no);}
	
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
		
	public int update_goodslot_plus(int goodslot_qty, int goodslot_no) {return c3Repository.update_goodslot_plus(goodslot_qty, goodslot_no);}
	
	public int update_goodslot_minus(int goodslot_qty, int goodslot_no) {return c3Repository.update_goodslot_minus(goodslot_qty, goodslot_no);}
	
	public List<Erp_SalesgoodsVO> findSalesgoodsAll() {return c3Repository.findSalesgoodsAll();}

	public int save_salesgoods(Erp_SalesgoodsVO erp_SalesgoodsVO) {return c3Repository.save_salesgoods(erp_SalesgoodsVO);}
	
	public int delete_salesgoods(int salesgoods_no) {return c3Repository.delete_salesgoods(salesgoods_no);}
	
	// ---------일마감---------
	public int update_bs1_plus (int bs1_amount, int bs1_no) {return c3Repository.update_bs1_plus(bs1_amount, bs1_no);}
	
	public int update_bs1_minus (int bs1_amount, int bs1_no) {return c3Repository.update_bs1_minus(bs1_amount, bs1_no);}
	
	public int update_bs2_plus (int bs2_amount, int bs2_no) {return c3Repository.update_bs2_plus(bs2_amount, bs2_no);}
	
	public int update_bs2_minus (int bs2_amount, int bs2_no) {return c3Repository.update_bs2_minus(bs2_amount, bs2_no);}
	
	public int update_bs3_plus (int bs3_amount, int bs3_no) {return c3Repository.update_bs3_plus(bs3_amount, bs3_no);}
	
	public int update_bs3_minus (int bs3_amount, int bs3_no) {return c3Repository.update_bs3_minus(bs3_amount, bs3_no);}
	
	public List<Erp_ClosingVO> findClosingOne(int ctgr_no, String closing_code, String closing_date) {return c3Repository.findClosingOne(ctgr_no, closing_code, closing_date);}

	public int save_closing(Erp_ClosingVO erp_ClosingVO) {return c3Repository.save_closing(erp_ClosingVO);}
	
	public int delete_closing(int closing_no) {return c3Repository.delete_closing(closing_no);}
	
	public int findLastIdDebtor() {return c3Repository.findLastIdDebtor();}
	
	public int save_debtor (Erp_DebtorVO erp_DebtorVO) {return c3Repository.save_debtor(erp_DebtorVO);}
	
	public int delete_debtor(int debtor_no) {return c3Repository.delete_debtor(debtor_no);}
	
	public int findLastIdCreditor() {return c3Repository.findLastIdCreditor();}
	
	public int save_creditor (Erp_CreditorVO erp_CreditorVO) {return c3Repository.save_creditor(erp_CreditorVO);}
	
	public int delete_creditor(int creditor_no) {return c3Repository.delete_creditor(creditor_no);}
}
