package com.lab.erp.vo.d.d6;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_GoodslotVO {
	private int goodslot_no;
	private String goodslot_lot;
	private int goodslot_qty;
	private String goodslot_production;
	private String goodslot_expiry;
	private int goodslot_price;
	private int goodslot_tax;
	private int goodslot_total;
	private int goods_no;
}
