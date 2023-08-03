package com.lab.erp.vo.c.c1;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_ImportpayVO {

	private int importpay_no;
	private int ctgr_no;
	private String importpay_code;
	private int client_no;
	private int import_no;
	private String importpay_expiry;
	private int importpay_payable;
	private String importpay_paid;
	private int comcode_no;

}
