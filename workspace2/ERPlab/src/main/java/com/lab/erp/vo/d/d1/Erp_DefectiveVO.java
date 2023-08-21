package com.lab.erp.vo.d.d1;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_DefectiveVO {

	private int defactive_no;
	private String defective_comment;
	private int defective_number;
	private String defective_date;
	private int goodslot_no;
	private int ped_no;
	private int comcode_no;

}
