package com.lab.erp.vo.login;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_EmphistoryVO {
	
	private int emphistory_no;
	private int employee1_no;
	private int team_no;
	private String emphistory_employeed;
	private String emphistory_resign;
	private int comcode_no;
	
}
