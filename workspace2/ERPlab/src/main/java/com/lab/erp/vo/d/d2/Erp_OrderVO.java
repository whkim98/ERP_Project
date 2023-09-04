package com.lab.erp.vo.d.d2;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_OrderVO {

	private int order_no;
	private int ctgr_no;
	private String order_code;
	private String order_odate;
	private int client_no;
	private String order_status;
	private int team_no;
	private String order_schedule;
	private int order_approval;
	private String order_end;
	private int order_price;
	private int order_tax;
	private int order_total;
	private int order_type;
	private int company_no;
	private int comcode_no;

}
