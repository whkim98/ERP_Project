package com.lab.erp.controller.intranet;


import java.net.URLEncoder;
import java.util.HashMap;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lab.erp.common.ViewPath;
import com.lab.erp.service.intranet.IntranetService;
import com.lab.erp.service.login.LoginService;
import com.lab.erp.vo.c.Erp_CountryVO;
import com.lab.erp.vo.intranet.Erp_ChatVO;
import com.lab.erp.vo.intranet.Erp_ChatroomVO;
import com.lab.erp.vo.login.Erp_Employee1VO;
import com.lab.erp.vo.login.Erp_Employee2VO;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.log4j.Log4j2;


@Controller
@Log4j2
@RequestMapping("/intranet/chat")
public class ChatController {
	@Autowired
	private LoginService login;
	private IntranetService is;
	private HttpServletRequest request;
	private ServletContext application;
		
	public ChatController(LoginService login, IntranetService is, HttpServletRequest request, ServletContext application) {
		this.login = login;
		this.is = is;
		this.request = request;
		this.application = application;
	}
	
	
	public static String blobToString(final byte[] blob) throws Exception{
		 
		 return new String(blob);
		 
	}
	
	// Friend List > 직원 목록
	@RequestMapping("/erpchat")		
	public String erpChat(String comcode_code, String type, String word, Model model, Erp_Employee2VO vo) {
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		int comcode_no = login.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		map.put("employee2_no", vo.getEmployee2_no());
		
		List<Map<String, Object>> list = is.EmpList(map);
		
		model.addAttribute("list", list);
		
		return ViewPath.CHAT + "erpChatEmpList";
	}
	
	@RequestMapping("/erpchatAjax")			// 직원목록 Ajax
	@ResponseBody
	public List<Map<String, Object>> erpchatAjax(String comcode_code, String type, String word, Erp_Employee2VO vo){
		if(type == null || word == null) {
			type = null;
			word = null;
		}
		
		int comcode_no = login.comNo(comcode_code);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("comcode_no", comcode_no);
		map.put("employee2_no", vo.getEmployee2_no());
		
		List<Map<String, Object>> list = is.EmpList(map);
		
		if(list.isEmpty()) {
			list = null;
		}
		
		return list;
	}
	
	@RequestMapping("/createChatRoom")		// 채팅방 생성
	@Transactional
	public String createChatRoom(Erp_ChatroomVO vo, String comcode_code, Model model, Erp_Employee1VO evo) {
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		Map<String,Object> map = new HashMap<>();
		
		map.put("employee2_no1", vo.getEmployee2_no1());
		map.put("employee2_no2", vo.getEmployee2_no2());
		
		int roomNo = is.checkRoomNo(map);
		
		String encoder = URLEncoder.encode(evo.getEmployee1_name());;
		String position = URLEncoder.encode(evo.getEmployee2_position());
		
		if(roomNo != 0) {
			return "redirect:/intranet/chat/erpchatroom?chatroom_no="+roomNo+"&comcode_code="+comcode_code+"&employee1_name="+encoder+"&employee2_position="+position;
		}else {
			
			int comcode_no = login.comNo(comcode_code);
			
			vo.setComcode_no(comcode_no);
			
			is.createChatRoom(vo);
			
			vo.setChatroom_no(is.getRoomMaxNo());
			
			return "redirect:/intranet/chat/erpchatroom?chatroom_no="+vo.getChatroom_no()+"&comcode_code="+comcode_code+"&employee1_name="+encoder+"&employee2_position="+position;
		}
	}
	
	
	
//	chatroom List
	@RequestMapping("/erpchatlist")		// 채팅방 목록
	public String erpChatList(String comcode_code, Model model, Erp_Employee2VO vo) {
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", null);
		map.put("employee2_no", vo.getEmployee2_no());
		
		List<Map<String, Object>> list = is.chatRoomList(map);
		
		if(list.isEmpty()) {
			list = null;
		}
		
		model.addAttribute("list", list);
		
		return ViewPath.CHAT + "erpChatList";
	}
	
