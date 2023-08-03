package com.lab.erp.vo.b.b6;

import java.math.BigDecimal;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_SalarytypeVO {

	private int salarytype_no;
	private String salarytype_name;
	private BigDecimal salarytype_magnification;
}
