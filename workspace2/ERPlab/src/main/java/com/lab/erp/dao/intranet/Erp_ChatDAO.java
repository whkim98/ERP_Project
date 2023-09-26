package com.lab.erp.dao.intranet;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.intranet.Erp_ChatVO;

@Component
public class Erp_ChatDAO {
	@Autowired
	private SqlSession sqlSession;

	public Erp_ChatDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public int createChat(Erp_ChatVO vo) {
		return sqlSession.insert("intranetchat.createChat", vo);
	}
	
	public int deleteChat(int chat_no) {
		return sqlSession.delete("intranetchat.deleteChat", chat_no);
	}
	public int deleteAllChat(int chatroom_no) {
		return sqlSession.delete("intranetchat.deleteAllChat", chatroom_no);
	}
	
	public List<Map<String, Object>> getChating(Map<String, Object> map){
		return sqlSession.selectList("intranetchat.getChating", map);
	}
	
}
