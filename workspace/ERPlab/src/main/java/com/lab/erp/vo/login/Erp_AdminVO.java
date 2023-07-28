package com.lab.erp.vo.login;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_AdminVO {
	
	private int admin_no;
	private int team_no;
	private String admin_id;
	private String admin_pw;
	private int comcode_no;
	
}
