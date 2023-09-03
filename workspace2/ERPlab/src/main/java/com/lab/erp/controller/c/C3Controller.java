package com.lab.erp.controller.c;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lab.erp.service.c.C3Service;
import com.lab.erp.vo.c.c3.Erp_EventVO;
import com.lab.erp.vo.c.c3.Erp_OnlineVO;
import com.lab.erp.util.EventValidator;
import com.lab.erp.vo.a.a1.Erp_CompanyVO;
import com.lab.erp.vo.c.c3.Erp_WarehouseVO;
import com.lab.erp.vo.d.d6.Erp_GoodsVO;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
@RequestMapping("/c/c3")
public class C3Controller {
	private C3Service c3Service;
	
	@Autowired
	public void setC3Service(C3Service c3Service) {
		this.c3Service = c3Service;
	}
	// ---------매장매출---------

	
	// ---------창고관리(재고관리)---------
	@GetMapping("/c32/warehouse")
	public String warehouse (Model model) {
		List<Erp_WarehouseVO> list_res = c3Service.list_warehouse();
		model.addAttribute("warehouse_list", list_res);
		return "thymeleaf/c/warehouse";
	}
	
	@PostMapping("/c32/warehouse")
	public String event (HttpSession session, @Valid @ModelAttribute("erp_WarehouseVO") Erp_WarehouseVO erp_WarehouseVO, BindingResult result, RedirectAttributes redirectAttributes) {
		// 에러있다면, 적힌 내용들 담고 해당 페이지 redirect 시킴
		if(result.hasErrors()) {
			if (!result.getFieldErrors().get(0).getField().equals("warehouse_no")) {
				redirectAttributes.addFlashAttribute("erp_WarehouseVO", erp_WarehouseVO);
			    redirectAttributes.addFlashAttribute("error", result.getFieldErrors().get(0).getField());	
			}
			// 에러가 없다며 일반적 저장기능 실행
			else {
//				int comcode_no = Integer.parseInt((String) session.getAttribute("comcode_no"));
//				erp_WarehouseVO.setComcode_no(comcode_no);
				erp_WarehouseVO.setComcode_no(1); //temporary TODO 삭제할것
				c3Service.save_warehouse(erp_WarehouseVO);
			}
		} 
		return "redirect:/c/c32/warehouse";
	}
	
	
	@PostMapping("/c32/warehouse_update")
	public String warehouse_update (HttpSession session, Erp_WarehouseVO erp_WarehouseVO) {
		int comcode_no = Integer.parseInt((String) session.getAttribute("comcode_no"));
		erp_WarehouseVO.setComcode_no(comcode_no); 
		int res = c3Service.update_warehouse(erp_WarehouseVO);
		return "redirect:/c/c32/warehouse";
	}
	
	@PostMapping("/c32/warehouse_delete")
	public String event_delete (Erp_WarehouseVO erp_WarehouseVO) {
		int res = c3Service.delete_warehouse(erp_WarehouseVO.getWarehouse_no());
		return "redirect:/c/c32/warehouse";
	}
	
	// ---------행사---------
	@GetMapping("/c33/event")
	public String event (Model model) {
		List<Erp_EventVO> list_res = c3Service.list_event();
		model.addAttribute("event_list", list_res);
		return "thymeleaf/c/event";
	}
	
	@PostMapping("/c33/event")
	public String event (HttpSession session, @Valid @ModelAttribute("erp_EventVO") Erp_EventVO erp_EventVO, BindingResult result, RedirectAttributes redirectAttributes) {
		// 에러있다면, 적힌 내용들 담고 해당 페이지 redirect 시킴
		if(result.hasErrors()) {
			if (!result.getFieldErrors().get(0).getField().equals("event_no")) {
				redirectAttributes.addFlashAttribute("erp_EventVO", erp_EventVO);
			    redirectAttributes.addFlashAttribute("error", result.getFieldErrors().get(0).getField());	
			}
			// 에러가 없다며 일반적 저장기능 실행
			else {
				int comcode_no = Integer.parseInt((String) session.getAttribute("comcode_no"));
				erp_EventVO.setComcode_no(comcode_no);
				c3Service.save_event(erp_EventVO);
			}
		} 
		return "redirect:/c/c33/event";
	}
	
	
	@PostMapping("/c33/event_update")
	public String event_update (HttpSession session, Erp_EventVO erp_EventVO) {
		int comcode_no = Integer.parseInt((String) session.getAttribute("comcode_no"));
		erp_EventVO.setComcode_no(comcode_no); 
		int res = c3Service.update_event(erp_EventVO);
		return "redirect:/c/c33/event";
	}
	
	@PostMapping("/c33/event_delete")
	public String event_delete (Erp_EventVO erp_EventVO) {
		int res = c3Service.delete_event(erp_EventVO.getEvent_no());
		return "redirect:/c/c33/event";
	}

	
	// ---------온라인매출---------
	@GetMapping("/c34/online")
	public String online (Model model) {
		List<Erp_OnlineVO> list_res = c3Service.list_online();
		model.addAttribute("online_list", list_res);
		return "thymeleaf/c/online";
	}
	
	@PostMapping("/c34/online")
	public String online (HttpSession session, @Valid @ModelAttribute("erp_OnlineVO") Erp_OnlineVO erp_OnlineVO, BindingResult result, RedirectAttributes redirectAttributes) {
		// 에러있다면, 적힌 내용들 담고 해당 페이지 redirect 시킴
		if(result.hasErrors()) {
			if (!result.getFieldErrors().get(0).getField().equals("online_no")) {
				redirectAttributes.addFlashAttribute("erp_OnlineVO", erp_OnlineVO);
			    redirectAttributes.addFlashAttribute("error", result.getFieldErrors().get(0).getField());	
			}
			// 에러가 없다며 일반적 저장기능 실행
			else {
				int comcode_no = Integer.parseInt((String) session.getAttribute("comcode_no"));
				erp_OnlineVO.setComcode_no(comcode_no);
				c3Service.save_online(erp_OnlineVO);
			}
		} 
		return "redirect:/c/c34/online";
	}
	
	
	@PostMapping("/c34/online_update")
	public String online_update (HttpSession session, Erp_OnlineVO erp_OnlineVO) {
		int comcode_no = Integer.parseInt((String) session.getAttribute("comcode_no"));
		erp_OnlineVO.setComcode_no(comcode_no); 
		int res = c3Service.update_online(erp_OnlineVO);
		return "redirect:/c/c34/online";
	}
	
	@PostMapping("/c34/online_delete")
	public String online_delete (Erp_OnlineVO erp_OnlineVO) {
		int res = c3Service.delete_online(erp_OnlineVO.getOnline_no());
		return "redirect:/c/c34/online";
	}
	
	
	// ---------상품조회---------
	@GetMapping("/c3/goods_list")
	public String goods_list (Model model) {
		List<Erp_GoodsVO> goods_list = c3Service.findGoodsAll();
		model.addAttribute("goods_list", goods_list);
		return "thymeleaf/c/goods_list";
	}
	
	// ---------회사조회---------
	@GetMapping("/c3/company_list")
	public String company_list (Model model) {
		List<Erp_CompanyVO> company_list= c3Service.findCompanyAll();
		model.addAttribute("company_list", company_list);
		return "thymeleaf/c/company_list";
	}

	@InitBinder
	public void initBinder(WebDataBinder binder) {binder.setValidator(new EventValidator());}

	
}
