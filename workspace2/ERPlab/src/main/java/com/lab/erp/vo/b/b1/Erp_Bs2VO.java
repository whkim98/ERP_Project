package com.lab.erp.vo.b.b1;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_Bs2VO {
	
	private int bs2_no;
	private int bs1_no;
	
	private String bs2_ctgr;
	private int bs2_amount;
	private String bs2_class;
	
	private String bs1_ctgr;
}
