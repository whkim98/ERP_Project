package com.lab.erp.vo.c;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_ReceivableVO {
	
	private int receivable_no;
	private int ctgr_no;
	private String receivable_code;
	private String receivable_cino;
	private int receivable_price;
	private int receivable_tax;
	private int receivable_total;
	private String receivable_expiry;
	private int receivable_collected;
	private String receivable_collect;
	private int comcode_no;
	private int client_no;

}
