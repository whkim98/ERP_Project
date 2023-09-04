package com.lab.erp.vo.d.d1;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_ProductVO {

	private int product_no;
	private String product_code;
	private String product_lot;
	private String product_name;
	private String product_install;
	private String product_end;
	private int requestproduct_no;
	private String product_path;
	private int employee1_no;
	private String product_content;
	private int product_qty;
	private int product_tax;
	private int product_budget;
	private int product_totalbudget;
	private int comcode_no;

}
