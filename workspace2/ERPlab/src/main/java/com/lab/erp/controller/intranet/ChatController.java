package com.lab.erp.controller.intranet;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lab.erp.common.ViewPath;
import com.lab.erp.service.login.LoginService;
import com.lab.erp.vo.c.Erp_CountryVO;


@Controller
public class ChatController {
	private LoginService login;
		
	@Autowired
	public ChatController(LoginService login) {
		this.login = login;
	}
	
	// chatList
	@RequestMapping("/erpchat")
	public String erpChat(String comcode_code) {
		int comcode_no = login.comNo(comcode_code);

		
		return ViewPath.CHAT + "erpChatList";
	}
	
	// chatList
	@RequestMapping("/erpchatroom")
	public String erpChatroom(String comcode_code) {
		int comcode_no = login.comNo(comcode_code);
		
		
		return ViewPath.CHAT + "erpChatroom";
		
	}
	
}
