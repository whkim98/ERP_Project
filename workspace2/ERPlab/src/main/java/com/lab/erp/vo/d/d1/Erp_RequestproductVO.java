package com.lab.erp.vo.d.d1;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_RequestproductVO {

	private int requestproduct_no;
	private String requestproduct_code;
	private int client_no;
	private String requestproduct_content;
	private String requestproduct_start;
	private String requestproduct_end;
	private String requestproduct_name;
	private int employee1_no;
	private int comcode_no;

}
