package com.lab.erp.vo.d.d2;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_PurchaseVO {

	private int purchase_no;
	private String purchase_date;
	private int ctgr_no;
	private String purchase_code;
	private int client_no;
	private String purchase_content;
	private int purchase_price;
	private int purchase_tax;
	private int purchase_total;
	private int purchase_type;
	private int creditor_no;
	private int team_no;
	private int employee2_no;
	private int comcode_no;

}
