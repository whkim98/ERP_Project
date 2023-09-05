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
@RequestMapping("/a/a1")
public class A1Controller {
	
	private A1Service a1Service;
	
	@Autowired
	public void setA1Service(A1Service a1Service) {
		this.a1Service = a1Service;
	}
	
	public A1Controller() {
		System.out.println("### LOG: "+ getClass().getName() + "() 생성");
	}
	
	@GetMapping("/a11/company")
	public String company(Model model ) {
		List<Erp_CompanyVO> comp_list = a1Service.list_company();
		model.addAttribute("comp_list", comp_list);
		return "thymeleaf/a/company";
	}
	
	@PostMapping("/a11/company")
	public String company(HttpSession session, @Valid @ModelAttribute("erp_CompanyVO") Erp_CompanyVO erp_CompanyVO, BindingResult result, RedirectAttributes redirectAttributes) {
		if(!result.getFieldErrors().get(0).getField().equals("company_no")) {
			redirectAttributes.addFlashAttribute("erp_CompanyVO", erp_CompanyVO);
		    redirectAttributes.addFlashAttribute("error", result.getFieldErrors().get(0).getField());
		}
		// 에러가 없다며 일반적 저장기능 실행
		else {
			int comcode_no = Integer.parseInt((String) session.getAttribute("comcode_no"));
			erp_CompanyVO.setComcode_no(comcode_no); 
			a1Service.save_company(erp_CompanyVO);
		}
		return "redirect:/a/a1/a11/company";
	}
	
	@PostMapping("/a11/company_update")
	public String company_update(HttpSession session, Erp_CompanyVO erp_CompanyVO) {
		int comcode_no = Integer.parseInt((String) session.getAttribute("comcode_no"));
		erp_CompanyVO.setComcode_no(comcode_no); 
		int res = a1Service.update_company(erp_CompanyVO);
		return "redirect:/a/a1/a11/company";
	}
	
	@PostMapping("/a11/company_delete")
	public String company_delete(Erp_CompanyVO erp_CompanyVO) {
		int res = a1Service.delete_company(erp_CompanyVO.getCompany_no());
		return "redirect:/a/a1/a11/company";
	}
	
	@GetMapping("a11/businesstype_list")
	public String businesstype_list (Model model) {
		List<Erp_BusinesstypeVO> bst_list = a1Service.bstlist();
		model.addAttribute("bst_list", bst_list);
		return "thymeleaf/a/businesstype_list";
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {binder.setValidator(new CompanyValidator());}
}