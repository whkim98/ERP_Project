package com.lab.erp.vo.d.d6;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_GoodsVO {

	private int goods_no;
	private String goods_code;
	private String goods_barcode;
	private String goods_name;
	private int goodskind_no;
	private int goods_customerprice;
	private String goods_description;
	private int goodsst_no;
	private int client_no1;
	private int client_no2;
	private int goods_stockqty;
	private int goodslev_no;
	private String goods_location;
	private int comcode_no;
	
	
	
}
