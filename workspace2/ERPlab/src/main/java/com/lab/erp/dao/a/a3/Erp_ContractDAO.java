package com.lab.erp.dao.a.a3;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.a.a3.Erp_ContractVO;
import com.lab.erp.vo.a.a3.Erp_ContractkindVO;
import com.lab.erp.vo.a.a3.Erp_ProjectVO;
import com.lab.erp.vo.c.Erp_ClientVO;

@Component
public class Erp_ContractDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_ContractDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public int createContract(Erp_ContractVO vo) {
		return sqlSession.insert("a3.createContract", vo);
	}
	
	public int updateContract(Erp_ContractVO vo) {
		return sqlSession.update("a3.updateContract", vo);
	}
	
	public int deleteContract(int contract_no) {
		return sqlSession.delete("a3.deleteContractC", contract_no);
	}
	
	public List<Map<String, Object>> prContractList(Map<String, Object> map){
		return sqlSession.selectList("a3.prContractList", map);
	}
	
	public Map<String, Object> selectContract(int contract_no){
		return sqlSession.selectOne("a3.selectContract", contract_no);
	}
	
	public Erp_ContractkindVO getCkNo(String contractkind_name){
		return sqlSession.selectOne("a3.getCkNo", contractkind_name);
	}
	
	public Erp_ClientVO getClientNo(String client_name) {
		return sqlSession.selectOne("a3.getClientNo", client_name);
	}
	public Map<String, Object> getClient(int client_no) {
		return sqlSession.selectOne("a3.getClient", client_no);
	}
	
	public Erp_ProjectVO getProjectNo(String project_name) {
		return sqlSession.selectOne("a3.getProjectNo", project_name);
	}
	
	public Erp_ProjectVO getProject(Map<String, Object> map) {
		return sqlSession.selectOne("a3.getProject", map);
	}
	public Erp_ClientVO getCl(Map<String, Object> map) {
		return sqlSession.selectOne("a3.getCl", map);
	}
	public Erp_ContractkindVO getCk(String contractkind_name) {
		return sqlSession.selectOne("a3.ckName", contractkind_name);
	}
	
	public List<Erp_ContractkindVO> ckList(Map<String, Object> map){
		return sqlSession.selectList("a3.getCk", map);
	}
	
	public List<Erp_ClientVO> clList(Map<String, Object> map){
		return sqlSession.selectList("a3.clList", map);
	}
	
	public List<Erp_ProjectVO> prList(Map<String, Object> map){
		return sqlSession.selectList("a3.prList", map);
	}
}
