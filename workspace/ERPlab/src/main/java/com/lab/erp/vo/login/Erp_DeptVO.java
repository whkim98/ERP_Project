package com.lab.erp.vo.login;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_DeptVO {
	
	private int dept_no;
	private String dept_code;
	private String dept_name;
	private int comcode_no;

}
