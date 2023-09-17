package com.lab.erp.vo.b.b3;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_CurrencyVO {
	
	private int currency_no;
	private int country_no;
	private String currency_name;
	private double currency_rate;
	private String currency_date;
	
}
