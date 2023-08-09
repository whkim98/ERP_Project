package com.lab.erp.vo.b.b2;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_MoneyVO {
	
	private int money_no;
	private String money_code;
	private String money_date;
	private int debtor_no;
	private String money_debtor;
	private int money_debtoramount;
	private int creditor_no;
	private String money_creditor;
	private int money_creditoramount;
	private int comcode_no;

}
