package com.lab.erp.dao.b.b2;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.b.b2.Erp_BudgetVO;

@Component
public class Erp_BudgetDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_BudgetDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public List<Map<String, Object>> budgetList(Map<String, Object> map){
		return sqlSession.selectList("b2.budgetList", map);
	}
	
	public Map<String, Object> budgetList2(Map<String, Object> map){
		return sqlSession.selectOne("b2.budgetList2", map);
	}
	
	public int insertBudget(Erp_BudgetVO vo) {
		return sqlSession.insert("b2.insertBudget", vo);
	}
	
	public int updateBudget(Map<String, Object> map) {
		return sqlSession.update("b2.updateBudget", map);
	}
	
}
