package com.lab.erp.vo.b.b1;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_Bs3VO {
	
	private int bs3_no;
	private int bs2_no;
	
	private String bs3_ctgr;
	private int bs3_amount;
	private String bs3_class;
	
	private int comcode_no;
	
	//	
	private String bs2_ctgr;
	private int bs2_amount;
	private String bs2_class;
		
	//
	private int bs1_no;
	private String bs1_ctgr;
	private int bs1_amount;
	private String bs1_class;
	
//	====================================
	
	private int debtor_no;
	private int creditor_no;

}
