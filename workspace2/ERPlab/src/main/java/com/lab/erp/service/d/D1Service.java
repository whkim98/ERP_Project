package com.lab.erp.service.d;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lab.erp.dao.b.b1.Erp_Bs3DAO;
import com.lab.erp.dao.b.b1.Erp_ClosingDAO;
import com.lab.erp.dao.d.d1.Erp_ConnectrequestDAO;
import com.lab.erp.dao.d.d1.Erp_DefectiveDAO;
import com.lab.erp.dao.d.d1.Erp_EvaluationDAO;
import com.lab.erp.dao.d.d1.Erp_EvaluemngDAO;
import com.lab.erp.dao.d.d1.Erp_InvenlotDAO;
import com.lab.erp.dao.d.d1.Erp_LotconnevDAO;
import com.lab.erp.dao.d.d1.Erp_PedDAO;
import com.lab.erp.dao.d.d1.Erp_PedworkDAO;
import com.lab.erp.dao.d.d1.Erp_ProductDAO;
import com.lab.erp.dao.d.d1.Erp_ProinventoryDAO;
import com.lab.erp.dao.d.d1.Erp_RequestproductDAO;
import com.lab.erp.dao.d.d6.Erp_GoodsDAO;
import com.lab.erp.vo.b.b1.Erp_Bs3VO;
import com.lab.erp.vo.b.b1.Erp_ClosingVO;
import com.lab.erp.vo.d.d1.Erp_ConnectrequestVO;
import com.lab.erp.vo.d.d1.Erp_DefectiveVO;
import com.lab.erp.vo.d.d1.Erp_EvaluationVO;
import com.lab.erp.vo.d.d1.Erp_EvaluemngVO;
import com.lab.erp.vo.d.d1.Erp_InvenlotVO;
import com.lab.erp.vo.d.d1.Erp_LotconnevVO;
import com.lab.erp.vo.d.d1.Erp_PedVO;
import com.lab.erp.vo.d.d1.Erp_PedworkVO;
import com.lab.erp.vo.d.d1.Erp_ProductVO;
import com.lab.erp.vo.d.d1.Erp_ProinventoryVO;
import com.lab.erp.vo.d.d1.Erp_RequestproductVO;

@Service
public class D1Service {
	private Erp_GoodsDAO gdao;
	private Erp_ConnectrequestDAO crdao;
	private Erp_PedworkDAO pwdao;
	private Erp_LotconnevDAO lcdao;
	private Erp_RequestproductDAO rpdao;
	private Erp_PedDAO pdao;
	private Erp_ProductDAO ptdao;
	private Erp_DefectiveDAO ddao;
	private Erp_EvaluationDAO edao;
	private Erp_EvaluemngDAO emdao;
	private Erp_ProinventoryDAO pidao;
	private Erp_InvenlotDAO idao;
	private Erp_Bs3DAO bsdao;
	private Erp_ClosingDAO cldao;
	
	
	@Autowired
	public D1Service(Erp_GoodsDAO gdao, Erp_ConnectrequestDAO crdao, Erp_PedworkDAO pwdao, Erp_LotconnevDAO lcdao,
			Erp_RequestproductDAO rpdao, Erp_PedDAO pdao, Erp_ProductDAO ptdao, Erp_DefectiveDAO ddao,
			Erp_EvaluationDAO edao, Erp_EvaluemngDAO emdao, Erp_ProinventoryDAO pidao, Erp_InvenlotDAO idao,
			Erp_Bs3DAO bsdao, Erp_ClosingDAO cldao) {
		super();
		this.gdao = gdao;
		this.crdao = crdao;
		this.pwdao = pwdao;
		this.lcdao = lcdao;
		this.rpdao = rpdao;
		this.pdao = pdao;
		this.ptdao = ptdao;
		this.ddao = ddao;
		this.edao = edao;
		this.emdao = emdao;
		this.pidao = pidao;
		this.idao = idao;
		this.bsdao = bsdao;
		this.cldao = cldao;
	}


//	계정과목
	public List<Erp_Bs3VO> ctgrDebtor(int ctgr_no){
		return bsdao.ctgrDebtor(ctgr_no);
	}
	public List<Erp_Bs3VO> ctgrCreditor(int ctgr_no){
		return bsdao.ctgrCreditor(ctgr_no);
	}
	public Map<String, Object> getBsNo(int bs3_no){
		return bsdao.getBsNo(bs3_no);
	}
	public int updateBs1Amount(Map<String, Object> map) {
		return bsdao.updateBs1Amount(map);
	}
	public int updateBs2Amount(Map<String, Object> map) {
		return bsdao.updateBs2Amount(map);
	}
	public int updateBs3Amount(Map<String, Object> map) {
		return bsdao.updateBs3Amount(map);
	}
	
	
//	일마감
	public int createClosing(Erp_ClosingVO vo) {
		return cldao.createClosing(vo);
	}
	public int updateClosing(Erp_ClosingVO vo) {
		return cldao.updateClosing(vo);
	}
	public int deleteClosing(int closing_no) {
		return cldao.deleteClosing(closing_no);
	}
	public int getClosingNo(String closing_code) {
		return cldao.getClosingNo(closing_code);
	}
	public Erp_ClosingVO getClosing(int closing_no) {
		return cldao.getClosing(closing_no);
	}
	
	
//	goods list, goods selected
	public List<Map<String, Object>> goodsListd1(Map<String, Object> map){
		return gdao.goodsListd1(map);
	}
	
