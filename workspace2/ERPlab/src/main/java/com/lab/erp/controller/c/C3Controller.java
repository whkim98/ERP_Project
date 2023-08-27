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
import com.lab.erp.util.CompanyValidator;
import com.lab.erp.util.EventValidator;
import com.lab.erp.vo.a.a1.Erp_BusinesstypeVO;
import com.lab.erp.vo.a.a1.Erp_CompanyVO;
import com.lab.erp.vo.c.c3.Erp_EventVO;
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
	
	@GetMapping("/event")
	public String event (Model model) {
		List<Erp_EventVO> list_res = c3Service.list();
		model.addAttribute("list", list_res);
		return "thymeleaf/c/event";
	}
	
	@PostMapping("/event")
	public String event (HttpSession session, @Valid @ModelAttribute("erp_EventVO") Erp_EventVO erp_EventVO, BindingResult result, RedirectAttributes redirectAttributes) {
		// 에러있다면, 적힌 내용들 담고 해당 페이지 redirect 시킴
				if(result.hasErrors()) {
					//TODO
					redirectAttributes.addFlashAttribute("erp_EventVO", erp_EventVO);
				    redirectAttributes.addFlashAttribute("error", result.getFieldErrors().get(0).getField());
				} 
				// 에러가 없다며 일반적 저장기능 실행
				else {
					int comcode_no = Integer.parseInt((String) session.getAttribute("comcode_no"));
					erp_EventVO.setComcode_no(comcode_no);
					c3Service.save(erp_EventVO);
				}
				return "redirect:/c/c3/event";
	}
	
	@GetMapping("/goods_list")
	public String goods_list (Model model) {
		List<Erp_GoodsVO> goods_list = c3Service.findGoodsAll();
		model.addAttribute("goods_list", goods_list);
		return "thymeleaf/c/goods_list";
	}
	
	@PostMapping("/event_update")
	public String event_update (Erp_EventVO erp_EventVO) {
		int res = c3Service.update(erp_EventVO);
		return "redirect:/c/c3/event";
	}
	
	@PostMapping("/event_delete")
	public String event_delete (Erp_EventVO erp_EventVO) {
		int res = c3Service.delete(erp_EventVO.getEvent_no());
		return "redirect:/c/c3/event";
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {binder.setValidator(new EventValidator());}
	
}
