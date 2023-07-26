package com.lab.erp.vo.d.d4;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_QcVO {

	private int qc_no;
	private String qc_date;
	private int goods_no;
	private String qc_num;
	private String qc_clause;
	private String qc_grade;
	private int qc_result;
	private int qc_revalue;
	private String qc_remark;
	private int comcode_no;

}
