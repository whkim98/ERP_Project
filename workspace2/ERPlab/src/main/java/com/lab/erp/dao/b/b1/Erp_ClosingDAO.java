package com.lab.erp.dao.b.b1;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.b.b1.Erp_ClosingVO;

@Component
public class Erp_ClosingDAO {
private SqlSession sqlSession;
	
	@Autowired
	public Erp_ClosingDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

//	b1
	public int createClosing(Erp_ClosingVO vo) {
		return sqlSession.insert("b1.createClosing",vo);
	}
	
	public int updateClosing(Erp_ClosingVO vo) {
		return sqlSession.update("b1.updateClosing", vo);
	}
	
	public int updateClosingPrice(Erp_ClosingVO vo) {
		return sqlSession.update("b1.updateClosingPrice", vo);
	}
	
	public int deleteClosing(int closing_no) {
		return sqlSession.delete("b1.deleteClosing", closing_no);
	}
	
	public int getClosingNo(String closing_code) {
		return sqlSession.selectOne("b1.getClosingNo", closing_code);
	}
	
	public Erp_ClosingVO getClosing(int closing_no) {
		return sqlSession.selectOne("b1.getClosing", closing_no);
	}
	
	
//	b4
	public List<Map<String, Object>> deadlineList(Map<String, Object> map){
		return sqlSession.selectList("b4.deadlineList", map);
	}
	
	public Erp_ClosingVO totalAmount(Map<String, Object> map) {
		return sqlSession.selectOne("b4.totalAmount", map);
	}
	
	public List<Map<String, Object>> selectCtgr(Map<String, Object> map) {
		return sqlSession.selectList("b4.selectCtgr", map);
	}
	
	public Erp_ClosingVO ctgrAmount(Map<String, Object> map) {
		return sqlSession.selectOne("b4.ctgrAmount", map);
	}
	
	
//	d1
	public Map<String, Object> getClosingCode(String closing_code){
		return sqlSession.selectOne("b1.getClosingCode",closing_code);
	}
	
	//===============
	

		
	//b6
		public int insertClosing(Erp_ClosingVO vo) {
			return sqlSession.insert("b6.insertClosing", vo);
		}

	//c1
		public int insertClosingC1(Erp_ClosingVO vo) {
			return sqlSession.insert("c1.insertClosing", vo);
		}
		
		public int insertClosingforsales(Erp_ClosingVO vo) {
			return sqlSession.insert("c1.insertClosing1", vo);
		}
		
		public int closingUpdate(Map<String, Object> map) {
			return sqlSession.update("c1.closingUpdate", map);
		}
		
		public int selectClosingno(String closing_code) {
			return sqlSession.selectOne("c1.selectClosingno", closing_code);
		}
		
		public int updateClosing2(Map<String, Object> map) {
			return sqlSession.update("c1.updateClosing2", map);
		}
		
		public int updateClosing(Map<String, Object> map) {
			return sqlSession.update("c1.updateClosing", map);
		}
		
		public int selectClosingdb(String closing_code) {
			return sqlSession.selectOne("c1.selectClosingdb", closing_code);
		}
		
		public int selectClosingcr(String closing_code) {
			return sqlSession.selectOne("c1.selectClosingcr", closing_code);
		}
		
		public int insertToolclosing(Erp_ClosingVO vo) {
			return sqlSession.insert("b7.insertToolclosing", vo);
		}
		
		public int selectDebtorno2(String closing_code) {
			return sqlSession.selectOne("c1.selectDebtorno2", closing_code);
		}
		
		public int selectCreditorno2(String closing_code) {
			return sqlSession.selectOne("c1.selectCreditorno2", closing_code);
		}
		
		//b2
		public List<Map<String, Object>> closingList(Map<String, Object> map){
			return sqlSession.selectList("b2.closingList", map);
		}
		
	}

	

