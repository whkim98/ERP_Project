package com.lab.erp.vo.c.c2;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_LocalsalesVO {
	
	private int localsales_no;
	private int ctgr_no;
	private String localsales_cino;
	private int team_no;
	private int client_no;
	private String localsales_date;
	private int goods_no;
	private int localsales_qty;
	private int localsales_price;
	private int localsales_tax;
	private int localsales_total;
	private int settletype_no;
	private int comcode_no;

}
