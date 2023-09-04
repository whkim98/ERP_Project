package com.lab.erp.vo.d.d2;

import java.util.List;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_InvenconnectVO {
	private int invenconnect_no;
	private int inventory_no;
	private int goodslot_no;
	private int invenconnect_qty;
	private int invenconnect_usage;
	private int invenconnect_availableqty;
	private String invenconnect_date;
	
	private List<Erp_InvenconnectVO> iclist;
	private List<Erp_InvenconnectVO> iclist1;
}