	@RequestMapping("/erpchatlistAjax")		// 채팅방 목록 검색
	@ResponseBody
	public List<Map<String, Object>> erpchatlistAjax(String comcode_code, Model model, Erp_Employee2VO vo, String type, String word) {
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("type", type);
		map.put("word", word);
		map.put("employee2_no", vo.getEmployee2_no());
		
		List<Map<String, Object>> list = is.chatRoomList(map);
		
		if(list.isEmpty()) {
			list = null;
		}
		
		return list;
	}
	
	
// 	chat
	@RequestMapping("/erpchatroom")			// 채팅방
	public String erpchatroom(Erp_ChatroomVO vo, Model model, String comcode_code, Erp_Employee1VO evo) {
		String msg = null;
		String url = null;
		
		if(comcode_code == null || comcode_code.isEmpty()) {
			request.getSession().invalidate();
			msg = "세션이 만료되었습니다. 다시 로그인해주세요.";
			url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return ViewPath.RESULT + "loginresult";
		}
		
		log.info("@ChatController, chat GET()");
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("chatroom_no", vo.getChatroom_no());
		
		List<Map<String, Object>> chatlist = is.getChating(map);
		
		if(chatlist.isEmpty()) {
			chatlist = null;
		}
		
		if(vo.getChatroom_memo() == "") {
			vo.setChatroom_memo(null);
		}
		
		Map<String, Object> selectRoom = is.selectChatRoom(vo.getChatroom_no());
		
		model.addAttribute("chatlist", chatlist);					
		model.addAttribute("employee1_name", evo.getEmployee1_name());
		model.addAttribute("employee2_position", evo.getEmployee2_position());
		model.addAttribute("selectRoom", selectRoom);
		
		return ViewPath.CHAT + "erpChatroom";
	}
	
	@RequestMapping("/createChatAjax")			//  insert Ajax
	@Transactional
	@ResponseBody
	public List<Map<String, Object>> createChatAjax(Erp_ChatVO vo){

		is.createChat(vo);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("chatroom_no", vo.getChatroom_no());
		
		List<Map<String, Object>> chatlist = is.getChating(map);
		
		if(chatlist.isEmpty()) {
			chatlist = null;
		}
		
		return chatlist;
	}
	
	@RequestMapping("/deleteChatAjax")			// 대화 내용 Ajax
	@Transactional
	@ResponseBody
	public List<Map<String, Object>> deleteChatAjax(Erp_ChatVO vo){
		is.deleteChat(vo.getChat_no());
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("chatroom_no", vo.getChatroom_no());
		
		List<Map<String, Object>> chatlist = is.getChating(map);
		
		return chatlist;
	}
	
	@RequestMapping(value = "/updateChatTitle", produces = "application/text;charset=utf8")	
	@Transactional
	@ResponseBody
	public String updateChatTitle(Erp_ChatroomVO vo) {
		
		is.updateChatTitle(vo);
		
		if(vo.getChatroom_title() == "") {
			vo.setChatroom_title(null);
		}
		
		return vo.getChatroom_title();
	}
	
	@RequestMapping(value = "/updateChatMemo", produces = "application/text;charset=utf8")		
	@Transactional
	@ResponseBody
	public String updateChatMemo(Erp_ChatroomVO vo) {
		
		is.updateChatMemo(vo);
		
		if(vo.getChatroom_memo() == null) {
			vo.setChatroom_memo(null);
		}
		
		return vo.getChatroom_memo();
	}
	
	@RequestMapping("/deleteChatRoom")	
	@Transactional
	public String deleteChatRoom(Erp_ChatroomVO vo, String comcode_code) {
		is.deleteAllChat(vo.getChatroom_no());
		
		is.deleteChatRoom(vo.getChatroom_no());
		
		return "redirect:/intranet/chat/erpchatlist?comcode_code="+comcode_code+"&employee2_no="+vo.getEmployee2_no1();
	}
	
	@RequestMapping("/searchMsgCheck")
	@ResponseBody
	public List<Map<String, Object>> searchMsg(Erp_ChatroomVO vo) {
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("chatroom_no", vo.getChatroom_no());
		
		List<Map<String, Object>> chatlist = is.getChating(map);
		
		if(chatlist.isEmpty()) {
			chatlist = null;
		}
		
		return chatlist;
	}
}
