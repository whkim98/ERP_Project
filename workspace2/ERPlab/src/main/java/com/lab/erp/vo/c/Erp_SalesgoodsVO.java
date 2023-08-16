package com.lab.erp.vo.c;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_SalesgoodsVO {
	private int salesgoods_no;
	private String salesgoods_code;
	private int goods_no;
	private int salesgoods_qty;
	private int salesgoods_price;
	private int salesgoods_tax;
	private int salesgoods_total;
}
