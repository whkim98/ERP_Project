package com.lab.erp.vo.b.b6;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_SalaryVO {
	
	private int salary_no;
	private int ctgr_no;
	private String salary_code;
	private int employee2_no;
	private int salarytype_no;
	private String salary_date;
	private int comcode_no;

}
