package com.lab.erp.service.b;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lab.erp.dao.b.b1.Erp_Bs1DAO;
import com.lab.erp.dao.b.b1.Erp_ClosingDAO;
import com.lab.erp.dao.b.b1.Erp_CreditorDAO;
import com.lab.erp.dao.b.b1.Erp_DebtorDAO;
import com.lab.erp.dao.b.b7.Erp_SuppliesDAO;
import com.lab.erp.dao.b.b7.Erp_SuppliestypeDAO;
import com.lab.erp.dao.b.b7.Erp_ToolsDAO;
import com.lab.erp.dao.b.b7.Erp_ToolstypeDAO;
import com.lab.erp.dao.c.Erp_SalesgoodsDAO;
import com.lab.erp.vo.b.b1.Erp_Bs1VO;
import com.lab.erp.vo.b.b1.Erp_Bs2VO;
import com.lab.erp.vo.b.b1.Erp_Bs3VO;
import com.lab.erp.vo.b.b1.Erp_ClosingVO;
import com.lab.erp.vo.b.b7.Erp_SuppliesVO;
import com.lab.erp.vo.b.b7.Erp_SuppliestypeVO;
import com.lab.erp.vo.b.b7.Erp_ToolsVO;
import com.lab.erp.vo.b.b7.Erp_ToolstypeVO;

@Service
public class B7Service {

	private Erp_ToolsDAO tdao;
	private Erp_SuppliesDAO sdao;
	private Erp_Bs1DAO b1dao;
	private Erp_SalesgoodsDAO sgdao;
	private Erp_ToolstypeDAO ttdao;
	private Erp_SuppliestypeDAO stdao;
	private Erp_CreditorDAO cdao;
	private Erp_DebtorDAO ddao;
	private Erp_ClosingDAO csdao;
	
	@Autowired
	public B7Service(Erp_ClosingDAO csdao, Erp_CreditorDAO cdao, Erp_DebtorDAO ddao, Erp_SuppliestypeDAO stdao, Erp_ToolstypeDAO ttdao, Erp_ToolsDAO tdao, Erp_SuppliesDAO sdao, Erp_Bs1DAO b1dao, Erp_SalesgoodsDAO sgdao) {
		this.tdao = tdao;
		this.sdao = sdao;
		this.b1dao = b1dao;
		this.sgdao = sgdao;
		this.ttdao = ttdao;
		this.stdao = stdao;
		this.cdao = cdao;
		this.ddao = ddao;
		this.csdao = csdao;
	}
	
	public List<Map<String, Object>> selectTools(Map<String, Object> map){
		return tdao.selectTools(map);
	}
	
	public int insertTools(Erp_ToolsVO vo) {
		return tdao.insertTools(vo);
	}
	
	public int selectBsno(int bs3_no) {
		return b1dao.selectBsno(bs3_no);
	}
	
	public int selectBsno2(int bs3_no) {
		return b1dao.selectBsno2(bs3_no);
	}
	
	public int updateBs3(Erp_Bs3VO vo) {
		return b1dao.updateBs3(vo);
	}
	
	public int updateBs2(Erp_Bs2VO vo) {
		return b1dao.updateBs2(vo);
	}
	
	public int updateBs(Erp_Bs1VO vo) {
		return b1dao.updateBs(vo);
	}
	
	public int selectSumqty(int salesgoods_no) {
		return sgdao.selectSumqty(salesgoods_no);
	}
	
	public List<Map<String, Object>> selectSupplies(Map<String, Object> map){
		return sdao.selectSupplies(map);
	}
	
	public int insertSupplies(Erp_SuppliesVO vo) {
		return sdao.insertSupplies(vo);
	}
	
	public List<Erp_Bs1VO> selectBsdeb(){
		return b1dao.selectBsdeb();
	}
	
	public List<Erp_Bs1VO> selectBscre(){
		return b1dao.selectBscre();
	}
	
	public List<Erp_Bs1VO> selectBsdeb2(){
		return b1dao.selectBsdeb2();
	}
	
	public List<Erp_Bs1VO> selectBscre2(){
		return b1dao.selectBscre2();
	}
	
	public List<Erp_ToolstypeVO> toolstypeList(){
		return ttdao.toolstypeList();
	}
	
	public List<Erp_SuppliestypeVO> suppliestypeList(){
		return stdao.suppliestypeList();
	}
	
	public Map<String, Object> selectSupplies2(Map<String, Object> map){
		return sdao.selectSupplies2(map);
	}
	
	public Map<String, Object> selectTools2(Map<String, Object> map){
		return tdao.selectTools2(map);
	}
	
	public int selectDebno(int bs3_no) {
		return ddao.selectDebno(bs3_no);
	}
	
	public int selectCreno(int bs3_no) {
		return cdao.selectCreno(bs3_no);
	}
	
	public int insertToolclosing(Erp_ClosingVO vo) {
		return csdao.insertToolclosing(vo);
	}
	
	public int updateTools(Map<String, Object> map) {
		return tdao.updateTools(map);
	}
	
	public int selectToolstotal(int tools_no) {
		return tdao.selectToolstotal(tools_no);
	}
	
	public int selectSuppliestotal(int supplies_no) {
		return sdao.selectSuppliestotal(supplies_no);
	}
	
	public int updateSupplies(Map<String, Object> map) {
		return sdao.updateSupplies(map);
	}
	
}
