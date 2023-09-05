package com.lab.erp.vo.d.d2;

import java.util.List;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_OrderconnectVO {
	private int orderconnect_no;
	private int goods_no;
	private int order_no;
	private int orderconnect_qty;
	private int orderconnect_price;
	private int orderconnect_tax;
	private int orderconnect_total;
	
	private List<Erp_OrderconnectVO> oclist;
	private List<Erp_OrderconnectVO> oclist1;
}
