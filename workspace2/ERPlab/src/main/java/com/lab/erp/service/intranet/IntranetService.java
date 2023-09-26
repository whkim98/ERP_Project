package com.lab.erp.service.intranet;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lab.erp.dao.intranet.Erp_ChatDAO;
import com.lab.erp.dao.intranet.Erp_ChatroomDAO;
import com.lab.erp.dao.login.Erp_EmployeeDAO;
import com.lab.erp.vo.intranet.Erp_ChatVO;
import com.lab.erp.vo.intranet.Erp_ChatroomVO;
import com.lab.erp.vo.login.Erp_Employee1VO;

@Service
public class IntranetService {
	private Erp_EmployeeDAO edao;
	private Erp_ChatDAO cdao;
	private Erp_ChatroomDAO crdao;
	
	@Autowired
	public IntranetService(Erp_EmployeeDAO edao, Erp_ChatDAO cdao, Erp_ChatroomDAO crdao) {
		this.edao = edao;
		this.cdao = cdao;
		this.crdao = crdao;
	}
	
	public int checkEmp(Map<String, Object> map) {
		return edao.checkEmp(map);
	}
	
	public Map<String, Object> getEmpName(Map<String, Object> map) {
		return edao.getEmpName(map);
	}
	
	public String findEmpId(Map<String, Object> map) {
		return edao.findEmpId(map);
	}
	
	public String findEmpPw(Map<String, Object> map) {
		return edao.findEmpPw(map);
	}
	
	public int checkCurrPw(Erp_Employee1VO vo) {
		return edao.checkCurrPw(vo);
	}
	
	public int updateEmpPw(Erp_Employee1VO vo) {
		return edao.updateEmpPw(vo);
	}
	
	public Map<String, Object> selectEmp(int employee2_no){
		return edao.selectEmp(employee2_no);
	}
	
	public List<Map<String, Object>> EmpList(Map<String, Object> map){
		return edao.EmpList(map);
	}
	
	
//	chatroom
	public int createChatRoom(Erp_ChatroomVO vo) {
		return crdao.createChatRoom(vo);
	}
	
	public int updateChatTitle(Erp_ChatroomVO vo) {
		return crdao.updateChatTitle(vo);
	}
	
	public int updateChatMemo(Erp_ChatroomVO vo) {
		return crdao.updateChatMemo(vo);
	}
	
	public int inviteChat(Erp_ChatroomVO vo) {
		return crdao.inviteChat(vo);
	}
	
	public int deleteChatRoom(int chatroom_no) {
		return crdao.deleteChatRoom(chatroom_no);
	}
	
	public List<Map<String, Object>> chatRoomList(Map<String, Object> map){
		return crdao.chatRoomList(map);
	}
	
	public Map<String, Object> selectChatRoom(int chatroom_no){
		return crdao.selectChatRoom(chatroom_no);
	}
	
	public int getRoomMaxNo() {
		return crdao.getRoomMaxNo();
	}
	
	public int checkRoomNo(Map<String, Object> map) {
		return crdao.checkRoomNo(map);
	}
	
	
//	chat
	public int createChat(Erp_ChatVO vo) {
		return cdao.createChat(vo);
	}
	
	public int deleteChat(int chat_no) {
		return cdao.deleteChat(chat_no);
	}
	
	public int deleteAllChat(int chatroom_no) {
		return cdao.deleteAllChat(chatroom_no);
	}
	
	public List<Map<String, Object>> getChating(Map<String, Object> map){
		return cdao.getChating(map);
	}
}
	
