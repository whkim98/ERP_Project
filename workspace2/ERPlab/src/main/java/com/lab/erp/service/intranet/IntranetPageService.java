package com.lab.erp.service.intranet;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.lab.erp.repository.intranet.IntranetRepository;
import com.lab.erp.vo.intranet.Erp_CalendarVO;
import com.lab.erp.vo.intranet.Erp_EmailVO;
import com.lab.erp.vo.login.Erp_DeptVO;
import com.lab.erp.vo.login.Erp_Employee1VO;
import com.lab.erp.vo.login.Erp_Employee2VO;
import com.lab.erp.vo.login.Erp_TeamVO;

@Service
public class IntranetPageService {
	@Autowired
	private JavaMailSender mailSender;
	private IntranetRepository intranetRepository;
	
	public IntranetPageService(SqlSession sqlSession) {
		System.out.println("### LOG : " + getClass().getName()+"() 생성");
		intranetRepository = sqlSession.getMapper(IntranetRepository.class);
	}
	
	public List<Erp_TeamVO> list_team() {return intranetRepository.findAll_team();}
	
	public List<Erp_DeptVO> list_dept() {return intranetRepository.findAll_dept();}
	
	public List<Erp_Employee1VO> list_employee1() {return intranetRepository.findAll_employee1();}
	
	public List<Erp_Employee2VO> list_employee2() {return intranetRepository.findAll_employee2();}
	
	public Erp_CalendarVO find_calendar() {return intranetRepository.find_calendar();}
		
	public int update_calendar(Erp_CalendarVO erp_CalendarVO) {return intranetRepository.update_calendar(erp_CalendarVO);}

	public int emailSend(Erp_EmailVO erp_EmailVO, String sender_email) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(erp_EmailVO.getAddress());
		message.setFrom(sender_email);
		message.setSubject(erp_EmailVO.getTitle());
		message.setText(erp_EmailVO.getMessage());
		try {
			mailSender.send(message);
			return 1;
		} catch(Exception e) {
			System.out.println(e.toString());
			return 0;
		}
	}
}
