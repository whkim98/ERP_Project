package com.lab.erp.service.d;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lab.erp.dao.c.Erp_ClientDAO;
import com.lab.erp.dao.d.d6.Erp_GoodsDAO;
import com.lab.erp.dao.d.d6.Erp_GoodskindDAO;
import com.lab.erp.dao.d.d6.Erp_GoodslevDAO;
import com.lab.erp.dao.d.d6.Erp_GoodslotDAO;
import com.lab.erp.dao.d.d6.Erp_GoodsstDAO;
import com.lab.erp.vo.c.Erp_ClientVO;
import com.lab.erp.vo.d.d6.Erp_GoodskindVO;
import com.lab.erp.vo.d.d6.Erp_GoodslevVO;
import com.lab.erp.vo.d.d6.Erp_GoodsstVO;

@Service
public class D6Service {

	private Erp_GoodslotDAO gldao;
	private Erp_GoodskindDAO gkdao;
	private Erp_GoodsstDAO gsdao;
	private Erp_GoodslevDAO gvdao;
	private Erp_ClientDAO ecdao;
	private Erp_GoodsDAO gdao;
	
	@Autowired
	public D6Service(Erp_GoodsDAO gdao, Erp_GoodsstDAO gsdao, Erp_GoodslevDAO gvdao, Erp_ClientDAO ecdao, Erp_GoodslotDAO gldao, Erp_GoodskindDAO gkdao) {
		this.gldao = gldao;
		this.gkdao = gkdao;
		this.gsdao = gsdao;
		this.gvdao = gvdao;
		this.ecdao = ecdao;
		this.gdao = gdao;
	}
	
	public List<Map<String, Object>> selectGoods(Map<String, Object> map){
		return gldao.selectGoods(map);
	}
	
	public List<Erp_GoodskindVO> selectGoodskind(){
		return gkdao.selectGoodskind();
	}
	
	public List<Erp_GoodsstVO> selectGoodsst(){
		return gsdao.selectGoodsst();
	}
	
	public List<Erp_GoodslevVO> selectGoodslev(){
		return gvdao.selectGoodslev();
	}
	
	public List<Erp_ClientVO> selectClient(){
		return ecdao.selectClient();
	}
	
	public int insertGoods(Map<String, Object> map) {
		return gdao.insertGoods(map);
	}
	
	public int insertGoodslot(Map<String, Object> map) {
		return gldao.insertGoodslot(map);
	}
	
	public int selectGoodsno(String goods_code) {
		return gdao.selectGoodsno(goods_code);
	}
	
}
