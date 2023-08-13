package com.lab.erp.controller.a;

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

import com.lab.erp.service.a.A1Service;
import com.lab.erp.util.CompanyValidator;
import com.lab.erp.vo.a.a1.Erp_BusinesstypeVO;
import com.lab.erp.vo.a.a1.Erp_CompanyVO;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
@RequestMapping("/a")
public class A1Controller {
	
	private A1Service a1Service;
	
	@Autowired
	public void setA1Service(A1Service a1Service) {
		this.a1Service = a1Service;
	}
	
	public A1Controller() {
		System.out.println("### LOG: "+ getClass().getName() + "() 생성");
	}
	
	@GetMapping("/a_company")
	public String a_company(Model model ) {
		List<Erp_CompanyVO> comp_list = a1Service.list();
		List<Erp_BusinesstypeVO> bst_list = a1Service.bstlist();
		model.addAttribute("comp_list", comp_list);
		model.addAttribute("bst_list", bst_list);
		return "thymeleaf/a/a_company";
	}
	
	@PostMapping("/a_company")
	public String a_company(HttpSession httpSession, @Valid @ModelAttribute("erp_CompanyVO") Erp_CompanyVO erp_CompanyVO, BindingResult result, RedirectAttributes redirectAttributes) {
		// 에러있다면, 적힌 내용들 담고 해당 페이지 redirect 시킴
		if(result.hasErrors()) {
			redirectAttributes.addFlashAttribute("erp_CompanyVO", erp_CompanyVO);
		    redirectAttributes.addFlashAttribute("error", result.getFieldErrors().get(0).getField());
		} 
		// 에러가 없다며 일반적 저장기능 실행
		else {
			//TODO : 1 말고 httpSession 값에 있는 comcode_no으로 변경할것
			erp_CompanyVO.setComcode_no(1); // temporary
			a1Service.save(erp_CompanyVO);
		}
		return "redirect:/a/a_company";
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {binder.setValidator(new CompanyValidator());}
}