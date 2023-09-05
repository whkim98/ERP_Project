package com.lab.erp.vo.c.c4;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_CustomerVO {

	private int customer_no;
	private int csgrade_no;
	private String customer_name;
	private String customer_addr1;
	private String customer_addr2;
	private String customer_postal;
	private String customer_phone;
	private String customer_comment;
	private int comcode_no;

}
