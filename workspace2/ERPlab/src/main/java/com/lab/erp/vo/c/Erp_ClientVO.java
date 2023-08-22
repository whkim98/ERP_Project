package com.lab.erp.vo.c;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_ClientVO {
	
	private int client_no;
	private int country_no;
	private String client_name;
	private int clientsort_no;
	private String client_registeredno;
	private String client_corporatedno;
	private String client_representative;
	private String client_businesstype;
	private int businesstype_no;
	private String client_addr1;
	private String client_addr2;
	private String client_postal;
	private String client_directno;
	private String client_fax;
	private String client_email;
	private String client_manager;
	private String client_contact;
	private int comcode_no;
	
// 국가===========================================
	
	private int country_code;
	private String country_name;
	
// 업종코드목록 ====================================
	
	private int businesstype_code;
	private String businesstype_name;
	private String businesstype_biotore;
	private String businesstype_ctgr;
	private String businesstype_subctgr;
	private String businesstype_description;

// 거래처종류 ======================================
	
	private String clientsort_name;
	
}
