package com.lab.erp.repository.d4;

import java.util.List;

import com.lab.erp.vo.d.d4.Erp_EqgradeVO;
import com.lab.erp.vo.d.d4.Erp_EqkindVO;
import com.lab.erp.vo.d.d4.Erp_EquipmentVO;
import com.lab.erp.vo.d.d4.Erp_QcVO;
import com.lab.erp.vo.d.d6.Erp_GoodsVO;

public interface D4Repository {
	
	// ---------품질검사---------
	List<Erp_QcVO> findAll_qc();
	
	int save_qc(Erp_QcVO erp_QcVO);
	
	int update_qc(Erp_QcVO erp_QcVO);
	
	int delete_qc(int qc_no);
	
	
	// ---------설비/장비관리---------
	List<Erp_EquipmentVO> findAll_equipment();
	
	int save_equipment(Erp_EquipmentVO erp_EquipmentVO);
	
	int update_equipment(Erp_EquipmentVO erp_EquipmentVO);
	
	int delete_equipment(int equipment_no);
	
	
	// ---------상품조회--------- 	
	List<Erp_GoodsVO> findGoodsAll();
	
	// ---------설비/장비 종류 조회---------
	List<Erp_EqkindVO> findEqKindAll();
	
	// ---------설비/장비 관리 등급 조회---------
	List<Erp_EqgradeVO> findEqGradeAll();
	
}
