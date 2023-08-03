package com.lab.erp.vo.c.c1;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_ImportVO {
	
	private int import_no;
	private int ctgr_no;
	private String import_cino;
	private String import_blno;
	private int team_no;
	private int client_no;
	private String import_date;
	private int goods_no;
	private int import_qty;
	private int import_price;
	private int import_tax;
	private int import_total;
	private int incoterms_no;
	private int settletype_no;
	private int comcode_no;

}
