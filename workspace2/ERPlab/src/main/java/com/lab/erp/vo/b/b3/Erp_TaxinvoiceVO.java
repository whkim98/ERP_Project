package com.lab.erp.vo.b.b3;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_TaxinvoiceVO {
	
	private int taxinvoice_no;
	private String taxinvoice_code;
	private int tikind_no;
	private int company_no;
	private int client_no;
	private String taxinvoice_date;
	private int goods_no;
	private int taxinvoice_qty;
	private int taxinvoice_amount;
	private int taxinvoice_tax;
	private int taxinvoice_total;
	private int settletype_no;
	private int comcode_no;

}
