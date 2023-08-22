package com.lab.erp.vo.a.a4;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_InvestmentVO {
	
	private int investment_no;
	private int ctgr_no;
	private String investment_code;
	private int client_no;
	private String investment_content;
	private String investment_note;
	private int investment_price;
	private int team_no;
	private String investment_start;
	private String investment_end;
	private String investment_withdrawal;
	private int account_no;
	private int imkind_no;
	private int investment_status;
	private int comcode_no;
	private int debtor_no;
	private int creditor_no;

}
