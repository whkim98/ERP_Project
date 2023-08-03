package com.lab.erp.vo.b.b6;

import java.sql.Date;
import java.sql.Timestamp;

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
	private String salary_start;
	private String salary_end;
	private int comcode_no;
	private double salary_cash;

}
