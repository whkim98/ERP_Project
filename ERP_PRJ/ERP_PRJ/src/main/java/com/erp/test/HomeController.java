package com.erp.test;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	@RequestMapping(value="test/sidebar", method = RequestMethod.GET)
	public String sidebar() {
		return "sidebar";
	}
	
	@RequestMapping(value="test/ruddud", method = RequestMethod.GET)
	public String ruddud() {
		return "ruddud";
	}
	
	@RequestMapping(value="test/wjsfir", method = RequestMethod.GET)
	public String wjsfir() {
		return "wjsfir";
	}
	
	@RequestMapping(value="test/ghlrP", method = RequestMethod.GET)
	public String ghlrP() {
		return "ghlrP";
	}
	
	@RequestMapping(value="test/woan", method = RequestMethod.GET)
	public String woan() {
		return "woan";
	}
	
	@RequestMapping(value="test/dlstk", method = RequestMethod.GET)
	public String dlstk() {
		return "dlstk";
	}
	
	@RequestMapping(value="test/chdan", method = RequestMethod.GET)
	public String chdan() {
		return "chdan";
	}
	
	@RequestMapping(value="test/godhl", method = RequestMethod.GET)
	public String godhl() {
		return "godhl";
	}
	
	@RequestMapping(value="test/rnrso", method = RequestMethod.GET)
	public String rnrso() {
		return "rnrso";
	}
	
	@RequestMapping(value="test/aowkd", method = RequestMethod.GET)
	public String aowkd() {
		return "aowkd";
	}
	
	@RequestMapping(value="test/duddjq", method = RequestMethod.GET)
	public String duddjq() {
		return "duddjq";
	}
	
	@RequestMapping(value="test/todtks", method = RequestMethod.GET)
	public String todtks() {
		return "todtks";
	}
	
	@RequestMapping(value="test/rnao", method = RequestMethod.GET)
	public String rnao() {
		return "rnao";
	}
	
	@RequestMapping(value="test/vnawlf", method = RequestMethod.GET)
	public String vnawlf() {
		return "vnawlf";
	}
	
	@RequestMapping(value="test/anffb", method = RequestMethod.GET)
	public String anffb() {
		return "anffb";
	}
	
}
