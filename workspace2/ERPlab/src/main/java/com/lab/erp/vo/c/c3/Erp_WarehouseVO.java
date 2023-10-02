package com.lab.erp.vo.c.c3;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_WarehouseVO {

	private int warehouse_no;
	private int company_no;
	private String warehouse_date;
	private int goodslot_no;
	private int warehouse_qty;
	private String warehouse_release;
	private int comcode_no;

}
