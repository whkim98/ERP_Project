package com.lab.erp.vo.d.d1;

import java.util.List;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_PedVO {

	private int ped_no;
	private String ped_content;
	private String ped_date;
	private String ped_startdate;
	private int employee1_no;
	private int company_no;
	private int team_no;
	private int requestproduct_no;
	private int comcode_no;
	
	private List<Erp_PedVO> pdlist;

}
