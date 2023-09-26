package com.lab.erp.vo.login;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_TeamVO {
	
	private int team_no;
	private int dept_no;
	private String team_code;
	private String team_name;
	private int comcode_no;
	
	
	private String dept_name;

}
