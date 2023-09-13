package com.lab.erp.vo.c.c1;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_ImportVO {
	
	private int import_no;
	private int ctgr_no;
	private String import_cino;
	private String import_blno;
	private String import_date;
	private int importorder_no;
	private int comcode_no;

}
