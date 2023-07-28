package com.lab.erp.vo.a.a3;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_EstimateVO {
	
	private int estimate_no;
	private int project_no;
	private int estimate_score;
	private String estimate_content;
	private String estimate_result;
	private String estimate_fact;
	
}
