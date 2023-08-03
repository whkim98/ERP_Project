package com.lab.erp.vo.b.b7;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_SuppliesVO {

	private int supplies_no;
	private int ctgr_no;
	private String supplies_code;
	private int team_no;
	private String supplies_name;
	private int suppliestype_no;
	private String supplies_usage;
	private String supplies_date;
	private int supplies_qty;
	private int supplies_price;
	private int supplies_tax;
	private int supplies_total;
	private int comcode_no;

}
