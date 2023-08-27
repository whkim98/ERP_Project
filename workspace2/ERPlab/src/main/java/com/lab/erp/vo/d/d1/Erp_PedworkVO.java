package com.lab.erp.vo.d.d1;

import java.util.List;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_PedworkVO {

	private int pedwork_no;
	private int ped_no;
	private int worktype_no;
	private int connectrequest_no;
	
	private List<Erp_PedworkVO> pwlist;

}
