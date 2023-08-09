package com.lab.erp.vo.a.a4;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_LoanVO {

	private int loan_no;
	private int ctgr_no;
	private String loan_code;
	private int client_no;
	private int team_no;
	private int loan_amount;
	private String loan_content;
	private String loan_note;
	private String loan_start;
	private String loan_end;
	private int account_no;
	private int debtor_no;
	private int creditor_no;
	private int comcode_no;

}
