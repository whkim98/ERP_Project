package com.lab.erp.dao.c;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.c.Erp_ClientVO;

@Component
public class Erp_ClientDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_ClientDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public int updateClient(Map<String, Object> map) {
		return sqlSession.update("c1.updateClient", map);
	}
	
	public List<Erp_ClientVO> internationList(){
		return sqlSession.selectList("c1.internationList");
	}
	
//	a4
	public List<Map<String, Object>> clientList(Map<String, Object> map){
		return sqlSession.selectList("a4.clientList", map);
	}
	
	public Erp_ClientVO selectClienta4(int client_no) {
		return sqlSession.selectOne("a4.selectClient", client_no);
	}
	
	public Erp_ClientVO searchcl(Map<String, Object> map) {
		return sqlSession.selectOne("a4.searchcl", map);
	}
	
//	c2
	public int createClient(Erp_ClientVO vo) {
		return sqlSession.insert("c2.createClient", vo);
	}
	
	public int updateClient(Erp_ClientVO vo) {
		return sqlSession.update("c2.updateClient", vo);
	}
	
	public int deleteClient(int client_no) {
		return sqlSession.delete("c2.deleteClient", client_no);
	}
	
	public List<Map<String, Object>> clientListb4(Map<String, Object> map){
		return sqlSession.selectList("c2.clientList", map);
	}
	
	public Map<String, Object> selectClientb4(int client_no){
		return sqlSession.selectOne("c2.selectClient", client_no);
	}
	
	public int getClNo(String client_registeredno) {
		return sqlSession.selectOne("c2.getClNo", client_registeredno);
	}
	
	public Map<String, Object> clientGoods(int client_no){
		return sqlSession.selectOne("c2.clientGoods", client_no);
	}
	
	
//	d2
	public List<Map<String, Object>> selectClient2Goods(Map<String, Object> map){
		return sqlSession.selectList("d2.selectClient2Goods", map);
	}
	
	public List<Map<String, Object>> selectClient2Goodsd22(Map<String, Object> map){
		return sqlSession.selectList("d2.selectClient2Goodsd22", map);
	}
	
	public Map<String, Object> searchcld2(Map<String, Object> map) {
		return sqlSession.selectOne("d2.searchcl", map);
	}
	
	
	//========
	
	public List<Erp_ClientVO> selectClient(int country_no){
		return sqlSession.selectList("c2.selectClient", country_no);
	}
	
	public int insertClient(Erp_ClientVO vo) {
		return sqlSession.insert("c1.insertClient", vo);
	}
	
	public List<Map<String, Object>> internationList(Map<String, Object> map){
		return sqlSession.selectList("c1.internationList", map);
	}
	
	public Map<String, Object> internationList2(Map<String, Object> map){
		return sqlSession.selectOne("c1.internationList2", map);
	}
	
	public int changeClient(Map<String, Object> map) {
		return sqlSession.update("c1.changeClient", map);
	}
	
	public List<Erp_ClientVO> selectClientlist(){
		return sqlSession.selectList("c1.selectClientlist");
	}
	
	public int updateClient2(Map<String, Object> map) {
		return sqlSession.update("c1.updateClient2", map);
	}
	
	public int deleteClient2(int client_no) {
		return sqlSession.delete("c1.deleteClient2", client_no);
	}
	
	//d6
	public List<Erp_ClientVO> selectClient(){
		return sqlSession.selectList("d6.selectClient");
	}
	
}

	

