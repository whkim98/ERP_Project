package com.lab.erp.vo.b.b6;

import java.math.BigDecimal;
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

	//직원2 테이블
	private int employee1_no;
	private int team_no;
	private String employee2_extension;
	private String employee2_position;
	private int employee2_exp;
	private int employee2_salary;
	private Double employee2_holiday;
	private int employee2_four;
	private String employee2_worktype;
	
	//수당종류 테이블
	private String salarytype_name;
	private BigDecimal salarytype_magnification;
	
	//bs1
	private int bs1_no;
	private String bs1_ctgr;
	private int bs1_amount;
	private String bs1_class;
	
	//bs2
	private int bs2_no;
	private String bs2_ctgr;
	private int bs2_amount;
	private String bs2_class;
	
	//bs3
	private int bs3_no;
	private String bs3_ctgr;
	private int bs3_amount;
	private String bs3_class;
	
	//creditor
	private int creditor_no;
	
	//debtor
	private int debtor_no;
	
	//closing
	private int closing_no;
	private String closing_code;
	private String closing_date;
	private int closing_debtor;
	private int closing_creditor;

	
	
}
