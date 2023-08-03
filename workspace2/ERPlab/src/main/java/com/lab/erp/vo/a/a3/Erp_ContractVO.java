package com.lab.erp.vo.a.a3;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_ContractVO {

	private int contract_no;
	private String contract_name;
	private int contractkind_no;
	private String contract_start;
	private String contract_end;
	private int client_no;
	private String contract_content;
	private int project_no;
	private int comcode_no;

}
