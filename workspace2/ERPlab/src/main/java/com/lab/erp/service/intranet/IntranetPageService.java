package com.lab.erp.service.intranet;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.lab.erp.repository.intranet.IntranetRepository;
import com.lab.erp.vo.login.Erp_Employee1VO;
import com.lab.erp.vo.login.Erp_Employee2VO;
import com.lab.erp.vo.login.Erp_TeamVO;

@Service
public class IntranetPageService {
	
	private IntranetRepository intranetRepository;
	
	public IntranetPageService(SqlSession sqlSession) {
		System.out.println("### LOG : " + getClass().getName()+"() 생성");
		intranetRepository = sqlSession.getMapper(IntranetRepository.class);
	}
	
	public List<Erp_TeamVO> list_team() {return intranetRepository.findAll_team();}
	
	public List<Erp_Employee1VO> list_employee1() {return intranetRepository.findAll_employee1();}
	
	public List<Erp_Employee2VO> list_employee2() {return intranetRepository.findAll_employee2();}
	
	
}
