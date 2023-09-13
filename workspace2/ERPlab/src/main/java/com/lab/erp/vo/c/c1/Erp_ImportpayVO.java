package com.lab.erp.vo.c.c1;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_ImportpayVO {

	private int importpay_no;
	private int ctgr_no;
	private String importpay_code;
	private int client_no;
	private int importorder_no;
	private String importpay_expiry;
	private int importpay_payable;
	private String importpay_paid;
	private int comcode_no;
	
	//거래처 테이블
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
	
	//수입테이블
	private String import_cino;
	private String import_blno;
	private int team_no;
	private String import_date;
	private int goods_no;
	private int import_qty;
	private int import_price;
	private int import_tax;
	private int import_total;
	private int incoterms_no;
	private int settletype_no;
	
	//상품테이블
	private String goods_code;
	private String goods_barcode;
	private String goods_name;
	private int goodskind_no;
	private int goods_price;
	private int goods_tax;
	private int goods_total;
	private int goods_customerprice;
	private String goods_description;
	private int goodsst_no;
	private String goods_production;
	private String goods_expiry;
	private int client_no1;
	private int client_no2;
	private int goods_stockqty;
	private String goodslev_no;
	private String goods_location;

}
