package com.lab.erp.vo.c.c1;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_ImportorderVO {

	private int importorder_no;
	private int ctgr_no;
	private String importorder_code;
	private int import_no;
	private int team_no;
	private int importorder_stored;
	private String importorder_date;
	private int comcode_no;

}
