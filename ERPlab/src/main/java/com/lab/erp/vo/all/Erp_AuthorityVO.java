package com.lab.erp.vo.all;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_AuthorityVO {
	private int authority_no;
	private String authority_code;
	private String authority_name;
}
