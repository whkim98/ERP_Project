package com.lab.erp.vo.c.c1;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_ImportorderVO {

	private int importorder_no;
	private int ctgr_no;
	private String importorder_code;
	private int team_no;
	private int importorder_stored;
	private String importorder_date;
	private int comcode_no;
	private int client_no;
	private int goods_no;
	private int importorder_price;
	private int importorder_tax;
	private int importorder_total;
	private int incoterms_no;
	private int settletype_no;
	
	//팀
	private String team_name;
	
	//incoterms
	private String incoterms_name;
	
	//settletype
	private String settletype_condition;
	private String settletype_type;
	
	//client
	private String client_name;
	


}
