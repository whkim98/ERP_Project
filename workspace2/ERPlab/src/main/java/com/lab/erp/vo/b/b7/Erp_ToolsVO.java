package com.lab.erp.vo.b.b7;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_ToolsVO {
	
	private int tools_no;
	private int ctgr_no;
	private int team_no;
	private String tools_code;
	private String tools_name;
	private int toolstype_no;
	private String tools_usage;
	private String tools_date;
	private int tools_qty;
	private int tools_price;
	private int tools_tax;
	private int tools_total;
	private String tools_expiry;
	private int comcode_no;

	//toolstype
	private String toolstype_name;
	
}
