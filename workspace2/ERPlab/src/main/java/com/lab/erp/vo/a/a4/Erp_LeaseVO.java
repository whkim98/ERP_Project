package com.lab.erp.vo.a.a4;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_LeaseVO {

	private int lease_no;
	private int ctgr_no;
	private String lease_code; 
	private int client_no;
	private int team_no;
	private int account_no;
	private int leasekind_no;
	private String lease_content; 
	private String lease_note; 
	private int lease_price;
	private int debtor_no;
	private int creditor_no;
	private String lease_start; 
	private String lease_end; 
	private int comcode_no;

}
