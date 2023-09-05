package com.lab.erp.service.d;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.lab.erp.repository.d4.D4Repository;
import com.lab.erp.vo.d.d4.Erp_EqgradeVO;
import com.lab.erp.vo.d.d4.Erp_EqkindVO;
import com.lab.erp.vo.d.d4.Erp_EquipmentVO;
import com.lab.erp.vo.d.d4.Erp_QcVO;
import com.lab.erp.vo.d.d6.Erp_GoodsVO;

@Service
public class D4Service {
	private D4Repository d4Repository;
	
	public D4Service(SqlSession sqlSession) {
		System.out.println("### LOG : " + getClass().getName()+"() 생성");
		d4Repository = sqlSession.getMapper(D4Repository.class);
	}
	
	
	// ---------품질검사---------
	public List<Erp_QcVO> list_qc() {return d4Repository.findAll_qc();}
	
	public int save_qc(Erp_QcVO erp_QcVO) {return d4Repository.save_qc(erp_QcVO);}
	
	public int update_qc(Erp_QcVO erp_QcVO) {return d4Repository.update_qc(erp_QcVO);}
	
	public int delete_qc(int qc_no) {return d4Repository.delete_qc(qc_no);}
	
	
	// ---------설비/장비관리---------
	public List<Erp_EquipmentVO> list_equipment() {return d4Repository.findAll_equipment();}
	
	public int save_equipment(Erp_EquipmentVO erp_EquipmentVO) {return d4Repository.save_equipment(erp_EquipmentVO);}
	
	public int update_equipment(Erp_EquipmentVO erp_EquipmentVO) {return d4Repository.update_equipment(erp_EquipmentVO);}
	
	public int delete_equipment(int equipment_no) {return d4Repository.delete_equipment(equipment_no);}

	
	// ---------상품조회--------- 	
	public List<Erp_GoodsVO> findGoodsAll() {return d4Repository.findGoodsAll();}
	
	// ---------설비/장비 종류 조회---------
	public List<Erp_EqkindVO> findEqKindAll() {return d4Repository.findEqKindAll();}
	
	// ---------설비/장비 관리 등급 조회---------
	public List<Erp_EqgradeVO> findEqGradeAll() {return d4Repository.findEqGradeAll();}
}
