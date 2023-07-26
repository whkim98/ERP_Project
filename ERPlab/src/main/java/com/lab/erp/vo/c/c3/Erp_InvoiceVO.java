package com.lab.erp.vo.c.c3;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_InvoiceVO {

	private int invoice_no;
	private String invoice_code;
	private int onlinereceiver_no;
	private String invoice_company;
	private String invoice_compaddr;
	private String invoice_date;

}
