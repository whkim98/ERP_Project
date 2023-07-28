package com.lab.erp.vo.b.b2;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_AccountVO {
	
	private int account_no;
	private int company_no;
	private String account_bank;
	private String account_type;
	private String account_num;
	private String account_swift;
	private int currency_no;
	private int account_balance;
	private int account_exchange;
	private String account_date;
	private String team_nos;
	private int comcode_no;

}
