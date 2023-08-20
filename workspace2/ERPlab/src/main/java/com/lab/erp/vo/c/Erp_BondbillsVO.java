package com.lab.erp.vo.c;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_BondbillsVO {

	private int bondbills_no;
	private String bondbills_code;
	private int receivable_no;
	private String bondbills_date;
	private int bondbills_price;
	private int bondbills_tax;
	private int bondbills_total;
	
}
