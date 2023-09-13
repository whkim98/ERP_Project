package com.lab.erp.vo.c.c3;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_OnlineVO {
	
	private int online_no;
	private int ctgr_no;
	private String online_code;
	private int team_no;
	private String online_date;
	private int customer_no;
	private int settletype_no;
	private int comcode_no;
}
