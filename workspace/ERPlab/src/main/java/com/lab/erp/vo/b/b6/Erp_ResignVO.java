package com.lab.erp.vo.b.b6;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_ResignVO {

	private int resign_no;
	private int ctgr_no;
	private String resign_code;
	private int employee2_no;
	private String resign_date;
	private int resign_cost;
	private int comcode_no;

}
