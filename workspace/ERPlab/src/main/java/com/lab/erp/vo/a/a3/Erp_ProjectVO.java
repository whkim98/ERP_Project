package com.lab.erp.vo.a.a3;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_ProjectVO {
	
	private int project_no;
	private String project_name;
	private int project_budget;
	private String project_start;
	private String project_end;	
	private int projectkind_no;
	private String project_contractor;	
	private int employee1_no;
	private int project_status;
	private String project_content;
	private int team_no;
	private int comcode_no;

}
