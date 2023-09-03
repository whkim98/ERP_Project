package com.lab.erp.controller.d;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lab.erp.service.d.D5Service;
import com.lab.erp.vo.c.Erp_ClientVO;
import com.lab.erp.vo.c.c3.Erp_WarehouseVO;
import com.lab.erp.vo.d.d5.Erp_ClaimVO;
import com.lab.erp.vo.d.d5.Erp_CsVO;
import com.lab.erp.vo.d.d5.Erp_CvalueVO;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;


@Controller
@RequestMapping("/d/d5")
public class D5Controller {
	private D5Service d5Service;
	
	@Autowired
	public void setD5Service(D5Service d5Service) {
		this.d5Service = d5Service;
	}
	
	// ---------클레임---------
	@GetMapping("/d51/claim")
	public String claim (Model model) {
		List<Erp_ClaimVO> list_res = d5Service.list_claim();
		model.addAttribute("claim_list", list_res);
		return "thymeleaf/d/claim";
	}
	
	@PostMapping("/d51/claim")
	public String event (HttpSession session, @Valid @ModelAttribute("erp_ClaimVO") Erp_ClaimVO erp_ClaimVO, BindingResult result, RedirectAttributes redirectAttributes) {
		// 에러있다면, 적힌 내용들 담고 해당 페이지 redirect 시킴
		if(result.hasErrors()) {
			if (!result.getFieldErrors().get(0).getField().equals("claim_no")) {
				redirectAttributes.addFlashAttribute("erp_CsVO", erp_ClaimVO);
			    redirectAttributes.addFlashAttribute("error", result.getFieldErrors().get(0).getField());	
			}
			// 에러가 없다며 일반적 저장기능 실행
			else {
//				int comcode_no = Integer.parseInt((String) session.getAttribute("comcode_no"));
//				erp_WarehouseVO.setComcode_no(comcode_no);
				erp_ClaimVO.setComcode_no(1); //temporary TODO 삭제할것
				d5Service.save_claim(erp_ClaimVO);
			}
		} 
		return "redirect:/d/d5/d51/claim";
	}
	
	@PostMapping("/d51/claim_update")
	public String claim_update(HttpSession session, Erp_ClaimVO erp_ClaimVO) {
		int comcode_no = Integer.parseInt((String) session.getAttribute("comcode_no"));
		erp_ClaimVO.setComcode_no(comcode_no); 
		int res = d5Service.update_claim(erp_ClaimVO);
		return "redirect:/d/d5/d51/claim";
	}
	
	@PostMapping("/d51/claim_delete")
	public String claim_delete (Erp_ClaimVO erp_ClaimVO) {
		int res = d5Service.delete_claim(erp_ClaimVO.getClaim_no());
		return "redirect:/d/d5/d51/claim";
	}
	
	
	// ---------CS(소비자)---------
	@GetMapping("/d52/cs")
	public String cs (Model model) {
		List<Erp_CsVO> list_res = d5Service.list_cs();
		model.addAttribute("cs_list", list_res);
		return "thymeleaf/d/cs";
	}
	
	@PostMapping("/d52/cs")
	public String cs (HttpSession session, @Valid @ModelAttribute("erp_CsVO") Erp_CsVO erp_CsVO, BindingResult result, RedirectAttributes redirectAttributes) {
		// 에러있다면, 적힌 내용들 담고 해당 페이지 redirect 시킴
		if(result.hasErrors()) {
			if (!result.getFieldErrors().get(0).getField().equals("cs_no")) {
				redirectAttributes.addFlashAttribute("erp_CsVO", erp_CsVO);
			    redirectAttributes.addFlashAttribute("error", result.getFieldErrors().get(0).getField());	
			}
			// 에러가 없다며 일반적 저장기능 실행
			else {
//				int comcode_no = Integer.parseInt((String) session.getAttribute("comcode_no"));
//				erp_WarehouseVO.setComcode_no(comcode_no);
				erp_CsVO.setComcode_no(1); //temporary TODO 삭제할것
				d5Service.save_cs(erp_CsVO);
			}
		} 
		return "redirect:/d/d5/d52/cs";
	}
	
	@PostMapping("/d52/cs_update")
	public String cs_update(HttpSession session, Erp_CsVO erp_CsVO) {
		int comcode_no = Integer.parseInt((String) session.getAttribute("comcode_no"));
		erp_CsVO.setComcode_no(comcode_no); 
		int res = d5Service.update_cs(erp_CsVO);
		return "redirect:/d/d5/d52/cs";
	}
	
	@PostMapping("/d52/cs_delete")
	public String cs_delete (Erp_CsVO erp_CsVO) {
		int res = d5Service.delete_cs(erp_CsVO.getCs_no());
		return "redirect:/d/d5/d52/cs";
	}
	
	// ---------거래처조회---------
	@GetMapping("/d5/client_list")
	public String client_list(Model model) {
		List<Erp_ClientVO> client_list = d5Service.findClientAll();
		model.addAttribute("client_list", client_list);
		return "thymeleaf/d/client_list";
	}	
	
	// ---------클레임/CS 항목 조회---------
	@GetMapping("/d5/cvalue_list")
	public String cvalue_list(Model model) {
		List<Erp_CvalueVO> cvalue_list= d5Service.findCvalueAll();
		model.addAttribute("cvalue_list", cvalue_list);
		return "thymeleaf/d/cvalue_list";
	}
	
}
