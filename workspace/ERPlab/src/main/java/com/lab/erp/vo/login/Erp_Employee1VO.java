package com.lab.erp.vo.login;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_Employee1VO {
	private int employee1_no;
	private String employee1_code;
	private String employee1_name;
	private String employee1_addr1;
	private String employee1_addr2;
	private String employee1_postal;
	private String employee1_residentno;
	private String employee1_phone;
	private String employee1_email;
	private String employee1_id;
	private String employee1_pw;
	private int employee1_disability;
	private int employee1_merit;
	
//	직원2 컬럼 ======================================
	private int employee2_no;
	private int team_no;
	private String employee2_extension;
	private String employee2_position;
	private int employee2_exp;
	private int employee2_salary;
	private Double employee2_holiday;
	private int employee2_four;
	private String employee2_worktype;
	private int comcode_no;
	
//	퇴직 컬럼 =======================================
	
	private int resign_no;
	private int ctgr_no;
	private String resign_code;
	private int attendance_no;
	private String resign_date;
	private int resign_cost;
	
}
