package com.lab.erp.vo.a.a1;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_BusinesstypeVO {
	
	private int businesstype_no;
	private int businesstype_code;
	private String businesstype_name;
	private String businesstype_biotore;
	private String businesstype_ctgr;
	private String businesstype_subctgr;
	private String businesstype_description;
	private int comcode_no;

}
