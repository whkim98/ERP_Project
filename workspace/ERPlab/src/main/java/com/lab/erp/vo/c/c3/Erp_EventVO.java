package com.lab.erp.vo.c.c3;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_EventVO {

	private int event_no;
	private String event_code;
	private String event_name;
	private String event_start;
	private String event_end;
	private int event_period;
	private int goods_no;
	private int event_price;
	private int event_qty;
	private int event_tax;
	private int event_total;
	private String event_manager;
	private String event_remark;
	private int comcode_no;

}
