package com.lab.erp.vo.b.b2;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_CurrencyVO {
	
	private int currency_no;
	private int country_no;
	private String currency_name;
	private int currency_rate;
	
}
