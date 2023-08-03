package com.lab.erp.controller.a;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lab.erp.service.a.A4Service;

@Controller
public class A4Controller {
	private A4Service a4;
	
	@Autowired
	public A4Controller(A4Service a4) {
		this.a4 = a4;
	}
	
}