	public List<Map<String, Object>> selectRequestGoods(int requestproduct_no){
		return gdao.selectRequestGoods(requestproduct_no);
	}
	
	public List<Map<String, Object>> selectPedGoods(int ped_no){
		return gdao.selectPedGoods(ped_no);
	}
	
	public List<Map<String, Object>> selectEvGoods(int evaluation_no){
		return gdao.selectEvGoods(evaluation_no);
	}
	
	
//	connectrequest 
	public int createConnectRequest(Erp_ConnectrequestVO vo) {
		return crdao.createConnectRequest(vo);
	}
	
	public int updateConnectRequest(Erp_ConnectrequestVO vo) {
		return crdao.updateConnectRequest(vo);
	}
	
	public int deleteConnectRequest(int connectrequest_no) {
		return crdao.deleteConnectRequest(connectrequest_no);
	}
	
	public int deleteConnectRequestNo(int requestproduct_no) {
		return crdao.deleteConnectRequestNo(requestproduct_no);
	}
	
	
//	pedwork
	public int createPedWork(Erp_PedworkVO vo) {
		return pwdao.createPedWork(vo);
	}
	
	public int updatePedWork(Erp_PedworkVO vo) {
		return pwdao.updatePedWork(vo);
	}
	
	public int deletePedWork(int pedwork_no) {
		return pwdao.deletePedWork(pedwork_no);
	}
	
	public int deletePedWorkNo(int ped_no) {
		return pwdao.deletePedWorkNo(ped_no);
	}
	
	
//	lotconnev
	public int createLotEv(Erp_LotconnevVO vo) {
		return lcdao.createLotEv(vo);
	}
	
	public int updateLotEv(Erp_LotconnevVO vo) {
		return lcdao.updateLotEv(vo);
	}
	
	public int deleteLotEv(int lotconnev_no) {
		return lcdao.deleteLotEv(lotconnev_no);
	}
	
	public int deleteLotEvNo(int evaluation_no) {
		return lcdao.deleteLotEvNo(evaluation_no);
	}
	
	
//	requestproduct 생산의뢰
	public int createRequestProduct(Erp_RequestproductVO vo) {
		return rpdao.createRequestProduct(vo);
	}
	
	public int updateRequestProduct(Erp_RequestproductVO vo) {
		return rpdao.updateRequestProduct(vo);
	}
	
	public int deleteRequestProduct(int requestproduct_no) {
		return rpdao.deleteRequestProduct(requestproduct_no);
	}
	
	public List<Map<String, Object>> requestProductList(Map<String, Object> map){
		return rpdao.requestProductList(map);
	}
	
	public Map<String, Object> selectRequestProduct(int requestproduct_no){
		return rpdao.selectRequestProduct(requestproduct_no);
	}
	
	
//	ped 작업지시서
	public int createPed(Erp_PedVO vo) {
		return pdao.createPed(vo);
	}
	
	public int updatePed(Erp_PedVO vo) {
		return pdao.updatePed(vo);
	}
	
	public int deletePed(int ped_no) {
		return pdao.deletePed(ped_no);
	}
	
