package com.lab.erp.service.c;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.lab.erp.dao.a.a1.Erp_BusinesstypeDAO;
import com.lab.erp.dao.c.Erp_ClientDAO;
import com.lab.erp.dao.c.Erp_ClientsortDAO;
import com.lab.erp.dao.c.Erp_CountryDAO;
import com.lab.erp.vo.a.a1.Erp_BusinesstypeVO;
import com.lab.erp.vo.c.Erp_ClientVO;
import com.lab.erp.vo.c.Erp_ClientsortVO;
import com.lab.erp.vo.c.Erp_CountryVO;

@Service
public class C2Service {
	private Erp_ClientDAO cdao;
	private Erp_ClientsortDAO csdao;
	private Erp_BusinesstypeDAO bdao;
	private Erp_CountryDAO ctdao;
	
	public C2Service(Erp_ClientDAO cdao, Erp_ClientsortDAO csdao, Erp_BusinesstypeDAO bdao, Erp_CountryDAO ctdao) {
		this.cdao = cdao;
		this.csdao = csdao;
		this.bdao = bdao;
		this.ctdao = ctdao;
	}
	
	public int createClient(Erp_ClientVO vo) {
		return cdao.createClient(vo);
	}
	
	public int updateClient(Erp_ClientVO vo) {
		return cdao.updateClient(vo);
	}
	
	public int deleteClient(int client_no) {
		return cdao.deleteClient(client_no);
	}
	
	public List<Map<String, Object>> clientListb4(Map<String, Object> map){
		return cdao.clientList(map);
	}
	
	public Map<String, Object> selectClientb4(int client_no){
		return cdao.selectClientb4(client_no);
	}
	
	public Map<String, Object> clientGoods(int client_no){
		return cdao.clientGoods(client_no);
	}
	
	public List<Erp_ClientsortVO> csList(Map<String, Object> map) {
		return csdao.csList(map);
	}
	
	public List<Erp_CountryVO> countryList(Map<String, Object> map) {
		return ctdao.countryList(map);
	}
	
	public List<Erp_BusinesstypeVO> btList(Map<String, Object> map){
		return bdao.btList(map);
	}
	
	public List<Erp_BusinesstypeVO> btSubctgr(Map<String, Object> map) {
		return bdao.btSubctgr(map);
	}
	
	public List<Erp_BusinesstypeVO> btName(Map<String, Object> map) {
		return bdao.btName(map);
	}
	
	public Erp_CountryVO autoCountry(String country_name) {
		return ctdao.autoCountry(country_name);
	}
	
	public Erp_ClientsortVO autoSort(String clientsort_name) {
		return csdao.autoSort(clientsort_name);
	}
}
