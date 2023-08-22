package com.lab.erp.vo.d.d1;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_InvenlotVO {

	private int invenlot_no;
	private int invenlot_qty;
	private int invenlot_recode;
	private int invenlot_availability;
	private String invenlot_date;
	private int goodslot_no;
	private int proinventory_no;
	
}