	public int deletePedRequest(int requestproduct_no) {
		return pdao.deletePedRequest(requestproduct_no);
	}
	
	public List<Map<String, Object>> pedList(Map<String, Object> map){
		return pdao.pedList(map);
	}
	
	public Map<String, Object> selectPed(int ped_no){
		return pdao.selectPed(ped_no);
	}
	
	
//	product 생산 / 제조
	public int createProduct(Erp_ProductVO vo) {
		return ptdao.createProduct(vo);
	}
	
	public int updateProduct(Erp_ProductVO vo) {
		return ptdao.updateProduct(vo);
	}
	
	public int deleteProduct(int product_no) {
		return ptdao.deleteProduct(product_no);
	}
	
	public List<Map<String, Object>> productList(Map<String, Object> map){
		return ptdao.productList(map);
	}
	
	public Map<String, Object> selectProduct(int product_no){
		return ptdao.selectProduct(product_no);
	}
	
	
//	defective 불량 관리
	public int createDefective(Erp_DefectiveVO vo) {
		return ddao.createDefective(vo);
	}
	
	public int updateDefective(Erp_DefectiveVO vo) {
		return ddao.updateDefective(vo);
	}
	
	public int deleteDefective(int defective_no) {
		return ddao.deleteDefective(defective_no);
	}
	
	public List<Map<String, Object>> defectiveList(Map<String, Object> map){
		return ddao.defectiveList(map);
	}
	
	public List<Map<String, Object>> defectiveListAll(Map<String, Object> map){
		return ddao.defectiveListAll(map);
	}
	
	public Map<String, Object> selectDefective(int defective_no){
		return ddao.selectDefective(defective_no);
	}
	
	public Map<String, Object> selectDefectiveAll(int defective_no){
		return ddao.selectDefectiveAll(defective_no);
	}
	
	
//	evaluation 생산실적평가
	public int createEvaluation(Erp_EvaluationVO vo) {
		return edao.createEvaluation(vo);
	}
	
	public int updateEvaluation(Erp_EvaluationVO vo) {
		return edao.updateEvaluation(vo);
	}
	
	public int deleteEvaluation(int evaluation_no) {
		return edao.deleteEvaluation(evaluation_no);
	}
	
	public List<Map<String, Object>> evaluationList(Map<String, Object> map){
		return edao.evaluationList(map);
	}
	
	public Map<String, Object> selectEvaluation(int evaluation_no){
		return edao.selectEvaluation(evaluation_no);
	}
	
	
//	evaluemng 실적 관리
	public int createEvaluemng(Erp_EvaluemngVO vo) {
		return emdao.createEvaluemng(vo);
	}
	
	public int updateEvaluemng(Erp_EvaluemngVO vo) {
		return emdao.updateEvaluemng(vo);
	}
	
	public int deleteEvaluemng(int evaluemng_no) {
		return emdao.deleteEvaluemng(evaluemng_no);
	}
	
	public List<Map<String, Object>> evmngList(Map<String, Object> map){
		return emdao.evmngList(map);
	}
	
	
//	proinventory 공정재고 관리
	public int createProInven(Erp_ProinventoryVO vo) {
		return pidao.createProInven(vo);
	}
	
	public int updateProInven(Erp_ProinventoryVO vo) {
		return pidao.updateProInven(vo);
	}
	
	public int deleteProInven(int proinventory_no) {
		return pidao.deleteProInven(proinventory_no);
	}
	
	public List<Map<String, Object>> proinvenList(Map<String, Object> map){
		return pidao.proinvenList(map);
	}
	
	public List<Map<String, Object>> selectProInven(Map<String, Object> map){
		return pidao.selectProInven(map);
	}
	
	public int createInvenLot(Erp_InvenlotVO vo) {
		return idao.createInvenLot(vo);
	}
	
	public int updateInvenLot(Erp_InvenlotVO vo) {
		return idao.updateInvenLot(vo);
	}
	
	public int deleteLot(int goodslot_no) {
		return idao.deleteLot(goodslot_no);
	}
	
	public int deleteInvenLot(int invenlot_no) {
		return idao.deleteInvenLot(invenlot_no);
	}
	
	public int deleteInvenPro(int proinventory_no) {
		return idao.deleteInvenPro(proinventory_no);
	}
}
