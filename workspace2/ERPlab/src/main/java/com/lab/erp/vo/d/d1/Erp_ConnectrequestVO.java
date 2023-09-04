package com.lab.erp.vo.d.d1;

import java.util.List;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_ConnectrequestVO {

	private int connectrequest_no;
	private int requestproduct_no;
	private int connectrequest_qty;
	private String goods_code;
	private String goods_barcode;
	private String goods_name;
	private int goodskind_no;
	private int goods_customerprice;
	private int goodslot_price;
	private String goods_description;
	private int client_no1;
	private int client_no2;
	private String goodsst_unit;
	private String goodsst_spec;
	private String goodsst_size;
	private String goodsst_package;
	private int goodsst_ea;
	
//	자신이 자료형이 되는 List 생성
	private List<Erp_ConnectrequestVO> crlist;
	private List<Erp_ConnectrequestVO> crlist1;
}
