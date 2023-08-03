package com.lab.erp.vo.d.d2;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_ProducttestVO {

	private int producttest_no;
	private int purchase_no;
	private String producttest_grade;
	private int ptkind_no;
	private int producttest_lossrate;
	private int producttest_lossprice;
	private int producttest_losstax;
	private int producttest_losstotal;
	private int producttest_lossqty;
	private String producttest_date;
	private String producttest_content;
	private int producttest_lossfull;
	private int producttest_pnp;
	private int comcode_no;

}
