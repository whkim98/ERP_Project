package com.lab.erp.vo.d.d2;

import java.util.List;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_PurchaseconnectVO {
	private int purchaseconnect_no;
	private int purchase_no;
	private int goodslot_no;
	private int purchaseconnect_number;
	private int purchaseconnect_price;
	private int purchaseconnect_tax;
	private int purchaseconnect_total;
	
	private List<Erp_PurchaseconnectVO> plist;
	private List<Erp_PurchaseconnectVO> plist1;
}
