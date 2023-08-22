package com.lab.erp.vo.c.c1;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_ForsalesVO {

	private int forsales_no;
	private int ctgr_no;
	private String forsales_cino;
	private String forsales_blno;
	private int team_no;
	private int client_no;
	private String forsales_date;
	private int goods_no;
	private int forsales_qty;
	private int forsales_price;
	private int forsales_tax;
	private int forsales_total;
	private int incoterms_no;
	private int settletype_no;
	private int comcode_no;
	
	//팀테이블
	private int dept_no;
	private String team_code;
	private String team_name;
	
	//거래처테이블
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
	
	//상품테이블
	private String goods_code;
	private int goods_barcode;
	private String goods_name;
	private int goodskind_no;
	private int goods_customerprice;
	private String goods_description;
	private int goodsst_no;
	private int client_no1;
	private int client_no2;
	private int goods_stockqty;
	private String goodslev_no;
	private String goods_location;
	
	//incoterms 테이블
	private String incoterms_name;
	
	//settletype 테이블
	private String settletype_condition;
	private String settletype_type;


}
