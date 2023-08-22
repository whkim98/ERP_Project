package com.lab.erp.service.b;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lab.erp.dao.b.b1.Erp_ClosingDAO;
import com.lab.erp.vo.b.b1.Erp_ClosingVO;

@Service
public class B4Service {
	private Erp_ClosingDAO cdao;
	
	@Autowired
	public B4Service(Erp_ClosingDAO cdao) {
		this.cdao = cdao;
	}
	
	public List<Map<String, Object>> deadlineList(Map<String, Object> map){
		return cdao.deadlineList(map);
	}
	
	public Erp_ClosingVO totalAmount(Map<String, Object> map) {
		return cdao.totalAmount(map);
	}
	
	public List<Map<String, Object>> selectCtgr(Map<String, Object> map) {
		return cdao.selectCtgr(map);
	}
	
	public Erp_ClosingVO ctgrAmount(Map<String, Object> map) {
		return cdao.ctgrAmount(map);
	}
}
