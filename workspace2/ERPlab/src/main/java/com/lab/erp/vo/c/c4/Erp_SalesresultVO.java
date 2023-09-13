package com.lab.erp.vo.c.c4;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Erp_SalesresultVO {

	 private int salesresult_no;
	 private int ctgr_no;
	 private String salesresult_start;
	 private String salesresult_end;
	 private int salesresult_goal;
	 private int forsales_no;
	 private int localsales_no;
	 private int storesales_no;
	 private int online_no;
	 private int salesresult_achieve;
	 private int comcode_no;

}
