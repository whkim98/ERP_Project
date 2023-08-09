package com.lab.erp.vo.b.b1;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_ClosingVO {
	
	private int closing_no;
	private int ctgr_no;
	private String closing_code;
	private String closing_date;
	private int debtor_no;
	private int closing_debtor;
	private int creditor_no;
	private int closing_creditor;
	private int comcode_no;

}
