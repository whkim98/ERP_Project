package com.lab.erp.service.login;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lab.erp.dao.login.Erp_AdminDAO;
import com.lab.erp.vo.login.Erp_AdminVO;
import com.lab.erp.vo.login.Erp_TeamVO;

@Service
public class AdminService {
private Erp_AdminDAO dao;
	
	@Autowired
	public AdminService(Erp_AdminDAO dao) {
		this.dao = dao;
	}
	
	public int adminMaxNo() {
		return dao.adminMaxNo();
	}
	
	public int createAdmin(Erp_AdminVO vo) {
		
		int no = adminMaxNo() + 1;
			
		vo.setAdmin_no(no);
		
		return dao.createAdmin(vo);
	}
	
	public int updateAdmin(Erp_AdminVO vo) {
		return dao.updateAdmin(vo);
	}
	
	public int deleteAdmin(int admin_no) {
		return dao.deleteAdmin(admin_no);
	}
	
	public Erp_AdminVO selectAdmin(Map<String, Object> map) {
		return dao.selectAdmin(map);
	}
	
	public List<Map<String, Object>> adminList(){
		return dao.adminList();
	}
	
	public Erp_AdminVO giveAdmin(int admin_no) {
		return dao.giveAdmin(admin_no);
	}
	
	public List<Map<String, Object>> teamAdmin(String team_name){
		return dao.teamAdmin(team_name);
	}
	
	public List<Erp_TeamVO> teamList(){
		return dao.teamList();
	}
}
