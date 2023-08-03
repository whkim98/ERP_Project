package com.lab.erp.vo.c.c1;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_ForsalesVO {

	private int forsales_no;
	private int ctgr_no;
	private String forsales_cino;
	private String forsales_blno;
	private int team_no;
	private int client_no;
	private String forsales_date;
	private int goods_no;
	private int forsales_qty;
	private int forsales_price;
	private int forsales_tax;
	private int forsales_total;
	private int incoterms_no;
	private int settletype_no;
	private int comcode_no;

}
