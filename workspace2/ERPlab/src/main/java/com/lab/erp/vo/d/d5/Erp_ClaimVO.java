package com.lab.erp.vo.d.d5;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_ClaimVO {

	private int claim_no;
	private String claim_date;
	private int client_no;
	private String claim_manager;
	private int cvalue_no;
	private String claim_contents;
	private String claim_response;
	private int claim_handle;
	private int comcode_no;

}
