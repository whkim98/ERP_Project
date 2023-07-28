package com.lab.erp.vo.d.d1;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_ProinventoryVO {

	private int proinventory_no;
	private int goods_no;
	private int company_no;
	private int proinventory_actualstock;
	private int proinventory_recordedstock;
	private int proinventory_availability;
	private int proinventory_statue;
	private String proinventory_date;
	private int comcode_no;

}
