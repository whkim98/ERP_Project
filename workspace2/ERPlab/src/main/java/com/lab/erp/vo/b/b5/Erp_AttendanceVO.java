package com.lab.erp.vo.b.b5;

import java.math.BigDecimal;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_AttendanceVO {
	
	private int attendance_no;
	private int employee2_no;
	private int attendance_workdays;
	private int hdkind_no;
	private String attendance_usedate;
	private BigDecimal attendance_usedays;
	private BigDecimal attendance_approved;
	private int comcode_no;

}
