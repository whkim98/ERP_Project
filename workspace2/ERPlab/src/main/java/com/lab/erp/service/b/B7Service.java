package com.lab.erp.service.b;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lab.erp.dao.b.b1.Erp_Bs1DAO;
import com.lab.erp.dao.b.b7.Erp_SuppliesDAO;
import com.lab.erp.dao.b.b7.Erp_ToolsDAO;
import com.lab.erp.dao.c.Erp_SalesgoodsDAO;
import com.lab.erp.vo.b.b1.Erp_Bs1VO;
import com.lab.erp.vo.b.b1.Erp_Bs2VO;
import com.lab.erp.vo.b.b1.Erp_Bs3VO;
import com.lab.erp.vo.b.b7.Erp_SuppliesVO;
import com.lab.erp.vo.b.b7.Erp_ToolsVO;

@Service
public class B7Service {

	private Erp_ToolsDAO tdao;
	private Erp_SuppliesDAO sdao;
	private Erp_Bs1DAO b1dao;
	private Erp_SalesgoodsDAO sgdao;
	
	@Autowired
	public B7Service(Erp_ToolsDAO tdao, Erp_SuppliesDAO sdao, Erp_Bs1DAO b1dao, Erp_SalesgoodsDAO sgdao) {
		this.tdao = tdao;
		this.sdao = sdao;
		this.b1dao = b1dao;
		this.sgdao = sgdao;
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
	
}
