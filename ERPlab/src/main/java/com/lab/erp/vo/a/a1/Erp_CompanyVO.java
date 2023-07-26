package com.lab.erp.vo.a.a1;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_CompanyVO {
	
	private int company_no;	
	
	private int comptype_no;
	
	private String company_name;
	private String company_registeredno;
	private String company_corporatedno;
	private String company_representative;
	private String company_businesstype;
	
	private int businesstype_no;
	private String company_addr1;
	private String company_addr2;
	private String company_postal;
	private String company_opendate;
	private String company_use;
	private int company_foreign;
	private String company_directno;
	private String company_fax;
	private String company_email;
	
}
