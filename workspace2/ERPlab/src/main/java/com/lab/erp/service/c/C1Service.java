package com.lab.erp.service.c;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lab.erp.dao.a.a1.Erp_BusinesstypeDAO;
import com.lab.erp.dao.c.Erp_ClientDAO;
import com.lab.erp.dao.c.Erp_ReceivableDAO;
import com.lab.erp.dao.c.c1.Erp_ForsalesDAO;
import com.lab.erp.dao.c.c1.Erp_ImportpayDAO;
import com.lab.erp.dao.d.d6.Erp_GoodsDAO;
import com.lab.erp.vo.a.a1.Erp_BusinesstypeVO;
import com.lab.erp.vo.c.Erp_ClientVO;
import com.lab.erp.vo.c.Erp_ReceivableVO;
import com.lab.erp.vo.c.c1.Erp_ForsalesVO;
import com.lab.erp.vo.c.c1.Erp_ImportpayVO;
import com.lab.erp.vo.d.d6.Erp_GoodsVO;

@Service
public class C1Service {

	private Erp_ClientDAO cdao;
	private Erp_ReceivableDAO rdao;
	private Erp_BusinesstypeDAO bdao;
	private Erp_ForsalesDAO fdao;
	private Erp_GoodsDAO gdao;
	private Erp_ImportpayDAO idao;
	
	@Autowired
	public C1Service(Erp_ClientDAO cdao, Erp_ReceivableDAO rdao, Erp_BusinesstypeDAO bdao, Erp_ForsalesDAO fdao, Erp_GoodsDAO gdao, Erp_ImportpayDAO idao) {
		this.cdao = cdao;
		this.rdao = rdao;
		this.bdao = bdao;
		this.fdao = fdao;
		this.gdao = gdao;
		this.idao = idao;
	}
	
	public List<Erp_ClientVO> internationList(){
		return cdao.internationList();
	}
	
	public int insertClient(Erp_ClientVO vo) {
		return cdao.insertClient(vo);
	}
	
	public List<Erp_ReceivableVO> selectReceivable(){
		return rdao.selectReceivable();
	}
	
	public int updateClient(Map<String, Object> map) {
		return cdao.updateClient(map);
	}
	
	public List<Erp_BusinesstypeVO> selectType(){
		return bdao.selectType();
	}
	
	public List<Erp_ForsalesVO> selectForsales(){
		return fdao.selectForsales();
	}
	
	public int insertForsales(Erp_ForsalesVO vo) {
		return fdao.insertForsales(vo);
	}
	
	public List<Erp_GoodsVO> selectGoods(){
		return gdao.selectGoods();
	}
	
	public List<Erp_ImportpayVO> selectImportpay(){
		return idao.selectImportpay();
	}
	
}
