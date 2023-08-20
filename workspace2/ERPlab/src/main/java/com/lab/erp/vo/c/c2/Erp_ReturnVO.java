package com.lab.erp.vo.c.c2;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_ReturnVO {

	private int return_no;
	private int ctgr_no;
	private String return_code;
	private int goodslot_no;
	private String return_comment;
	private String return_date;
	private int return_qty;
	private int client_no;
	private int return_tax;
	private int return_price;
	private int return_total;
	private int comcode_no;

}
