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

import com.lab.erp.service.d.D4Service;
import com.lab.erp.vo.d.d4.Erp_EquipmentVO;
import com.lab.erp.vo.d.d4.Erp_QcVO;
import com.lab.erp.vo.d.d6.Erp_GoodsVO;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;


@Controller
@RequestMapping("/d/d4")
public class D4Controller {
	private D4Service d4Service;
	
	@Autowired
	public void setD4Service(D4Service d4Service) {
		this.d4Service = d4Service;
	}
	
	// ---------품질검사---------
	@GetMapping("/d41/qc")
	public String qc (Model model) {
		List<Erp_QcVO> list_res = d4Service.list_qc();
		model.addAttribute("qc_list", list_res);
		return "thymeleaf/d/qc";
	}
	
	@PostMapping("/d41/qc")
	public String qc (HttpSession session, @Valid @ModelAttribute("erp_QcVO") Erp_QcVO erp_QcVO, BindingResult result, RedirectAttributes redirectAttributes) {
		// 에러있다면, 적힌 내용들 담고 해당 페이지 redirect 시킴
		if(result.hasErrors()) {
			if (!result.getFieldErrors().get(0).getField().equals("qc_no")) {
				redirectAttributes.addFlashAttribute("erp_QcVO", erp_QcVO);
			    redirectAttributes.addFlashAttribute("error", result.getFieldErrors().get(0).getField());	
			}
			// 에러가 없다며 일반적 저장기능 실행
			else {
				int comcode_no = Integer.parseInt((String) session.getAttribute("comcode_no"));
				erp_QcVO.setComcode_no(comcode_no);
				d4Service.save_qc(erp_QcVO);
			}
		} 
		return "redirect:/d/d41/qc";
	}
	
	@PostMapping("/d41/qc_update")
	public String qc_update (HttpSession session, Erp_QcVO erp_QcVO) {
		int comcode_no = Integer.parseInt((String) session.getAttribute("comcode_no"));
		erp_QcVO.setComcode_no(comcode_no);
		int res = d4Service.update_qc(erp_QcVO);
		return "redirect:/d/d41/qc";
	}
	
	@PostMapping("/d41/qc_delete")
	public String qc_delete (Erp_QcVO erp_QcVO) {
		int res = d4Service.delete_qc(erp_QcVO.getQc_no());
		return "redirect:/d/d41/qc";
	}
	
	// ---------설비/장비관리---------
	@GetMapping("/d42/equipment")
	public String equipment (Model model) {
		List<Erp_EquipmentVO> list_res = d4Service.list_equipment();
		model.addAttribute("equipment_list", list_res);
		return "thymeleaf/d/equipment";
	}
	
	@PostMapping("/d42/equipment")
	public String equipment (HttpSession session, @Valid @ModelAttribute("erp_EquipmentVO") Erp_EquipmentVO erp_EquipmentVO, BindingResult result, RedirectAttributes redirectAttributes) {
		// 에러있다면, 적힌 내용들 담고 해당 페이지 redirect 시킴
		if(result.hasErrors()) {
			if (!result.getFieldErrors().get(0).getField().equals("equipment_no")) {
				redirectAttributes.addFlashAttribute("erp_EquipmentVO", erp_EquipmentVO);
			    redirectAttributes.addFlashAttribute("error", result.getFieldErrors().get(0).getField());	
			}
			// 에러가 없다며 일반적 저장기능 실행
			else {
				int comcode_no = Integer.parseInt((String) session.getAttribute("comcode_no"));
				erp_EquipmentVO.setComcode_no(comcode_no);
				d4Service.save_equipment(erp_EquipmentVO);
			}
		} 
		
		
		
		return "redirect:/d/d42/equipment";
	}
	
	@PostMapping("/d42/equipment_update")
	public String equipment_update (HttpSession session, Erp_EquipmentVO erp_EquipmentVO) {
		int comcode_no = Integer.parseInt((String) session.getAttribute("comcode_no"));
		erp_EquipmentVO.setComcode_no(comcode_no);
		int res = d4Service.update_equipment(erp_EquipmentVO);
		return "redirect:/d/d42/equipment";
	}
	
	@PostMapping("/d42/equipment_delete")
	public String equipment_delete (Erp_EquipmentVO erp_EquipmentVO) {
		int res = d4Service.delete_equipment(erp_EquipmentVO.getEquipment_no());
		return "redirect:/d/d42/equipment";
	}
	
	
	// ---------상품조회---------
	@GetMapping("/d4/goods_list")
	public String goods_list (Model model) {
		List<Erp_GoodsVO> goods_list = d4Service.findGoodsAll();
		model.addAttribute("goods_list", goods_list);
		return "thymeleaf/d/goods_list";
	}
	
	// ---------설비/장비종류조회---------
	@GetMapping("/d4/eqkind_list")
	public String eqkind_list (Model model) {
		List<Erp_GoodsVO> eqkind_list = d4Service.findGoodsAll();
		model.addAttribute("eqkind_list", eqkind_list);
		return "thymeleaf/d/eqkind_list";
	}
	
	// ---------설비/장비등급조회---------
	@GetMapping("/d4/eqgrade_list")
	public String eqgrade_list (Model model) {
		List<Erp_GoodsVO> eqgrade_list = d4Service.findGoodsAll();
		model.addAttribute("eqgrade_list", eqgrade_list);
		return "thymeleaf/d/eqkind_list";
	}
}
