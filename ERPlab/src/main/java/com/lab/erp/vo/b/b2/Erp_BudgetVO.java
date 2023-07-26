package com.lab.erp.vo.b.b2;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_BudgetVO {
	
	private int budget_no;
	private String budget_type;
	private int team_no;
	private String budget_contents;
	private String budget_approved;
	private String budget_execution;
	private int budget_amount;
	private int budget_tax;
	private int budget_total;
	private int comcode_no;

}
