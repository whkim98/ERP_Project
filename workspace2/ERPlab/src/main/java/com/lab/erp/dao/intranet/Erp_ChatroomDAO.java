package com.lab.erp.dao.intranet;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lab.erp.vo.intranet.Erp_ChatroomVO;

@Component
public class Erp_ChatroomDAO {
	@Autowired
	private SqlSession sqlSession;

	public Erp_ChatroomDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public int createChatRoom(Erp_ChatroomVO vo) {
		return sqlSession.insert("intranetchat.createChatRoom", vo);
	}
	
	public int updateChatTitle(Erp_ChatroomVO vo) {
		return sqlSession.update("intranetchat.updateChatTitle", vo);
	}
	
	public int updateChatMemo(Erp_ChatroomVO vo) {
		return sqlSession.update("intranetchat.updateChatMemo", vo);
	}
	
	public int inviteChat(Erp_ChatroomVO vo) {
		return sqlSession.update("intranetchat.inviteChat", vo);
	}
	
	public int deleteChatRoom(int chatroom_no) {
		return sqlSession.delete("intranetchat.deleteChatRoom", chatroom_no);
	}
	
	public List<Map<String, Object>> chatRoomList(Map<String, Object> map){
		return sqlSession.selectList("intranetchat.chatRoomList", map);
	}
	
	public Map<String, Object> selectChatRoom(int chatroom_no){
		return sqlSession.selectOne("intranetchat.selectChatRoom", chatroom_no);
	}
	
	public int getRoomMaxNo() {
		return sqlSession.selectOne("intranetchat.getRoomMaxNo");
	}
	
	public int checkRoomNo(Map<String, Object> map) {
		if(sqlSession.selectOne("intranetchat.checkRoomNo", map) == null) {
			return 0;
		}else {
			return sqlSession.selectOne("intranetchat.checkRoomNo", map);
		}
	}
	
}
