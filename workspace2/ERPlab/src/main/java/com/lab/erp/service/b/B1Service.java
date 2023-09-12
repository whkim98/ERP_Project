package com.lab.erp.service.b;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lab.erp.dao.b.b1.Erp_Bs1DAO;
import com.lab.erp.dao.b.b1.Erp_Bs2DAO;
import com.lab.erp.dao.b.b1.Erp_Bs3DAO;
import com.lab.erp.vo.b.b1.Erp_Bs1VO;
import com.lab.erp.vo.b.b1.Erp_Bs2VO;
import com.lab.erp.vo.b.b1.Erp_Bs3VO;

@Service
public class B1Service {
	private Erp_Bs3DAO bs3dao;
	private Erp_Bs2DAO bs2dao;
	private Erp_Bs1DAO bs1dao;
	
	@Autowired
	public B1Service(Erp_Bs3DAO bs3dao, Erp_Bs2DAO bs2dao, Erp_Bs1DAO bs1dao) {
		this.bs3dao = bs3dao;
		this.bs2dao = bs2dao;
		this.bs1dao = bs1dao;
		
	}
	
	// bs
	public List<Erp_Bs3VO> bs3List(){
		return bs3dao.bs3List();
	}
	public List<Erp_Bs2VO> bs2List(){
		return bs2dao.bs2List();
	}
	public List<Erp_Bs1VO> bs1List(){
		return bs1dao.bs1List();
	}

	
	public List<Erp_Bs3VO> bsList(){
		return bs3dao.bsList();
	}
	public List<Erp_Bs3VO> bs2ctgrList(){
		return bs3dao.bs2ctgrList();
	}
	
	public List<Erp_Bs3VO> bs3ctgr(int bs2_no){
		return bs3dao.bs3ctgr(bs2_no);
	}
	public List<Erp_Bs3VO> bs2ctgr(int bs1_no){
		return bs3dao.bs2ctgr(bs1_no);
	}
	public List<Erp_Bs3VO> bs1ctgr(int bs1_no){
		return bs3dao.bs1ctgr(bs1_no);
	}
	
	
	
}
